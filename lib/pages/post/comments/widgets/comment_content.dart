import 'package:chatapp/data/model/comment_model.dart';
import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comments[index].authorName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        Text(
          comments[index].text,
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }
}
