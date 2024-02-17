import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownFormField extends StatelessWidget {
  const CustomDropDownFormField({
    super.key,
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
    this.prefix,
  });
  final String value;
  final String label;
  final IconData? prefix;

  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
            label: Text(label),
            prefixIcon: Icon(
              size: AppSize.r20,
              prefix,
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
                borderSide: const BorderSide(color: AppColors.borderColor))),
        hint: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            value,
            style: const TextStyle(
              color: Color.fromARGB(255, 194, 191, 199),
            ),
          ),
        ),
        items: items,
        onChanged: onChanged);
  }
}
