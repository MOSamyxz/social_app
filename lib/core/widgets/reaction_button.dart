import 'package:chatapp/core/constants/assets.dart';
import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: constant_identifier_names
enum ReactionType { Like, Love, Haha, Angry, Sad, Wow }

class ReactionButtonGroup extends StatefulWidget {
  final Function(ReactionType) onReactionSelected;

  const ReactionButtonGroup({super.key, required this.onReactionSelected});

  @override
  // ignore: library_private_types_in_public_api
  _ReactionButtonGroupState createState() => _ReactionButtonGroupState();
}

class _ReactionButtonGroupState extends State<ReactionButtonGroup>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  ReactionType _selectedReaction = ReactionType.Like;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectReaction(ReactionType reactionType) {
    setState(() {
      if (_selectedReaction == reactionType) {
        _selectedReaction = ReactionType.Like;
      } else {
        _selectedReaction = reactionType;
      }
      _animationController.forward(from: 0.0);
    });

    widget.onReactionSelected(_selectedReaction);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppSize.r20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildReactionButton(ReactionType.Like),
          _buildReactionButton(ReactionType.Love),
          _buildReactionButton(ReactionType.Haha),
          _buildReactionButton(ReactionType.Angry),
          _buildReactionButton(ReactionType.Sad),
          _buildReactionButton(ReactionType.Wow),
        ],
      ),
    );
  }

  Widget _buildReactionButton(ReactionType reactionType) {
    return GestureDetector(
        onTap: () => _selectReaction(reactionType),
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: AppSize.r20,
            child: Image(
              image: AssetImage(_getReactionIcon(reactionType)),
              fit: BoxFit.fill,
            ),
          ),
        ));
  }

  String _getReactionIcon(ReactionType reactionType) {
    switch (reactionType) {
      case ReactionType.Like:
        return AppAssets.like;
      case ReactionType.Love:
        return AppAssets.love;
      case ReactionType.Haha:
        return AppAssets.haha;
      case ReactionType.Angry:
        return AppAssets.angry;
      case ReactionType.Sad:
        return AppAssets.sad;
      case ReactionType.Wow:
        return AppAssets.wow;
    }
  }
}
