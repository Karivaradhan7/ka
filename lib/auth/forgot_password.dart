import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wm_app/utils/components/text_button.dart';
import 'package:wm_app/utils/components/text_field.dart';
import 'package:wm_app/utils/constants/colors.dart';

import '../utils/components/show_toast.dart';
import '../utils/constants/api_constants.dart';
import 'otp_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  Future<void> generateOTP(String email) async {
    try {
      final dio = Dio();

      // Set up Dio options
      dio.options.baseUrl = ApiConstants().base;
      dio.options.connectTimeout = const Duration(milliseconds: 10000);
      dio.options.receiveTimeout = const Duration(milliseconds: 10000);
      dio.options.sendTimeout = const Duration(milliseconds: 10000);

      // Make the HTTP POST request
      final response = await dio.post(
        ApiConstants().forgotPassword,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
          validateStatus: (status) => status! < 1000,
        ),
        data: {
          "email": email,
        },
      );

      // Check response status code
      if (response.statusCode == 200) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("userEmail", email);
        showToast("OTP sent successfully");
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => const OtpPage(),
          ),
        );
      } else {
        // If OTP generation fails, show an error message
        showToast("Failed to send OTP. Please try again later.");
      }
    } catch (e) {
      // Catch any errors that occur during the process
      showToast("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.oxfordBlue,
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Card(
                margin: const EdgeInsets.all(20.0),
                color: MyColors.platinum,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextField(
                        controller: _emailController,
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Colors.black),
                        validator: _emailValidator,
                        labelText: 'Email',
                        hintText: 'Enter your Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        enabled: true,
                      ),
                      const SizedBox(height: 20),
                      MyButton(
                        onTap: () {
                          generateOTP(_emailController.text);
                        },
                        text: 'Next',
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
