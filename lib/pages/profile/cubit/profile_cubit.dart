import 'package:bloc/bloc.dart';

import 'package:chatapp/data/firestore_follow/firestore_follow.dart';

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

  Future<void> sendFollowRequest(userId) async {
    FirestoreFollow().sendFollowRequest(userId: userId);
    emit(SendFollowRequestState());
  }
}
