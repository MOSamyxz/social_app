import 'package:bloc/bloc.dart';
import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/data/firebase_auth/firestore_services.dart';
import 'package:chatapp/data/firestore_story/firestore_story.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  Future<void> init() async {
    getLang();
    deleteStory();
  }

  Future<void> deleteStory() async {
    await FireStoreStories().deleteStory();
  }

  void setLangAr() {
    emit(AppLocaleState());
    local = 'ar';
    CacheHelper.sharedPreferences.setString('lang', local);
    getLang();
  }

  void setLangEn() {
    emit(AppLocaleState());
    local = 'en';
    CacheHelper.sharedPreferences.setString('lang', local);
    getLang();
  }

  void changLang() {
    if (CacheHelper.sharedPreferences.getString('lang') == 'ar') {
      setLangEn();
    } else {
      setLangAr();
    }
  }

  void getLang() {
    CacheHelper.sharedPreferences.getString('lang');
    emit(AppLocaleChangeState());
  }

  String local = 'ar';

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      emit(AppLoadModeState());
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      emit(AppLoadModeState());
      isDark = !isDark;
      CacheHelper.sharedPreferences.setBool('isDark', isDark).then((value) {});
      emit(AppChangeModeState());
    }
  }

  UsersModel? _user;
  final FirestoreServices _firestoreServices = FirestoreServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getUserData() async {
    emit(GetCurrentUserDataLoadingState());
    if (_auth.currentUser?.uid != null) {
      UsersModel user = await _firestoreServices.getUserDetails(
          collection: 'users', doc: _auth.currentUser!.uid);
      _user = user;
    }
    emit(GetCurrentUserDataSuccessState());
    print('done========================================');
    print(_user!.email);
    print(_user!.userName);
  }

  UsersModel get getUser => _user!;

  int currentPage = 0;
  late PageController pageController; // for tabs animation
  late ScrollController scrollController;

  void controllerInit() {
    pageController = PageController();
    scrollController = ScrollController();
  }

  void onItemTapped(int index) {
    currentPage = index;
    emit(IndexChangeState());
  }

  void onPageChanged(int page) {
    currentPage = page;
    emit(IndexChangeState());
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }
}
