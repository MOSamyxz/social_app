import 'package:bloc/bloc.dart';
import 'package:chatapp/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void signUpValidat(BuildContext context) {
    if (formkey.currentState!.validate()) {
      GoRouter.of(context).pushReplacement(Routes.homeScreen);
    }
  }
}
