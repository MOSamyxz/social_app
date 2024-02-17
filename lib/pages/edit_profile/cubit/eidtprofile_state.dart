part of 'eidtprofile_cubit.dart';

sealed class EidtProfileState {}

final class EidtProfileInitial extends EidtProfileState {}

final class PickImageLoadingState extends EidtProfileState {}

final class PickImageSuccessState extends EidtProfileState {}

final class ChangeCoverLoadingState extends EidtProfileState {}

final class ChangeCoverSuccessState extends EidtProfileState {}

final class ChangeProfileLoadingState extends EidtProfileState {}

final class ChangeProfileSuccessState extends EidtProfileState {}
