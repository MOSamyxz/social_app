import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/cubit/localization_cubit.dart';
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
                text: 'Ar'),
            CustomButton(
                onPressed: () {
                  BlocProvider.of<LocalizationCubit>(context).setLangEn();
                  GoRouter.of(context).pushReplacement(Routes.signInScreen);
                },
                text: 'En'),
          ],
        ),
      ),
    );
  }
}
