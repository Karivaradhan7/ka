import 'package:flutter/material.dart';
import 'package:waste_management/screens/forgot_password.dart';
import 'package:waste_management/screens/signup_screen.dart';
import 'package:waste_management/screens/role_selection.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RoleSelectionScreen()), // Redirect to Role Selection Page
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade800, Colors.green.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Centered Login Card
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: screenWidth > 400 ? 380 : double.infinity,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo Icon
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.green.shade100,
                          child: Icon(Icons.account_circle, size: 80, color: Colors.green.shade700),
                        ),
                        SizedBox(height: 10),

                        // Login Title
                        Text(
                          "Welcome Back!",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                        ),
                        SizedBox(height: 5),

                        Text(
                          "Login to continue",
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                        ),
                        SizedBox(height: 20),

                        // Login Form
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Email Input
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: Icon(Icons.email, color: Colors.green.shade700),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return "Enter your email";
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "Enter a valid email";
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),

                              // Password Input
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: Icon(Icons.lock, color: Colors.green.shade700),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return "Enter your password";
                                  if (value.length < 6) return "Password must be at least 6 characters";
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),

                              // Forgot Password Button
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                                    );
                                  },
                                  child: Text("Forgot Password?", style: TextStyle(color: Colors.green.shade700)),
                                ),
                              ),
                              SizedBox(height: 15),

                              // Login Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade700,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                  ),
                                  child: Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
                                ),
                              ),
                              SizedBox(height: 15),

                              // Sign Up Link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Facility Registration? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignupScreen()),
                                      );
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade700),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
