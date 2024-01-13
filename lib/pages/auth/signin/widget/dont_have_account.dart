import 'package:chatapp/core/widgets/custom_text_button.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:flutter/material.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount(
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          info,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const HorizontalSpace(5),
        CustomTextButton(
          onTap: onPressed,
          //  shape: RoundedRectangleBorder(
          //    borderRadius: BorderRadius.circular(AppSize.r12), // <-- Radius
          //  ),
          //  color: AppColors.blueColor,
          buttonText: buttonText,
        )
      ],
    );
  }
}
