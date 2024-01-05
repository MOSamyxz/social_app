import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/pages/auth/forget_password/cubit/reset_password_cubit.dart';
import 'package:chatapp/pages/auth/forget_password/widget/reset_password_view.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: const ResetPasswordView(),
    );
  }
}
