import 'package:bloc/bloc.dart';
import 'package:chatapp/pages/home/home_screen.dart';
import 'package:flutter/material.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void signUpValidat(BuildContext context) {
    if (formkey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }
}
