import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/settings/cubit/security_auth_cubit.dart';
import 'package:chatapp/pages/settings/widgets/change_email_form.dart';
import 'package:chatapp/pages/settings/widgets/change_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityAndAuthenticationScreen extends StatelessWidget {
  const SecurityAndAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;

    return BlocProvider(
      create: (context) => SecurityAuthCubit(),
      child: BlocBuilder<SecurityAuthCubit, SecurityAuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Security & Authentication'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: AppPadding.screenPadding,
                child: Column(
                  children: [
                    ChangeEmailForm(user: user),
                    ChangePasswordForm(user: user)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
