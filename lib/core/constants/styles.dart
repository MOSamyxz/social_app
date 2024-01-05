import 'package:chatapp/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static TextStyle font24BoldWhite = TextStyle(
      fontWeight: AppFontWeight.bold,
      fontSize: 28.sp,
      color: AppColors.realWhiteColor);

  static TextStyle font24BoldBlack = TextStyle(
      fontWeight: AppFontWeight.bold,
      fontSize: 28.sp,
      color: AppColors.blackColor);

  static TextStyle font14MediumlighterBlack = TextStyle(
    fontWeight: AppFontWeight.medium,
    fontSize: 14.sp,
    color: AppColors.lightBlackColor,
  );

  static TextStyle font16RegularlighterBlack = TextStyle(
    fontWeight: AppFontWeight.regular,
    fontSize: 16.sp,
    color: AppColors.lighterBlackColor,
  );

  static TextStyle font14RegularlighterBlack = TextStyle(
    fontWeight: AppFontWeight.regular,
    fontSize: 14.sp,
    color: AppColors.lighterBlackColor,
  );
}

class AppFontWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
