import 'package:flutter/material.dart';
import 'package:waste_management/screens/reset_password.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  OTPVerificationScreen({required this.email});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  void _verifyOTP() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Verified Successfully!")),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(email: widget.email),
        ),
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

          // Centered OTP Verification Card
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
                        // Security Icon
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.green.shade100,
                          child: Icon(Icons.security, size: 80, color: Colors.green.shade700),
                        ),
                        SizedBox(height: 10),

                        // Title
                        Text(
                          "Enter OTP",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                        ),
                        SizedBox(height: 5),

                        // Instruction
                        Text(
                          "We have sent an OTP to ${widget.email}. Please enter the 6-digit OTP.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                        ),
                        SizedBox(height: 20),

                        // OTP Verification Form
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // OTP Input
                              TextFormField(
                                controller: otpController,
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(letterSpacing: 10, fontSize: 18, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  counterText: "",
                                  labelText: "Enter OTP",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: Icon(Icons.numbers, color: Colors.green.shade700),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return "Please enter OTP";
                                  if (value.length != 6) return "OTP must be 6 digits";
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),

                              // Verify OTP Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _verifyOTP,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade700,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                  ),
                                  child: Text("Verify OTP", style: TextStyle(fontSize: 18, color: Colors.white)),
                                ),
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
