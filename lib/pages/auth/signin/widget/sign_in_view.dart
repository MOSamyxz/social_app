import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/signin/cubit/sign_in_cubit.dart';
import 'package:chatapp/pages/auth/signin/widget/sign_in_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const VerticalSpace(AppSize.s20),
                  Text(
                    S.of(context).hwar,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const VerticalSpace(AppSize.s20),
                  const SignInBody(),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
