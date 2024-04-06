import 'package:bloc/bloc.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  UsersModel? _user;
  String uId = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;
  Future<void> getCurrentChats(userId) async {
    emit(GetChatLoadingState());
    isLoading = true;
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(includeMetadataChanges: true)
          .listen((user) {
        UsersModel chatUser = UsersModel.fromMap(user.data()!);
        _user = chatUser;
        isLoading = false;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
    emit(GetChatSuccessState());
  }

  UsersModel get getUser => _user!;
}
