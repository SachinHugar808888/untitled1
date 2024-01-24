import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double borderRadius;
  final double padding;
  final double fontSize;
  final double minWidth;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.borderRadius = 8.0,
    this.padding = 12.0,
    this.fontSize = 16.0,
    this.minWidth = 200.0, // Adjust the minWidth as needed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(padding),
        minimumSize: Size(minWidth, padding * 3), // Adjust the multiplier as needed
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
