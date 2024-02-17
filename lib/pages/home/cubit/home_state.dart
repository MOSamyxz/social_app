part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ReactButtonVisibilityState extends HomeState {}

class GettUserDataSuccessState extends HomeState {}

class GetUserDataLoadingState extends HomeState {}
