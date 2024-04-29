import 'package:bloc/bloc.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatInitial());
  List<UsersModel>? _users;
  UsersModel? user;
  String uId = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;

  Future<void> getAllChats() async {
    emit(GetAllChatsLoadingState());
    isLoading = true;
    try {
      FirebaseFirestore.instance
          .collection('users')
          .snapshots(includeMetadataChanges: true)
          .listen((users) {
        List<UsersModel> user =
            users.docs.map((doc) => UsersModel.fromMap(doc.data())).toList();
        _users = user;
        isLoading = false;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
    emit(GetAllChatsSuccessState());
  }

  List<UsersModel> get getUsers => _users!;

  UsersModel? getChatById(String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = UsersModel.fromMap(user.data()!);
    });
    return user;
  }
}
