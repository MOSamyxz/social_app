import 'package:bloc/bloc.dart';
import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/data/firebase/firestore_services.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  void init() {
    getLang();
    refreshUser();
  }

  void setLangAr() {
    emit(AppLocaleState());
    CacheHelper.sharedPreferences.setString('lang', 'ar');
    getLang();
    emit(AppLocaleArChangeState());
  }

  void setLangEn() {
    emit(AppLocaleState());
    CacheHelper.sharedPreferences.setString('lang', 'en');
    getLang();
    emit(AppLocaleEnChangeState());
  }

  void getLang() {
    CacheHelper.sharedPreferences.getString('lang')!;
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      emit(AppLoadModeState());
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      emit(AppLoadModeState());
      isDark = !isDark;
      CacheHelper.sharedPreferences.setBool('isDark', isDark).then((value) {
        emit(AppSaveModeState());
      });
      emit(AppChangeModeState());
    }
  }

  Users? _user;
  final FirestoreServices _firestoreServices = FirestoreServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> refreshUser() async {
    emit(GetUserDataLoadingState());
    print(_auth.currentUser?.uid ?? '======');
    if (_auth.currentUser?.uid != null) {
      Users user = await _firestoreServices.getUserDetails(
          collection: 'users', doc: _auth.currentUser!.uid);
      _user = user;
    }
    emit(GetUserDataSuccessState());
  }

  Users get getUser => _user!;
}
