import 'package:chatapp/core/utils/get_time.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:flutter/material.dart';

class TimeFromNow extends StatelessWidget {
  const TimeFromNow({super.key, required this.post, this.isSaved = false});

  final Post post;
  final bool isSaved;
  @override
  Widget build(BuildContext context) {
    return Text(
      getTimeText(isSaved ? post.savedAt! : post.createdAt, context, false),
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}
