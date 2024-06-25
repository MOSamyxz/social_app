import 'package:chatapp/core/utils/get_time.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:flutter/material.dart';

class SavedPostDetails extends StatelessWidget {
  const SavedPostDetails({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.posterName),
          Text(
            post.content,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(post.postType == 'post'
                  ? 'Post'
                  : post.postType == 'postMediaImage'
                      ? 'Image'
                      : 'Video'),
              const Text(' ● '),
              Text(getTimeText(post.savedAt!, context, true))
            ],
          ),
        ],
      ),
    );
  }
}
