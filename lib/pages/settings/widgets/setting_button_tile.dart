import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingButtonTile extends StatelessWidget {
  const SettingButtonTile({
    super.key,
    required this.leadingIcon,
    required this.leadingTitle,
    this.onTap,
    this.trillingText,
  });
  final IconData leadingIcon;
  final void Function()? onTap;

  final String leadingTitle;
  final String? trillingText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSize.s50,
        decoration: BoxDecoration(color: Theme.of(context).cardTheme.color),
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Row(
            children: [
              Icon(
                leadingIcon,
                size: AppSize.s20,
              ),
              const HorizontalSpace(5),
              Text(
                leadingTitle,
                style: TextStyle(fontSize: 16.sp),
              ),
              const Spacer(),
              trillingText == null
                  ? const Icon(Icons.arrow_forward_ios)
                  : Text(trillingText!)
            ],
          ),
        ),
      ),
    );
  }
}
