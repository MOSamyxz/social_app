import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/functions/validation.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/core/widgets/custome_text_field.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/signin/cubit/sign_in_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<SignInCubit>(context).formkey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomeTextFormField(
            controller: BlocProvider.of<SignInCubit>(context).email,
            hintText: S.of(context).emailAddress,
            validator: (input) {
              return validInput(input!, 6, 32, 'email', context);
            },
          ),
          const VerticalSpace(AppSize.s10),
          CustomeTextFormField(
            controller: BlocProvider.of<SignInCubit>(context).password,
            hintText: S.of(context).password,
            validator: (input) {
              return validInput(input!, 6, 32, 'password', context);
            },
          ),
          const VerticalSpace(AppSize.s10),
          CustomButton(
            onPressed: () {
              BlocProvider.of<SignInCubit>(context).signIn(context);
            },
            child: Text(
              S.of(context).signIn,
              style: const TextStyle(color: AppColors.realWhiteColor),
            ),
          ),
          const VerticalSpace(AppSize.s20),
        ],
      ),
    );
  }
}
