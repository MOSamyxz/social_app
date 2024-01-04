import 'package:bloc/bloc.dart';
import 'package:chatapp/pages/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void signInValidat(BuildContext context) {
    if (formkey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }
}
