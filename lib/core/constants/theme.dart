import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.blueColor,
  fontFamily: AppStyles.fontFamily,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightScaffoldColor,
  cardTheme: const CardTheme(
      color: AppColors.realWhiteColor,
      elevation: 0.1,
      shadowColor: AppColors.lighterBlackColor),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontWeight: AppFontWeight.bold,
      fontSize: 40.sp,
    ),
    headlineLarge: TextStyle(),
    headlineMedium: TextStyle(
      fontWeight: AppFontWeight.bold,
      fontSize: 28.sp,
    ),
    labelMedium: TextStyle(
      fontWeight: AppFontWeight.regular,
      fontSize: 16.sp,
    ),
    labelSmall: TextStyle(fontSize: 10.sp, color: AppColors.lightDateCardColor),
    bodyMedium: TextStyle(
      fontWeight: AppFontWeight.medium,
      fontSize: 14.sp,
    ),
    bodySmall: TextStyle(
      fontWeight: AppFontWeight.regular,
      fontSize: 14.sp,
    ),
  ),
);
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.lightBlueColor,
  fontFamily: AppStyles.fontFamily,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkScaffoldColor,
  cardTheme: const CardTheme(
      color: AppColors.darkCardColor,
      elevation: 0.1,
      shadowColor: AppColors.lighterBlackColor),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontWeight: AppFontWeight.bold,
      fontSize: 40.sp,
    ),
    headlineLarge: TextStyle(),
    headlineMedium: TextStyle(
      fontWeight: AppFontWeight.bold,
      fontSize: 28.sp,
    ),
    labelMedium: TextStyle(
      fontWeight: AppFontWeight.regular,
      fontSize: 16.sp,
    ),
    labelSmall: TextStyle(fontSize: 10.sp, color: AppColors.darkDateCardColor),
    bodyMedium: TextStyle(
      fontWeight: AppFontWeight.medium,
      fontSize: 14.sp,
    ),
    bodySmall: TextStyle(
      fontWeight: AppFontWeight.regular,
      fontSize: 14.sp,
    ),
  ),
);
