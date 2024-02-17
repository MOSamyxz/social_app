import 'package:bloc/bloc.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/post/firebase_posts/firestore_posts.dart';
import 'package:flutter/material.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsInitial());
  late TextEditingController commentController;

  void init() async {
    commentController = TextEditingController();
  }

  void createComment({
    required String postId,
    required UsersModel user,
  }) {
    FireStorePosts().postComment(
      postId: postId,
      text: commentController.text,
      user: user,
    );
  }

  Future<void> likeDislikeComment(
      {required String postId,
      required String commentId,
      required List<String> likes,
      required UsersModel user}) async {
    await FireStorePosts().likeDislikeComment(
      postId: postId,
      likes: likes,
      user: user,
      commentId: commentId,
    );
  }
}
