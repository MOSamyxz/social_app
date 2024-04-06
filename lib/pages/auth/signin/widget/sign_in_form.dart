import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/core/functions/validation.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/core/widgets/custome_text_field.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/signin/cubit/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Form(
          key: BlocProvider.of<SignInCubit>(context).formkey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomeTextFormField(
                prefix: FontAwesomeIcons.envelope,
                controller: BlocProvider.of<SignInCubit>(context).email,
                hintText: S.of(context).emailAddress,
                validator: (input) {
                  return validInput(input!, 6, 32, 'email', context);
                },
              ),
              const VerticalSpace(AppSize.s10),
              CustomeTextFormField(
                prefix: Icons.lock,
                suffix: BlocProvider.of<SignInCubit>(context).ishide
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                suffixPressed: () {
                  BlocProvider.of<SignInCubit>(context).showPassword();
                },
                isPassword: BlocProvider.of<SignInCubit>(context).ishide,
                controller: BlocProvider.of<SignInCubit>(context).password,
                hintText: S.of(context).password,
                validator: (input) {
                  return validInput(input!, 6, 32, 'password', context);
                },
              ),
              const VerticalSpace(AppSize.s10),
              BlocListener<AppCubit, AppState>(
                listener: (contextb, state) {
                  if (state is GetCurrentUserDataSuccessState) {
                    Future.delayed(const Duration(seconds: 3));
                  }
                },
                child: CustomButton(
                  onPressed: () async {
                    BlocProvider.of<SignInCubit>(context)
                        .signIn(context)
                        .then((value) {
                      BlocProvider.of<AppCubit>(context).getUserData();
                    });
                  },
                  child: Text(
                    S.of(context).signIn,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: AppFontWeight.semiBold,
                        color: AppColors.realWhiteColor),
                  ),
                ),
              ),
              const VerticalSpace(AppSize.s10),
            ],
          ),
        );
      },
    );
  }
}
