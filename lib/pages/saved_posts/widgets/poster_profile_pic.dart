import 'package:chatapp/data/model/post_model.dart';
import 'package:flutter/material.dart';

class PosterProfilePic extends StatelessWidget {
  const PosterProfilePic({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Image.network(
        post.posterProfileUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
