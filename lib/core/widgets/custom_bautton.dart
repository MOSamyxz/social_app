import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.height,
    this.width,
    this.radius,
  });
  final void Function() onPressed;
  final Color? color;
  final double? height;
  final double? radius;
  final double? width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width ?? double.infinity,
      height: height ?? 50.h,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(radius ?? AppSize.r12), // <-- Radius
      ),
      color: color ?? AppColors.blueColor,
      child: child,
    );
  }
}
