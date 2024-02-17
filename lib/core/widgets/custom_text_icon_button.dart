import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextIconButton extends StatelessWidget {
  const CustomTextIconButton({
    super.key,
    required this.icon,
    required this.data,
    required this.onPressed,
  });
  final IconData icon;
  final String data;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.r12), // <-- Radius
        ),
        color: AppColors.blueColor,
        minWidth: 30,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: AppSize.s20),
            const HorizontalSpace(5),
            Text(data),
          ],
        ));
  }
}
