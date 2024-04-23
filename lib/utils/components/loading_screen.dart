import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatelessWidget {
  final String message;

  const LoadingScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Customized CircularProgressIndicator
            const SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                strokeWidth: 3.0, // Set the stroke width
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Change color to blue
              ),
            ),
            const SizedBox(height: 16.0),
            // Customized text message
            Text(
              message,
              style: GoogleFonts.roboto( // Use Google Fonts for text style
                color: Colors.blue, // Change text color to blue
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
