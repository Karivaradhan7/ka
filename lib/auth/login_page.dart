import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wm_app/auth/forgot_password.dart';
import 'package:wm_app/auth/otp_page.dart';
import 'package:wm_app/utils/components/show_toast.dart';
import 'package:wm_app/utils/components/text_button.dart';
import 'package:wm_app/utils/components/text_field.dart';
import 'package:wm_app/utils/constants/colors.dart';
import '../core/LoginMaster/home_page.dart';
import '../core/admin/admin_home_screen.dart';
import '../core/employee/emp_home_screen.dart';
import '../utils/constants/api_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLogin = false;

  bool _isPasswordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = false;
      _isPasswordVisible = false;
    });

    SharedPreferences.getInstance().then((sp) {
      if (sp.containsKey('userEmail')) {
        _emailController.text = sp.getString('userEmail')!;
      }
    });
  }

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

  String? _passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your Password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  Future<String?> _login() async {
    try {
      setState(() {
        isLoading = true;
      });

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

      if (kDebugMode) {
        print("Sending login request to the server...");
      }

      final response = await dio.post(
        ApiConstants().login,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
          validateStatus: (status) => status! < 1000,
        ),
        data: {
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
        },
      );

      if (kDebugMode) {
        print(response.data);
      }

      SharedPreferences sp = await SharedPreferences.getInstance();
      const storage = FlutterSecureStorage();

      if (response.statusCode == 200 || response.statusCode == 201) {
        sp.setString("userEmail", _emailController.text);
        sp.setString("userName", response.data['userData']['username']);
        sp.setString(
            "userRole", response.data['userData']['userRole'].toString());
        sp.setString("SECRET_TOKEN", response.data['token']);
        sp.setBool("isLogin", true);

        await storage.write(key: 'isLogin', value: 'true');

        if (kDebugMode) {
          print('userRole============');
          print(response.data['userData']['userRole'].toString());
        }

        if (response.statusCode == 200) {
          return response.data['userData']['userRole'].toString();
        } else if (response.statusCode == 201) {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => const OtpPage(),
            ),
          );
        } else if (response.statusCode == 400) {
          showToast("Please check your credentials.");
        } else if (response.statusCode == 401) {
          showToast("You are not authorized");
        } else if (response.data != null && response.data['error'] != null) {
          showToast(response.data['error']);
        } else if (response.statusCode == 500) {
          showToast("Internal server error");
        } else {
          showToast("Something went wrong. Please try again later.");
        }
      }
      return null;
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

      return null;
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
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Content fits within screen
              children: [
                Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: MyColors.orangeWeb, // Oxford blue card
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: MyColors.black, // White title
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        MyTextField(
                          controller: _emailController,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: MyColors.withHashOrangeWeb,
                          ),
                          validator: _emailValidator,
                          labelText: 'Email',
                          hintText: 'Enter your Email',
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          enabled: true,
                        ),
                        const SizedBox(height: 20.0),
                        MyTextField(
                          controller: _passwordController,
                          prefixIcon: const Icon(Icons.lock_rounded,
                              color: MyColors.withHashOrangeWeb),
                          keyboardType: TextInputType.visiblePassword,
                          validator: _passwordValidator,
                          labelText: 'Password',
                          hintText: 'Please enter your password',
                          obscureText: !_isPasswordVisible,
                          enabled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: MyColors.withHashOrangeWeb,
                              size: 25.0,
                            ),
                            onPressed: () => setState(
                                    () => _isPasswordVisible = !_isPasswordVisible),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        MyButton(
                          onTap: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              _login().then(
                                (res) {
                                  if (res == "0") {
                                    Navigator.of(context).pushReplacement(
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const AdminHomeScreen(),
                                      ),
                                    );
                                  } else if (res == "1") {
                                    Navigator.of(context).pushReplacement(
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const LMHomePage(),
                                      ),
                                    );
                                  } else if (res == "2") {
                                    Navigator.of(context).pushReplacement(
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const EmpHomeScreen(),
                                      ),
                                    );
                                  }
                                },
                              );
                            }
                          },
                          text: 'Login',
                          icon: null,
                          borderColor: MyColors.withHashOrangeWeb,
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordPage()),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: MyColors
                                  .black, // White text for Forgot Password
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
