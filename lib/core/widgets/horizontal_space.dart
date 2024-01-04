import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace(
    this.w, {
    super.key,
  });
  final double w;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: w.w,
    );
  }
}
