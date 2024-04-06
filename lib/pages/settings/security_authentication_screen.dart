import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/core/functions/validation.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/core/widgets/custome_text_field.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/settings/cubit/security_auth_cubit.dart';
import 'package:chatapp/pages/settings/widgets/setting_category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecurityAndAuthenticationScreen extends StatelessWidget {
  const SecurityAndAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;

    return BlocProvider(
      create: (context) => SecurityAuthCubit(),
      child: BlocBuilder<SecurityAuthCubit, SecurityAuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Security & Authentication'),
            ),
            body: Form(
              key: BlocProvider.of<SecurityAuthCubit>(context).emailKey,
              child: Padding(
                padding: AppPadding.screenPadding,
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SettingCategory(
                      title: 'Update email',
                    ),
                    const VerticalSpace(10),
                    CustomeTextFormField(
                      prefix: FontAwesomeIcons.envelope,
                      controller:
                          BlocProvider.of<SecurityAuthCubit>(context).email,
                      hintText: 'New Email',
                      validator: (input) {
                        return validInput(input!, 6, 32, 'email', context);
                      },
                    ),
                    const VerticalSpace(10),
                    CustomeTextFormField(
                      prefix: FontAwesomeIcons.lock,
                      controller:
                          BlocProvider.of<SecurityAuthCubit>(context).password,
                      hintText: 'Password',
                      validator: (input) {
                        return validInput(input!, 6, 32, 'password', context);
                      },
                    ),
                    const VerticalSpace(10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            height: AppSize.s30,
                            onPressed: () async {
                              bool checkCurrentPassword =
                                  await BlocProvider.of<SecurityAuthCubit>(
                                          context)
                                      .validateCurrentPasswordForEmail(context);
                              if (checkCurrentPassword) {
                                // ignore: use_build_context_synchronously
                                await BlocProvider.of<SecurityAuthCubit>(
                                        context)
                                    .updateEmail(context);
                              }
                            },
                            child: Text(
                              'Update',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
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
                              if (FirebaseAuth.instance.currentUser!.email !=
                                  user.email) {
                                BlocProvider.of<SecurityAuthCubit>(context)
                                    .updateEmailInFirestore();
                                Navigator.pop(context);
                              }
                              Navigator.pop(context);
                            },
                            child: Text(
                              'back',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontWeight: AppFontWeight.semiBold,
                                      color: AppColors.realWhiteColor),
                            ),
                          ),
                        )
                      ],
                    ),
                    Form(
                      key: BlocProvider.of<SecurityAuthCubit>(context)
                          .passwordKey,
                      child: Column(
                        children: [
                          const SettingCategory(
                            title: 'Update Password',
                          ),
                          const VerticalSpace(10),
                          CustomeTextFormField(
                            prefix: Icons.lock,
                            controller:
                                BlocProvider.of<SecurityAuthCubit>(context)
                                    .oldPassword,
                            hintText: 'Old Password Email',
                            validator: (input) {
                              return validInput(
                                  input!, 6, 32, 'password', context);
                            },
                          ),
                          const VerticalSpace(10),
                          CustomeTextFormField(
                            prefix: Icons.lock,
                            controller:
                                BlocProvider.of<SecurityAuthCubit>(context)
                                    .newPassword,
                            hintText: 'New Password',
                            validator: (input) {
                              return validInput(
                                  input!, 6, 32, 'password', context);
                            },
                          ),
                          const VerticalSpace(10),
                          CustomeTextFormField(
                            prefix: Icons.lock,
                            controller:
                                BlocProvider.of<SecurityAuthCubit>(context)
                                    .reNewPassword,
                            hintText: 're-Enter New Password',
                            validator: (input) {
                              return validInput(
                                  input!, 6, 32, 'password', context);
                            },
                          ),
                          const VerticalSpace(10),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  height: AppSize.s30,
                                  onPressed: () async {
                                    bool checkCurrentPassword =
                                        await BlocProvider.of<
                                                SecurityAuthCubit>(context)
                                            .validateCurrentPassword(context);
                                    if (checkCurrentPassword) {
                                      // ignore: use_build_context_synchronously
                                      await BlocProvider.of<SecurityAuthCubit>(
                                              context)
                                          .updatePassword();
                                    }
                                  },
                                  child: Text(
                                    'Update',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
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
                                    if (FirebaseAuth
                                            .instance.currentUser!.email !=
                                        user.email) {
                                      BlocProvider.of<SecurityAuthCubit>(
                                              context)
                                          .updateEmailInFirestore();
                                      Navigator.pop(context);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'back',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            fontWeight: AppFontWeight.semiBold,
                                            color: AppColors.realWhiteColor),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
