import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/pages/post/add_posts/add_post_screen.dart';
import 'package:chatapp/pages/post/firebase_posts/firestore_posts.dart';
import 'package:flutter/material.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
  late TextEditingController postController;
  late TextEditingController editPostController;
  File? file;
  String? fileType;
  init() {
    postController = TextEditingController();
    editPostController = TextEditingController();
  }

  pickedVideo() async {
    fileType = 'postMediaVideo';
    emit(VideoPickedLoadingState());
    file = await pickVideo();
    emit(VideoPickedSuccessState());
  }

  pickedImage() async {
    fileType = 'postMediaImage';
    file = await pickImage();
    emit(ImagePickedSuccessState());
  }

  deletFile() {
    file = null;
    emit(FileRemovedSuccessState());
  }

  addImagePostFromHome(context) async {
    fileType = 'postMediaImage';

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddPostScreen()),
    );
    await pickedImage();
    emit(ImagePickedSuccessState());
  }

  void createPost(context,
      {required String posterName, required String posterProfileUrl}) async {
    FireStorePosts()
        .makePost(
      content: postController.text,
      file: file,
      postType: fileType == null ? 'post' : fileType!,
      posterName: posterName,
      posterProfileUrl: posterProfileUrl,
    )
        .then((value) {
      Navigator.of(context).pop();
    }).catchError((_) {});
  }

  void updatePost(context,
      {required String postId, required String postContent}) {
    FireStorePosts()
        .updatePost(postId: postId, postContent: postContent)
        .then((value) {
      Navigator.of(context).pop();
    }).catchError((_) {});
  }
}
