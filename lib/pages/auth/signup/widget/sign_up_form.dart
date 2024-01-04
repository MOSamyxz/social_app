import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/functions/validation.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/core/widgets/custome_text_field.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/signup/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<SignUpCubit>(context).formkey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomeTextFormField(
            hintText: S.of(context).yourName,
            validator: (input) {
              return validInput(input!, 6, 16, 'username', context);
            },
          ),
          const VerticalSpace(AppSize.s10),
          CustomeTextFormField(
            hintText: S.of(context).emailAddress,
            validator: (input) {
              return validInput(input!, 6, 16, 'email', context);
            },
          ),
          const VerticalSpace(AppSize.s10),
          CustomeTextFormField(
            hintText: S.of(context).password,
            validator: (input) {
              return validInput(input!, 6, 16, 'password', context);
            },
          ),
          const VerticalSpace(AppSize.s10),
          CustomeTextFormField(
            hintText: S.of(context).rePassword,
            validator: (input) {
              return validInput(input!, 6, 16, 'repassword', context);
            },
          ),
          const VerticalSpace(AppSize.s10),
          CustomButton(
            onPressed: () {
              BlocProvider.of<SignUpCubit>(context).signUpValidat(context);
            },
            text: S.of(context).SignUp,
          ),
          const VerticalSpace(AppSize.s20),
        ],
      ),
    );
  }
}
