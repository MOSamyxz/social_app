import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoViewSaved extends StatefulWidget {
  const VideoViewSaved({
    super.key,
    required this.video,
    required this.isSearchView,
    this.child,
    this.aspectRatio,
  });

  final Uri video;
  final bool isSearchView;
  final Widget? child;
  final double? aspectRatio;
  @override
  State<VideoViewSaved> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoViewSaved> {
  late final VideoPlayerController _videoController;

  bool isPlaying = false;
  bool isShow = true;

  @override
  void initState() {
    _videoController = VideoPlayerController.networkUrl(widget.video)
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
    return AspectRatio(
      aspectRatio: widget.aspectRatio ?? _videoController.value.aspectRatio,
      child: Stack(
        children: [
          GestureDetector(onTap: () {}, child: VideoPlayer(_videoController)),
          isShow == true
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {},
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
