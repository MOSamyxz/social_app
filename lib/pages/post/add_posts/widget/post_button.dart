import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  const PostButton({
    super.key,
    required this.user,
    required this.text,
    required this.onPressed,
  });

  final UsersModel user;
  final String text;
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
        child: Text(text));
  }
}
