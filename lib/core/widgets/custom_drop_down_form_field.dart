import 'package:chatapp/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomDropDownFormField extends StatelessWidget {
  const CustomDropDownFormField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });
  final String value;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
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
                borderSide: const BorderSide(color: AppColors.borderColor))),
        hint: Text(
          value,
          style: const TextStyle(
            color: Color.fromARGB(255, 194, 191, 199),
          ),
        ),
        items: items,
        onChanged: onChanged);
  }
}
