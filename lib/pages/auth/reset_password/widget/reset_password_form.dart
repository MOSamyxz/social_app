import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/core/functions/validation.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/core/widgets/custome_text_field.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/reset_password/cubit/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<ResetPasswordCubit>(context).formkey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomeTextFormField(
            controller: BlocProvider.of<ResetPasswordCubit>(context).email,
            hintText: S.of(context).emailAddress,
            validator: (input) {
              return validInput(input!, 6, 16, 'email', context);
            },
          ),
          const VerticalSpace(AppSize.s20),
          CustomButton(
            onPressed: () {
              BlocProvider.of<ResetPasswordCubit>(context)
                  .resetPassword(context);
            },
            child: Text(
              S.of(context).sendVerifyCode,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: AppFontWeight.semiBold,
                  color: AppColors.realWhiteColor),
            ),
          )
        ],
      ),
    );
  }
}
