part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class GettUsersDataSuccessState extends NotificationState {}

final class GetUsersDataLoadingState extends NotificationState {}

final class AcceptFollowRequestState extends NotificationState {}
