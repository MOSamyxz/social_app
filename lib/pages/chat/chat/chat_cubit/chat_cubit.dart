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
  late TextEditingController messageController;
  late ScrollController scrollcontroller;

  void init() {
    messageController = TextEditingController();
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

  String messageType = 'text';
  File? file;

  pickedVideo() async {
    emit(VideoPickedLoadingState());
    messageType = 'video';

    file = await pickVideo();
    emit(VideoPickedSuccessState());
  }

  pickedImage() async {
    emit(ImagePickedLoadingState());
    messageType = 'image';

    file = await pickImage();
    emit(ImagePickedSuccessState());
  }

  deletFile() {
    file = null;
    emit(FileRemovedSuccessState());
  }

  Future<void> sendMessage({
    required UsersModel recipient,
  }) async {
    emit(SendMessageLoadingState());

    if (messageController.text.isEmpty && file == null) {
      showToast('Can\'t send an empty message');
      return;
    }

    if (messageController.text.isNotEmpty || file != null) {
      isLoading = true;
      final messageContent = messageController.text;
      try {
        await FirestoreMesseges().sendMessage(
          receiverId: recipient.uId,
          messageContent: messageContent,
          messageType: messageType,
          file: file,
        );
        clearFileAndResetMessageType();
        messageController.clear();
        await sendPushNotification(
          title: 'Message',
          discreption: messageContent,
          token: recipient.token,
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void clearFileAndResetMessageType() {
    file = null;
    messageType = 'text';
    emit(FileRemovedSuccessState());
  }

  Future<void> sendPushNotification({
    required String title,
    required String discreption,
    required String token,
  }) async {
    await FirebaseNotification().sendMessage(
        title: title, discreption: discreption, token: token, data: {});
  }

  @override
  Future<void> close() {
    messageController.dispose();
    scrollcontroller.dispose();
    return super.close();
  }
}
