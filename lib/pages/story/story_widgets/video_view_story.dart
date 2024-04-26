import 'dart:io';

import 'package:chatapp/pages/story/cubit/story_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoViewStory extends StatefulWidget {
  const VideoViewStory({
    super.key,
    required this.video,
  });

  final File video;

  @override
  State<VideoViewStory> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoViewStory> {
  late final VideoPlayerController _videoController;

  bool isPlaying = false;
  bool isShow = true;

  @override
  void initState() {
    _videoController = VideoPlayerController.file(widget.video)
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StoryCubit>(context)
        .getDuration(_videoController.value.duration);
    return AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: Stack(
        children: [
          GestureDetector(
              onTap: () {
                if (isPlaying) {
                  isShow = true;
                  setState(() {});
                }
              },
              child: VideoPlayer(_videoController)),
          isShow == true
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      if (isPlaying) {
                        _videoController.pause();
                        isShow = true;
                      } else {
                        _videoController.play();
                        isShow = false;
                      }
                      isPlaying = !isPlaying;
                      setState(() {});
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
