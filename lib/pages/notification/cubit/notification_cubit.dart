import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp/data/firebase_auth/firestore_services.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/data/firestore_follow/firestore_follow.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  List<UsersModel>? _userById;
  final FirestoreServices _firestoreServices = FirestoreServices();
  Future<void> getUsersById(userid) async {
    emit(GetUsersDataByIdLoadingState());

    List<UsersModel> user = await _firestoreServices.getUsersDetailsByIds(
        collection: 'users', userIds: userid);
    _userById = user;
    emit(GettUsersDataByIdSuccessState());
  }

  List<UsersModel> get usersById => _userById!;

  Future<void> acceptFollowRequest(userId) async {
    FirestoreFollow().acceptFollowRequest(userId: userId);
    emit(AcceptFollowRequestState());
  }

  Future<void> removeFollowRequest(userId) async {
    FirestoreFollow().removeFollowRequest(userId: userId);

    emit(DeleteFollowRequestState());
  }
}
