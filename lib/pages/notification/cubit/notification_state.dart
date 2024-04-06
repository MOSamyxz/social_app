part of 'notification_cubit.dart';

sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class GettUsersDataByIdSuccessState extends NotificationState {}

final class GetUsersDataByIdLoadingState extends NotificationState {}

final class UsersUpdatedState extends NotificationState {
  UsersUpdatedState(
    List<UsersModel> usersById,
  );
  List<UsersModel> updatedUsers = [];
}

final class AcceptFollowRequestState extends NotificationState {}

final class DeleteFollowRequestState extends NotificationState {}
