part of 'security_auth_cubit.dart';

@immutable
sealed class SecurityAuthState {}

final class SecurityAuthInitial extends SecurityAuthState {}

final class UpdateEmailLoadingState extends SecurityAuthState {}

final class UpdateEmailSuccessgState extends SecurityAuthState {}

final class UpdateEmailErrorgState extends SecurityAuthState {}
