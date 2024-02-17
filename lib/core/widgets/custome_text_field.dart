import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
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
    this.isShowCursor = true,
    this.isReadOnly = false,
    this.prefix,
    this.onSubmit,
    this.onChange,
    this.onTab,
    this.inputType,
  });

  final bool isPassword;
  final IconData? suffix;
  final void Function()? suffixPressed;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final IconData? prefix;
  final bool isShowCursor;
  final bool isReadOnly;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final Function()? onTab;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: isReadOnly,
        showCursor: isShowCursor,
        keyboardType: inputType,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTab,
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            size: AppSize.r20,
            prefix,
          ),
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
