import 'package:bloc/bloc.dart';
import 'package:chatapp/data/firebase/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  void signIn(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      emit(SignInLoadingState());
      isLoading = true;
      try {
        await FirebaseAuthServices().signIn(
          email: email.text,
          password: password.text,
          context: context,
        );
        // ignore: use_build_context_synchronously
        controlerDispose();

        emit(SignInSuccessState());
        isLoading = false;
      } on Exception catch (e) {
        emit(SignInErrorState());
        print(e.toString());
      }
    }
  }

  void controlerDispose() {
    email.clear();
    password.clear();
  }
}
