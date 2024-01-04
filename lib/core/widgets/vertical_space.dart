import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSpace extends StatelessWidget {
  const VerticalSpace(
    this.h, {
    super.key,
  });
  final double h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h.h,
    );
  }
}
