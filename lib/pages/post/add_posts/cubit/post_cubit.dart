import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/pages/post/add_posts/add_post_screen.dart';
import 'package:chatapp/data/firestore_posts/firestore_posts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
  late TextEditingController postController;
  late TextEditingController editPostController;
  File? file;
  String? fileType;
  bool isLoading = false;
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
    emit(ImagePickedLoadingState());

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

  bool isPost = false;
  void createPost(context,
      {required String posterName,
      required String posterToken,
      required String posterProfileUrl}) async {
    emit(PostLoadingState());
    if (postController.text.isEmpty && file == null) {
      Fluttertoast.showToast(
        msg: 'Can\'t post an empty post',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
    if (postController.text.isNotEmpty || file != null) {
      isLoading = true;

      FireStorePosts()
          .makePost(
        content: postController.text,
        file: file,
        postType: fileType == null ? 'post' : fileType!,
        posterName: posterName,
        posterProfileUrl: posterProfileUrl,
        posterToken: posterToken,
      )
          .then((value) {
        isPost = true;
        Navigator.of(context).pop();
        isLoading = false;
        emit(PostSuccessState());
      }).catchError((e) {
        emit(PostErrorState());
        log('${e.toString()} ------------');
      });
    }
  }

  void updatePost(context,
      {required String postId, required String postContent}) {
    isLoading = true;
    FireStorePosts()
        .updatePost(postId: postId, postContent: postContent)
        .then((value) {
      Navigator.of(context).pop();
      isLoading = false;
    }).catchError((_) {});
  }
}
