import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wm_app/utils/components/text_button.dart';
import 'package:wm_app/utils/components/text_field.dart';

import '../utils/components/show_toast.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/colors.dart';
import 'login_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool isPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isLoading = false;

  String? _passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (value.contains(' ')) {
      return 'Password cannot contain spaces';
    }
    return null;
  }

  String? _otpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP';
    }

    if (value.length != 6) {
      return 'OTP must be 6 digits long';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'OTP must contain only digits';
    }

    return null;
  }

  Future<void> otpVerify(String password, String otp) async {
    try {
      setState(() {
        isLoading = true;
      });

      SharedPreferences sp = await SharedPreferences.getInstance();
      String? email = sp.getString('userEmail');

      final dio = Dio();

      dio.options = BaseOptions(
        baseUrl: ApiConstants().base,
        connectTimeout: const Duration(milliseconds: 10 * 1000),
        receiveTimeout: const Duration(milliseconds: 10 * 1000),
        sendTimeout: const Duration(milliseconds: 10 * 1000),
      );

      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: print,
        ),
      );

      final response = await dio.post(
        ApiConstants().verifyOTP,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
          validateStatus: (status) => status! < 1000,
        ),
        data: {
          "email": email,
          "password": password,
          "otp": otp,
        },
      );

      if (response.statusCode == 200) {
        showToast("Verified Successfully !");
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
        );
      } else if (response.statusCode == 401) {
        showToast("OTP not found");
      } else {
        showToast("Internal Server Error");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        showToast("Connection timeout. Please try again later.: $e");
        if (kDebugMode) {
          print("Connection timeout. Please try again later.: $e");
        }
      } else if (e.type == DioExceptionType.badResponse) {
        showToast(
            "Error ${e.response?.statusCode}: ${e.response?.statusMessage}");
      } else {
        showToast("An error occurred: $e");
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.oxfordBlue,
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Card(
                color: MyColors.orangeWeb,
                margin: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextField(
                        controller: _otpController,
                        prefixIcon: const Icon(Icons.password_rounded,
                            color: Colors.white),
                        validator: _otpValidator,
                        labelText: 'OTP',
                        hintText: 'Enter your 6 digit OTP',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        enabled: true,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: _passwordController,
                        prefixIcon: const Icon(Icons.lock_rounded,
                            color: Colors.white),
                        keyboardType: TextInputType.visiblePassword,
                        validator: _passwordValidator,
                        labelText: 'Password',
                        hintText: 'Please enter your password',
                        obscureText: !isPasswordVisible,
                        enabled: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: _confirmPasswordController,
                        prefixIcon: const Icon(Icons.lock_rounded,
                            color: Colors.white),
                        keyboardType: TextInputType.visiblePassword,
                        validator: _passwordValidator,
                        labelText: 'Confirm Password',
                        hintText: 'Please reenter your password',
                        obscureText: !isNewPasswordVisible,
                        enabled: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isNewPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isNewPasswordVisible = !isNewPasswordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyButton(
                        onTap: () {
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            showToast("Passwords do not match");
                            return;
                          } else {
                            otpVerify(
                              _passwordController.text,
                              _otpController.text,
                            );
                          }
                        },
                        text: 'Verify',
                        icon: null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}