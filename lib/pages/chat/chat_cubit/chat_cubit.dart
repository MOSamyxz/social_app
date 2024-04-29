import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/data/firebase_notifications.dart';
import 'package:chatapp/data/firestore_messeges.dart/firestore_messeges.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  UsersModel? _user;
  String uId = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;
  late TextEditingController messegeController;
  late ScrollController scrollcontroller;

  void init() {
    messegeController = TextEditingController();
    scrollcontroller = ScrollController();
  }

  Future<void> getCurrentChats(userId) async {
    emit(GetChatLoadingState());
    isLoading = true;
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(includeMetadataChanges: true)
          .listen((user) {
        UsersModel chatUser = UsersModel.fromMap(user.data()!);
        _user = chatUser;
        isLoading = false;
      });
    } on Exception catch (e) {
      e.toString();
    }
    emit(GetChatSuccessState());
  }

  UsersModel get getUser => _user!;

  String messegeType = 'text';
  File? file;

  pickedVideo() async {
    emit(VideoPickedLoadingState());
    messegeType = 'video';

    file = await pickVideo();
    emit(VideoPickedSuccessState());
  }

  pickedImage() async {
    emit(ImagePickedLoadingState());
    messegeType = 'image';

    file = await pickImage();
    emit(ImagePickedSuccessState());
  }

  deletFile() {
    file = null;
    emit(FileRemovedSuccessState());
  }

  void sendMessege({
    required UsersModel receiver,
  }) async {
    emit(SendMessageLoadingState());
    if (messegeController.text.isEmpty && file == null) {
      Fluttertoast.showToast(
        msg: 'Can\'t send an empty messege',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
    if (messegeController.text.isNotEmpty || file != null) {
      isLoading = true;
      String messegeContent = messegeController.text;
      try {
        await FirestoreMesseges().sendMessage(
            receiverId: receiver.uId,
            messegeContent: messegeController.text,
            file: file,
            messegeType: messegeType);
        await FirebaseNotification().sendMessage(
            title: 'Message',
            discreption: messegeContent,
            token: receiver.token,
            data: {'type': 'message'});
        deletFile();
        messegeType = 'text';
      } on Exception catch (e) {
        e.toString();
      }
    }
  }

  void controllerDispose() {
    messegeController.clear();
  }
}
