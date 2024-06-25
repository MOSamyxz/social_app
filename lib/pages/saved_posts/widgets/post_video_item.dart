import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/pages/home/widget/post_widgets/video_view_saved.dart';
import 'package:flutter/material.dart';

class PostVideoItem extends StatelessWidget {
  const PostVideoItem({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: VideoViewSaved(
        aspectRatio: 1,
        video: Uri.parse(post.fileUrl!),
        isSearchView: false,
      ),
    );
  }
}
