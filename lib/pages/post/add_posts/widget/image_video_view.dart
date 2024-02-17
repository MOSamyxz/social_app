import 'dart:io';

import 'package:chatapp/pages/post/add_posts/widget/video_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageVideoView extends StatelessWidget {
  const ImageVideoView({
    Key? key,
    required this.fileType,
    required this.file,
    required this.onPressed,
  }) : super(key: key);

  final String fileType;
  final File file;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        fileType == 'postMediaImage'
            ? Image.file(file)
            : VideoView(
                video: file,
              ),
        IconButton(
            onPressed: onPressed, icon: const FaIcon(FontAwesomeIcons.xmark))
      ],
    );
  }
}
