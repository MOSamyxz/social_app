import 'package:bloc/bloc.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool ishide = true;
  AppCubit appCubit = AppCubit();
  Future<void> signIn(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      emit(SignInLoadingState());
      isLoading = true;
      try {
        await FirebaseAuthServices().signIn(
          email: email.text,
          password: password.text,
          context: context,
        );
        AppCubit().getUserData();

        emit(SignInSuccessState());
        isLoading = false;
      } on Exception catch (e) {
        e.toString();
        emit(SignInErrorState());
      }
    }
  }

  void showPassword() {
    ishide = !ishide;
    print(ishide);
    emit(SHowHidePasswordState());
  }

  void controlerDispose() {
    email.clear();
    password.clear();
  }
}
