import 'package:chatapp/core/constants/colors.dart';
import 'package:flutter/widgets.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });
  final Function() onTap;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Text(
          buttonText,
          style: const TextStyle(color: AppColors.blueColor),
        ));
  }
}
