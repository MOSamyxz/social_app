part of 'app_cubit.dart';

abstract class AppState {}

final class AppInitial extends AppState {}

final class AppLocaleState extends AppState {}

final class AppLocaleArChangeState extends AppState {}

final class AppLocaleEnChangeState extends AppState {}

class AppChangeModeState extends AppState {}

class AppSaveModeState extends AppState {}

class AppLoadModeState extends AppState {}

class GetUserDataLoadingState extends AppState {}

class GetUserDataSuccessState extends AppState {}
