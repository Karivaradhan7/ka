import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final List<BoxShadow> boxShadow;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;

  const MyButton({
    super.key,
    required this.onTap,
    this.borderColor,
    required this.text,
    this.width = 150.0,
    this.height = 50.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.boxShadow = const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 2),
        blurRadius: 4.0,
      ),
    ],
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), required IconData? icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: MyColors.oxfordBlue, // Use Oxford Blue color from MyColors
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          border: borderColor != null ? Border.all(color: borderColor!, width: 2.0) : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: MyColors.white.withOpacity(0.3), // Use white color from MyColors
            highlightColor: Colors.transparent,
            onTap: onTap,
            borderRadius: borderRadius,
            child: Center(
              child: Padding(
                padding: padding,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: MyColors.orangeWeb, // Use Orange Web color from MyColors
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
