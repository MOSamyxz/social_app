import 'package:chatapp/data/model/post_model.dart';
import 'package:flutter/material.dart';

class PostImageItem extends StatelessWidget {
  const PostImageItem({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Image.network(post.fileUrl!),
    );
  }
}
