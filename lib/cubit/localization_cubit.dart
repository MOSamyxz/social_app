import 'package:bloc/bloc.dart';
import 'package:chatapp/core/services/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(AppInitial());

  void init() {
    getLocale();
    getLang();
  }

  void getLocale() {
    emit(AppLocaleState());
    CacheHelper.sharedPreferences.getString('lang');
  }

  late Locale locale;
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
    String lang = CacheHelper.sharedPreferences.getString('lang')!;
    locale = Locale(lang);
  }
}
