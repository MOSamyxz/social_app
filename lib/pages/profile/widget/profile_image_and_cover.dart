import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImageAndCover extends StatelessWidget {
  const ProfileImageAndCover({
    super.key,
    required this.user,
  });

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight * 0.25,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user.coverUrl!),
                      ),
                    )),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: AppSize.r55,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              CircleAvatar(
                radius: AppSize.r50,
                backgroundImage: NetworkImage(user.imageUrl),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
