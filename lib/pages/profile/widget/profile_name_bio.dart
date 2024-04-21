import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileNameBio extends StatelessWidget {
  const ProfileNameBio({
    super.key,
    required this.user,
  });

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(user.userName),
              const HorizontalSpace(2),
              user.isVerified
                  ? Icon(
                      Icons.verified,
                      color: AppColors.blueColor,
                      size: AppSize.r15,
                    )
                  : const SizedBox()
            ],
          ),
          VerticalSpace(5.h),
          SizedBox(
              width: ScreenUtil().screenWidth * .75, child: Text(user.bio)),
        ],
      ),
    );
  }
}
