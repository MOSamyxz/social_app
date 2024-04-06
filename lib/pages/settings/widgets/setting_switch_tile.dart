import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingSwitchTile extends StatelessWidget {
  const SettingSwitchTile({
    super.key,
    required this.leadingIcon,
    this.firstSwitchIcon,
    this.secondeSwitchIcon,
    required this.leadingTitle,
    required this.currentValue,
    this.onChanged,
    this.firstTextIcon,
    this.secondeTextIcon,
  });
  final IconData leadingIcon;
  final IconData? firstSwitchIcon;
  final IconData? secondeSwitchIcon;
  final String? firstTextIcon;
  final String? secondeTextIcon;
  final String leadingTitle;
  final int currentValue;
  final void Function(int)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            AnimatedToggleSwitch<int>.rolling(
              height: AppSize.s30,
              indicatorSize: const Size.fromWidth(45.0),
              style: const ToggleStyle(
                  borderColor: AppColors.blueColor,
                  indicatorColor: AppColors.blueColor),
              current: currentValue,
              values: const [0, 1],
              onChanged: onChanged,
              iconBuilder: (int value, bool current) {
                if (firstSwitchIcon != null) {
                  return value == 0
                      ? FaIcon(firstSwitchIcon,
                          color: current ? AppColors.whiteColor : Colors.grey)
                      : FaIcon(secondeSwitchIcon,
                          color: current ? AppColors.whiteColor : Colors.grey);
                } else {
                  return value == 0
                      ? Text(
                          firstTextIcon!,
                          style: TextStyle(
                              color:
                                  current ? AppColors.whiteColor : Colors.grey),
                        )
                      : Text(
                          secondeTextIcon!,
                          style: TextStyle(
                              color:
                                  current ? AppColors.whiteColor : Colors.grey),
                        );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
