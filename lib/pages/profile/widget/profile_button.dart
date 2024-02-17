import 'package:chatapp/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.textColor,
    required this.text,
  });
  final void Function() onPressed;
  final Color color;
  final Color textColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 30.h,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.r12), // <-- Radius
      ),
      color: color,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
