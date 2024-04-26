part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class ChangeAvatarLoadingState extends SignUpState {}

final class ChangeAvatarSuccessState extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

final class SignUpSuccessState extends SignUpState {}

final class SignUpErrorState extends SignUpState {}

final class ShowHidePasswordState extends SignUpState {}
