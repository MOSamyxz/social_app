import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50.h,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.r12), // <-- Radius
      ),
      color: AppColors.blueColor,
      child: Text(
        text,
        style: const TextStyle(color: AppColors.realWhiteColor),
      ),
    );
  }
}
