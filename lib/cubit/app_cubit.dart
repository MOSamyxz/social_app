import 'package:bloc/bloc.dart';
import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/data/firebase/firestore_services.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  Future<void> init() async {
    //refreshPosts();
    getLang();
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
  }

  UsersModel get getUser => _user!;
}
