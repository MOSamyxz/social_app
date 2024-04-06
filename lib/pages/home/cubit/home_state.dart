part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ReactButtonVisibilityState extends HomeState {}

class GettUserDataByIdSuccessState extends HomeState {}

class GetUserDataByIdLoadingState extends HomeState {}

class GetUsersDataByIdLoadingState extends HomeState {}

class GetUsersDataByIdSuccessState extends HomeState {}
