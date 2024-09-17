import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData suffixIcon;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  // Make FocusNode optional

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.suffixIcon,
    required this.keyboardType,
    this.focusNode,
    // Update the constructor to accept focusNode
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode, // Set the provided focusNode
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.green),
          // Customize the border color when focused
        ),
        suffixIcon: Icon(suffixIcon),
      ),
      keyboardType: keyboardType,
    );
  }
}
