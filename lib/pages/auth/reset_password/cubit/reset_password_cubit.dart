import 'package:bloc/bloc.dart';
import 'package:chatapp/data/firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

  void resetPassword(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      try {
        await FirebaseAuthServices()
            .resetPassword(context: context, email: email.text);
        controlerDispose();
      } on Exception catch (e) {
        e.toString();
      }
    }
  }

  void controlerDispose() {
    email.clear();
  }
}
