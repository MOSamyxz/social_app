import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostCardButton extends StatelessWidget {
  const PostCardButton({
    super.key,
    required this.text,
    this.image,
    required this.onPressed,
    this.icon,
    this.color,
  });
  final String text;
  final String? image;
  final void Function() onPressed;
  final IconData? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HorizontalSpace(5),
          image == null
              ? Padding(
                  padding: const EdgeInsets.only(right: AppSize.s5),
                  child: FaIcon(
                    icon,
                    size: AppSize.s20,
                    color: color ?? AppColors.darkGreyColor,
                  ),
                )
              : Image.asset(
                  image!,
                  width: AppSize.r25,
                ),
          const HorizontalSpace(5),
          Text(
            text,
            style: TextStyle(
                fontSize: 17.sp, color: color ?? AppColors.darkGreyColor),
          ),
        ],
      ),
    );
  }
}
