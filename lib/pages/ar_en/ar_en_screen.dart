import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/cubit/localization_cubit.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ArEnScreen extends StatelessWidget {
  const ArEnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              onPressed: () {
                BlocProvider.of<LocalizationCubit>(context).setLangAr();
                GoRouter.of(context).push(Routes.signInScreen);
              },
              child: Text(
                S.of(context).ar,
                style: const TextStyle(color: AppColors.realWhiteColor),
              ),
            ),
            CustomButton(
              onPressed: () {
                BlocProvider.of<LocalizationCubit>(context).setLangEn();
                GoRouter.of(context).pushReplacement(Routes.signInScreen);
              },
              child: Text(
                S.of(context).en,
                style: const TextStyle(color: AppColors.realWhiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
