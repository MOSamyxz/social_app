import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingCategory extends StatelessWidget {
  const SettingCategory({
    super.key,
    required this.title,
    this.fontSize,
    this.fontWeight,
  });
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: AppPadding.screenPadding,
      height: AppSize.s30,
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize ?? 16.sp, fontWeight: fontWeight),
      ),
    );
  }
}
