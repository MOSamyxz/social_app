import 'package:chatapp/core/functions/validation.dart';
import 'package:chatapp/core/widgets/custome_text_field.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/settings/cubit/security_auth_cubit.dart';
import 'package:chatapp/pages/settings/widgets/change_password_buttons.dart';
import 'package:chatapp/pages/settings/widgets/setting_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({
    super.key,
    required this.user,
  });

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<SecurityAuthCubit>(context).passwordKey,
      child: Column(
        children: [
          const SettingCategory(
            title: 'Update Password',
          ),
          const VerticalSpace(10),
          CustomeTextFormField(
            prefix: Icons.lock,
            controller: BlocProvider.of<SecurityAuthCubit>(context).oldPassword,
            hintText: 'Old Password Email',
            validator: (input) {
              return validInput(input!, 6, 32, 'password', context);
            },
          ),
          const VerticalSpace(10),
          CustomeTextFormField(
            prefix: Icons.lock,
            controller: BlocProvider.of<SecurityAuthCubit>(context).newPassword,
            hintText: 'New Password',
            validator: (input) {
              return validInput(input!, 6, 32, 'password', context);
            },
          ),
          const VerticalSpace(10),
          CustomeTextFormField(
            prefix: Icons.lock,
            controller:
                BlocProvider.of<SecurityAuthCubit>(context).reNewPassword,
            hintText: 're-Enter New Password',
            validator: (input) {
              return validInput(input!, 6, 32, 'password', context);
            },
          ),
          const VerticalSpace(10),
          ChangePasswordButtons(user: user)
        ],
      ),
    );
  }
}
