import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoViewStory extends StatefulWidget {
  const VideoViewStory({
    super.key,
    required this.video,
  });

  final Uri video;

  @override
  State<VideoViewStory> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoViewStory> {
  late final VideoPlayerController _videoController;

  bool isPlaying = false;
  bool isShow = true;

  @override
  void initState() {
    _videoController = VideoPlayerController.networkUrl(widget.video)
      ..initialize().then((value) {
        setState(() {
          _videoController.play();
        });
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
    return AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: VideoPlayer(_videoController),
    );
  }
}
