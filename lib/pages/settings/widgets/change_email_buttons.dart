import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/settings/cubit/security_auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeEmailButtons extends StatelessWidget {
  const ChangeEmailButtons({
    super.key,
    required this.user,
  });

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            height: AppSize.s30,
            onPressed: () async {
              bool checkCurrentPassword =
                  await BlocProvider.of<SecurityAuthCubit>(context)
                      .validateCurrentPasswordForEmail(context);
              if (checkCurrentPassword) {
                // ignore: use_build_context_synchronously
                await BlocProvider.of<SecurityAuthCubit>(context)
                    .updateEmail(context);
              }
            },
            child: Text(
              'Update',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: AppFontWeight.semiBold,
                  color: AppColors.realWhiteColor),
            ),
          ),
        ),
        const HorizontalSpace(10),
        Expanded(
          child: CustomButton(
            height: AppSize.s30,
            onPressed: () {
              if (FirebaseAuth.instance.currentUser!.email != user.email) {
                BlocProvider.of<SecurityAuthCubit>(context)
                    .updateEmailInFirestore();
                Navigator.pop(context);
              }
              Navigator.pop(context);
            },
            child: Text(
              'back',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: AppFontWeight.semiBold,
                  color: AppColors.realWhiteColor),
            ),
          ),
        )
      ],
    );
  }
}
