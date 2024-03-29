import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/signup/cubit/sign_up_cubit.dart';
import 'package:chatapp/pages/auth/signup/widget/already_have_account.dart';
import 'package:chatapp/pages/auth/signup/widget/sign_up_form.dart';
import 'package:chatapp/core/widgets/terms_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(AppSize.r30))),
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              const VerticalSpace(AppSize.s20),
              Text(
                S.of(context).getStartedFree,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const VerticalSpace(AppSize.s10),
              const SignUpForm(),
              AlreadyHaveAnAccount(
                info: S.of(context).alreadyHaveAnAccount,
                buttonText: S.of(context).signIn,
                onPressed: () {
                  GoRouter.of(context).pop();
                  BlocProvider.of<SignUpCubit>(context).controlerDispose();
                },
              ),
              const VerticalSpace(AppSize.s20),
              const TermsAndConditions(),
              const VerticalSpace(AppSize.s20),
            ],
          ),
        ),
      ),
    );
  }
}
