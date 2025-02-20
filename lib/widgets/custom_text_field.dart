import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isEmail;
  final int? maxLines;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.isEmail = false,
    this.maxLines,
  }) : super(key: key);

  static const Color _orangeColor = Color(0xFFFF9D23);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _orangeColor, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$hint is required";
          }
          if (isEmail &&
              !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                  .hasMatch(value)) {
            return "Enter a valid email";
          }
          return null;
        },
      ),
    );
  }
} 