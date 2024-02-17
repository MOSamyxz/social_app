import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/pages/post/add_posts/add_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeFAB extends StatelessWidget {
  const HomeFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        foregroundColor: AppColors.realWhiteColor,
        backgroundColor: AppColors.blueColor,
        child: const FaIcon(
          FontAwesomeIcons.penToSquare,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()));
        });
  }
}
