import 'package:chatapp/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField({
    super.key,
    required this.hintText,
    this.validator,
    this.controller,
    this.suffix,
    this.suffixPressed,
    this.isPassword = false,
  });
  final bool isPassword;
  final IconData? suffix;
  final void Function()? suffixPressed;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
            ),
          ),
          label: Text(
            hintText,
            style: const TextStyle(color: Color.fromARGB(255, 194, 191, 199)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: AppColors.blueColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: AppColors.blueColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: AppColors.red),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: AppColors.borderColor)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
        ),
        validator: validator);
  }
}
