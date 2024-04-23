import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class MyDropdownFormField extends StatelessWidget {
  final String? value;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>> items;
  final Widget prefixIcon;
  final String labelText;
  final String hintText;

  const MyDropdownFormField({
    super.key,
    this.value,
    this.validator,
    this.onChanged,
    required this.items,
    required this.prefixIcon,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: MyColors.platinum,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4.0,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          enabled: true,
          filled: true,
          fillColor: MyColors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: MyColors.oxfordBlue,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          labelStyle: GoogleFonts.raleway(
            color: MyColors.csvBlack,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
        dropdownColor: MyColors.platinum,
        style: const TextStyle(color: MyColors.csvBlack),
        onChanged: onChanged,
        validator: validator,
        items: items,
      ),
    );
  }
}
