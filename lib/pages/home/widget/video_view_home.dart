import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoViewHome extends StatefulWidget {
  const VideoViewHome({
    super.key,
    required this.video,
    required this.isSearchView,
    this.child,
  });

  final Uri video;
  final bool isSearchView;
  final Widget? child;
  @override
  State<VideoViewHome> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoViewHome> {
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
                      if (widget.isSearchView) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => widget.child!));
                      } else {
                        if (isPlaying) {
                          _videoController.pause();
                          isShow = true;
                        } else {
                          _videoController.play();
                          isShow = false;
                        }
                        isPlaying = !isPlaying;
                        setState(() {});
                      }
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
