import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/signup/cubit/sign_up_cubit.dart';
import 'package:chatapp/pages/auth/signup/widget/sign_up_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        backgroundColor: AppColors.darkBlueColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const VerticalSpace(AppSize.s20),
                    Text(
                      S.of(context).hwar,
                      style: AppStyles.font24BoldWhite,
                    ),
                    const VerticalSpace(AppSize.s20),
                    const SignUpBody(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
