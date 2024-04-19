import 'package:chatapp/pages/story/cubit/story_cubit.dart';
import 'package:chatapp/pages/story/story_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/story_view.dart';

class StoryViewItem extends StatelessWidget {
  const StoryViewItem({
    super.key,
    required this.widget,
    required this.storyItems,
  });

  final StoryViewScreen widget;
  final List<StoryItem> storyItems;

  @override
  Widget build(BuildContext context) {
    return StoryView(
      inline: true,
      onStoryShow: (storyItem, index) {
        BlocProvider.of<StoryCubit>(context).indexChange(index);
        BlocProvider.of<StoryCubit>(context).viewStory(
            userId: widget.stories[index].storyAutherId,
            storyId: widget.stories[index].storyId);
      },
      storyItems: storyItems,
      onComplete: () {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context, rootNavigator: true).pop();
        });
      },
      onVerticalSwipeComplete: (direction) {
        if (direction == Direction.down) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context, rootNavigator: true).pop();
          });
        } else if (direction == Direction.up) {
          // Handle swipe up
        }
      },
      controller: BlocProvider.of<StoryCubit>(context).storyController,
    );
  }
}
