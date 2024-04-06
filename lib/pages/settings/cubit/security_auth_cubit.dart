import 'package:bloc/bloc.dart';
import 'package:chatapp/data/firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'security_auth_state.dart';

class SecurityAuthCubit extends Cubit<SecurityAuthState> {
  SecurityAuthCubit() : super(SecurityAuthInitial());

  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController reNewPassword = TextEditingController();
  bool isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  Future<void> updateEmail(BuildContext context) async {
    if (emailKey.currentState!.validate()) {
      emit(UpdateEmailLoadingState());

      isLoading = true;
      try {
        await firebaseAuthServices.updateEmail(
          context,
          email.text,
        );
        emit(UpdateEmailSuccessgState());
        isLoading = false;
      } on Exception catch (e) {
        e.toString();
        emit(UpdateEmailErrorgState());
      }
    }
  }

  Future<void> updatePassword() async {
    if (passwordKey.currentState!.validate()) {
      emit(UpdateEmailLoadingState());
      isLoading = true;
      try {
        await firebaseAuthServices.updatePassword(
          newPassword.text,
        );
        emit(UpdateEmailSuccessgState());
        isLoading = false;
      } on Exception catch (e) {
        e.toString();
        emit(UpdateEmailErrorgState());
      }
    }
  }

  Future<bool> validateCurrentPassword(BuildContext context) async {
    return await firebaseAuthServices.validatePassword(
        context, oldPassword.text);
  }

  Future<bool> validateCurrentPasswordForEmail(BuildContext context) async {
    return await firebaseAuthServices.validatePassword(context, password.text);
  }

  Future<void> updateEmailInFirestore() async {
    await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'email': email.text});
  }

  void controlerDispose() {
    email.clear();
  }
}
