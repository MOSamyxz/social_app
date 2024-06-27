import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/story/add_story_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddStoryItem extends StatelessWidget {
  const AddStoryItem({
    super.key,
    required this.myUser,
  });
  final UsersModel myUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 95,
                    height: 95,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              AppColors.darkBlueColor,
                              AppColors.lighterBlueColor
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight),
                        borderRadius: BorderRadius.circular(95)),
                  ),
                  CircleAvatar(
                    radius: AppSize.r44,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(myUser.imageUrl),
                    radius: AppSize.r40,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddStoryScreen(
                                myUser: myUser,
                              )));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: AppSize.r20,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                    CircleAvatar(
                        radius: AppSize.r15,
                        backgroundColor: AppColors.greyColor,
                        child: const FaIcon(
                          FontAwesomeIcons.plus,
                          color: AppColors.blackColor,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const VerticalSpace(5),
          const Text('Add Story')
        ],
      ),
    );
  }
}
