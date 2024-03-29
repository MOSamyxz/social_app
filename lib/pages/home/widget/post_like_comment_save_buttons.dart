import 'package:chatapp/core/widgets/reaction_button.dart';
import 'package:chatapp/data/model/like_data_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:chatapp/pages/home/widget/post_card_like_button.dart';
import 'package:chatapp/pages/post/comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostLikeCommentSaveButtons extends StatefulWidget {
  const PostLikeCommentSaveButtons({
    super.key,
    required this.isLiked,
    required this.post,
    this.likesData,
    required this.user,
  });

  final bool isLiked;
  final Post post;
  final UsersModel user;
  final LikesDataModel? likesData;

  @override
  State<PostLikeCommentSaveButtons> createState() =>
      _PostLikeCommentSaveButtonsState();
}

class _PostLikeCommentSaveButtonsState
    extends State<PostLikeCommentSaveButtons> {
  bool showReactionButtons = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onLongPress: () {
                  setState(() {
                    showReactionButtons = !showReactionButtons;
                  });
                },
                child: PostCardButton(
                    text: widget.isLiked
                        ? BlocProvider.of<HomeCubit>(context).getReact(context,
                            isLiked: widget.isLiked,
                            likeType: widget.likesData!.likeType)
                        : S.of(context).like,
                    onPressed: () async {
                      !widget.isLiked
                          ? BlocProvider.of<HomeCubit>(context).react = 'Like'
                          : null;
                      await BlocProvider.of<HomeCubit>(context).likeDislikePost(
                        postId: widget.post.postId,
                        likes: widget.post.likes,
                        user: widget.user,
                        likesData: widget.post.likesData,
                      );
                    },
                    image: BlocProvider.of<HomeCubit>(context).getLikeReact(
                        isLiked: widget.isLiked,
                        likeType: widget.likesData!.likeType),
                    icon: FontAwesomeIcons.thumbsUp,
                    color: BlocProvider.of<HomeCubit>(context).getLikeColor(
                        isLiked: widget.isLiked,
                        likeType: widget.likesData!.likeType)),
              ),
            ),
            PostCardButton(
              text: S.of(context).comment,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommentScreen(
                              postId: widget.post.postId,
                            )));
              },
              icon: FontAwesomeIcons.comment,
            ),
            Expanded(
              child: PostCardButton(
                text: S.of(context).save,
                onPressed: () {},
                icon: FontAwesomeIcons.bookmark,
              ),
            ),
          ],
        ),
        Visibility(
          visible: showReactionButtons,
          child: ReactionButtonGroup(
            onReactionSelected: (ReactionType reactionType) {
              BlocProvider.of<HomeCubit>(context).handleReactionSelected(
                  reactionType: reactionType,
                  post: widget.post,
                  user: widget.user);
              setState(() {
                showReactionButtons = !showReactionButtons;
              });
            },
          ),
        ),
      ],
    );
  }
}
