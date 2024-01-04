import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/signin/widget/dont_have_account.dart';
import 'package:chatapp/pages/auth/signin/widget/sign_in_form.dart';
import 'package:chatapp/core/widgets/terms_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: ScreenUtil.defaultSize.width,
        decoration: const BoxDecoration(
            color: AppColors.realWhiteColor,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(AppSize.r30))),
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              const VerticalSpace(AppSize.s20),
              Text(
                S.of(context).hello,
                style: AppStyles.font24BoldBlack,
              ),
              const VerticalSpace(AppSize.s10),
              Text(
                S.of(context).signInAndmakeNewFriends,
                style: AppStyles.font16MediumlighterBlack,
                textAlign: TextAlign.center,
              ),
              const VerticalSpace(AppSize.s10),
              const SignInForm(),
              DontHaveAnAccount(
                info: S.of(context).dontHaveAnAccount,
                buttonText: S.of(context).SignUp,
                onPressed: () {},
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
