import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/custom_text_button.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/reset_password/cubit/reset_password_cubit.dart';
import 'package:chatapp/pages/auth/reset_password/widget/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: ScreenUtil.defaultSize.width,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(AppSize.r30))),
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              const VerticalSpace(AppSize.s20),
              Text(
                S.of(context).resetPassword,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const VerticalSpace(AppSize.s10),
              Text(
                S.of(context).enterTheEmail,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const VerticalSpace(AppSize.s10),
              const ResetPasswordForm(),
              const VerticalSpace(AppSize.s10),
              CustomTextButton(
                  onTap: () {
                    GoRouter.of(context).pop();
                    BlocProvider.of<ResetPasswordCubit>(context)
                        .controlerDispose();
                  },
                  buttonText: S.of(context).goBackToSignIn)
            ],
          ),
        ),
      ),
    );
  }
}
