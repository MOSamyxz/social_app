part of 'app_cubit.dart';

abstract class AppState {}

final class AppInitial extends AppState {}

final class AppLocaleState extends AppState {}

final class AppLocaleChangeState extends AppState {}

class AppChangeModeState extends AppState {}

class AppSaveModeState extends AppState {}

class AppLoadModeState extends AppState {}

class GetCurrentUserDataLoadingState extends AppState {}

class GetVerifiedMembersDataSuccessState extends AppState {}

class GetVerifiedMembersDataLoadingState extends AppState {}

class GetCurrentUserDataSuccessState extends AppState {}

class AppInitializedState extends AppState {}

final class IndexChangeState extends AppState {}
