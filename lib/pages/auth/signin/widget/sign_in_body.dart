import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/widgets/custom_text_button.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/signin/cubit/sign_in_cubit.dart';
import 'package:chatapp/pages/auth/signin/widget/dont_have_account.dart';
import 'package:chatapp/pages/auth/signin/widget/sign_in_form.dart';
import 'package:chatapp/core/widgets/terms_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({
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
                S.of(context).hello,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const VerticalSpace(AppSize.s10),
              Text(
                S.of(context).signInAndmakeNewFriends,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const VerticalSpace(AppSize.s10),
              const SignInForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    onTap: () {
                      GoRouter.of(context).push(Routes.forgetPasswordScreen);
                    },
                    buttonText: S.of(context).forgetPassword,
                  ),
                ],
              ),
              const VerticalSpace(AppSize.s20),
              DontHaveAnAccount(
                info: S.of(context).dontHaveAnAccount,
                buttonText: S.of(context).SignUp,
                onPressed: () {
                  GoRouter.of(context).push(Routes.signUpScreen);
                  BlocProvider.of<SignInCubit>(context).controlerDispose();
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
