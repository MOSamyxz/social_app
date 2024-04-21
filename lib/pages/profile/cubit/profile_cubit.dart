import 'package:bloc/bloc.dart';
import 'package:chatapp/data/firebase_notifications.dart';

import 'package:chatapp/data/firestore_follow/firestore_follow.dart';
import 'package:chatapp/data/model/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> removeFollowRequest(userId) async {
    await FirestoreFollow().removeFollowRequest(userId: userId);
    emit(RemoveFollowRequestState());
  }

  Future<void> removeFollower(userId) async {
    FirestoreFollow().removeFollower(userId: userId);
    emit(RemoveFollowerState());
  }

  Future<void> sendFollowRequest(
      {required UsersModel user, required UsersModel myUser}) async {
    FirestoreFollow().sendFollowRequest(userId: user.uId);
    await FirebaseNotification().sendMessage(
        title: 'Follow Request',
        discreption: '${myUser.userName} Sent you a follow request.',
        token: user.token,
        data: {});
    emit(SendFollowRequestState());
  }
}
