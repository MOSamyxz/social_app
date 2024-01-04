import 'package:bloc/bloc.dart';
import 'package:chatapp/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void signInValidat(BuildContext context) {
    if (formkey.currentState!.validate()) {
      GoRouter.of(context).pushReplacement(Routes.homeScreen);
    }
  }
}
