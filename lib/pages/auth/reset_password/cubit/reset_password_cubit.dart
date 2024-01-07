import 'package:bloc/bloc.dart';
import 'package:chatapp/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void resetPasswordValidat(BuildContext context) {
    if (formkey.currentState!.validate()) {
      GoRouter.of(context).push(Routes.verificationScreen);
    }
  }
}
