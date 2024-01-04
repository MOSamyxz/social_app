import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount(
      {super.key,
      required this.info,
      required this.buttonText,
      required this.onPressed});

  final String info;
  final String buttonText;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            info,
            style: const TextStyle(color: AppColors.blackColor),
          ),
        ),
        MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.r12), // <-- Radius
          ),
          color: AppColors.blueColor,
          child: Text(
            buttonText,
            style: const TextStyle(color: AppColors.realWhiteColor),
          ),
        )
      ],
    );
  }
}
