import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/reset_password/widget/reset_password_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

GlobalKey<FormState> formkey = GlobalKey<FormState>();

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const ResetPasswordBody(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
