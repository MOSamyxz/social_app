import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/data/firebase_auth/firestore_services.dart';
import 'package:chatapp/data/firestore_story/firestore_story.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());

  late TextEditingController storyTextController;
  late StoryController storyController;
  late List<StoryItem> storyItem;
  int currentIndex = 0;
  bool isLoading = false;
  void init() async {
    storyTextController = TextEditingController();
    storyController = StoryController();
  }

  void indexChange(int index) {
    currentIndex = index;
    emit(CurrentIndexChangeState());
  }

  String? storyType;

  File? file;
  pickedVideo() async {
    emit(VideoPickedLoadingState());
    storyType = 'video';

    file = await pickVideo();
    emit(VideoPickedSuccessState());
  }

  pickedImage() async {
    storyType = 'image';

    file = await pickImage();
    emit(ImagePickedSuccessState());
  }

  void creatStory(
    context, {
    required String storyAuther,
    required String storyAutherProfileUrl,
  }) async {
    emit(PostStoryLoadingState());
    isLoading = true;
    FireStoreStories()
        .makeStory(
      storyAuther: storyAuther,
      storyAutherProfileUrl: storyAutherProfileUrl,
      content: storyTextController.text,
      duration: duration,
      file: file,
      storyType: storyType == null ? 'post' : storyType!,
    )
        .then((value) {
      Navigator.of(context).pop();
      isLoading = false;
      emit(PostStorySuccessState());
    }).catchError((_) {
      emit(PostStoryErrorState());
    });
  }

  void onchanged(String text) {
    storyTextController.text = text;
    emit(StroyControllerChangeState());
  }

  Future<void> viewStory({
    required String userId,
    required String storyId,
  }) async {
    await FireStoreStories().viewStory(userId: userId, storyId: storyId);
  }

  Future<void> likeDislikeStory({
    required String storyId,
    required String storyAutherId,
    required List<String> likes,
  }) async {
    try {
      await FireStoreStories().likeDislikeStory(
        storyId: storyId,
        likes: likes,
        storyAutherId: storyAutherId,
      );
      emit(StoryLikeDisLikeState());
    } on Exception catch (e) {
      e.toString();
    }
  }

  deletFile() {
    file = null;
    emit(FileRemovedSuccessState());
  }

  List<UsersModel>? _userById;
  final FirestoreServices _firestoreServices = FirestoreServices();
  Future<void> getUsersById(userid) async {
    emit(GetUsersDataByIdLoadingState());

    List<UsersModel> user = await _firestoreServices.getUsersDetailsByIds(
        collection: 'users', userIds: userid);
    _userById = user;
    emit(GettUsersDataByIdSuccessState());
  }

  List<UsersModel> get usersById => _userById!;

  Duration? duration;
  void getDuration(Duration newDuration) {
    duration = newDuration;
    emit(NewDurationUpdateState());
  }
}
