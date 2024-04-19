// ignore_for_file: use_build_context_synchronously
import 'package:chatapp/core/functions/validation.dart';
import 'package:chatapp/core/widgets/custome_text_field.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/settings/cubit/security_auth_cubit.dart';
import 'package:chatapp/pages/settings/widgets/change_email_buttons.dart';
import 'package:chatapp/pages/settings/widgets/setting_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangeEmailForm extends StatelessWidget {
  const ChangeEmailForm({
    super.key,
    required this.user,
  });

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<SecurityAuthCubit>(context).emailKey,
      child: Column(children: [
        const SettingCategory(
          title: 'Update email',
        ),
        const VerticalSpace(10),
        CustomeTextFormField(
          prefix: FontAwesomeIcons.envelope,
          controller: BlocProvider.of<SecurityAuthCubit>(context).email,
          hintText: 'New Email',
          validator: (input) {
            return validInput(input!, 6, 32, 'email', context);
          },
        ),
        const VerticalSpace(10),
        CustomeTextFormField(
          prefix: FontAwesomeIcons.lock,
          controller: BlocProvider.of<SecurityAuthCubit>(context).password,
          hintText: 'Password',
          validator: (input) {
            return validInput(input!, 6, 32, 'password', context);
          },
        ),
        const VerticalSpace(10),
        ChangeEmailButtons(user: user),
      ]),
    );
  }
}
