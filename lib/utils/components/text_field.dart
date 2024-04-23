import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import TextInputFormatter
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final Widget prefixIcon;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    required this.enabled,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50), // Apply subtle curvature
        color: MyColors.platinum, // Use platinum color from MyColors
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Add subtle elevation
            blurRadius: 4.0,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        textAlign: TextAlign.start,
        style: GoogleFonts.sourceCodePro(
          color: MyColors.black, // Use black color from MyColors
        ),
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        inputFormatters: inputFormatters, // Pass inputFormatters directly
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          enabled: enabled,
          filled: true,
          fillColor: MyColors.white, // Use white color from MyColors
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: MyColors.oxfordBlue, // Use Oxford Blue color from MyColors
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red, // Use error color
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red, // Use error color
            ),
          ),
          labelStyle: GoogleFonts.raleway(
            color: MyColors.black, // Use black color from MyColors
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
      ),
    );
  }
}
