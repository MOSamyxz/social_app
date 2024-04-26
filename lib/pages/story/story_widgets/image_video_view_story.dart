import 'dart:io';

import 'package:chatapp/pages/story/story_widgets/video_view_story.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageVideoViewStory extends StatelessWidget {
  const ImageVideoViewStory({
    Key? key,
    required this.fileType,
    required this.file,
    this.onPressed,
  }) : super(key: key);

  final String fileType;
  final File file;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        fileType == 'postMediaImage' || fileType == 'image'
            ? Image.file(file)
            : VideoViewStory(
                video: file,
              ),
        IconButton(
            onPressed: onPressed, icon: const FaIcon(FontAwesomeIcons.xmark))
      ],
    );
  }
}
