import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentContent extends StatelessWidget {
  const CommentContent({
    super.key,
    required this.comments,
    required this.index,
  });
  final List<CommentModel> comments;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<dynamic> verifiedMembers =
        BlocProvider.of<AppCubit>(context).verifiedMembers;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              comments[index].authorName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            const HorizontalSpace(2),
            verifiedMembers.contains(comments[index].authorId)
                ? Icon(
                    Icons.verified,
                    color: AppColors.blueColor,
                    size: AppSize.r15,
                  )
                : const SizedBox()
          ],
        ),
        Text(
          comments[index].text,
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }
}
