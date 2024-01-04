import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/cubit/localization_cubit.dart';
import 'package:chatapp/pages/auth/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                text: 'Ar'),
            CustomButton(
                onPressed: () {
                  BlocProvider.of<LocalizationCubit>(context).setLangEn();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                text: 'En'),
          ],
        ),
      ),
    );
  }
}
