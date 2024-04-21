import 'package:chatapp/core/constants/assets.dart';
import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/core/functions/validation.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/core/widgets/custom_drop_down_form_field.dart';
import 'package:chatapp/core/widgets/custome_text_field.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/auth/signup/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<SignUpCubit>(context).formkey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return Stack(
                children: [
                  BlocProvider.of<SignUpCubit>(context).image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(
                              BlocProvider.of<SignUpCubit>(context).image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: AssetImage(AppAssets.defProfile),
                        ),
                  Positioned(
                    bottom: 0,
                    left: 80,
                    child: CircleAvatar(
                      backgroundColor: AppColors.lighterBlueColor,
                      child: IconButton(
                        onPressed:
                            BlocProvider.of<SignUpCubit>(context).selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          const VerticalSpace(AppSize.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomeTextFormField(
                  prefix: FontAwesomeIcons.user,
                  controller: BlocProvider.of<SignUpCubit>(context).fName,
                  hintText: S.of(context).firstName,
                  validator: (input) {
                    return validInput(input!, 6, 16, 'username', context);
                  },
                ),
              ),
              const HorizontalSpace(5),
              Expanded(
                child: CustomeTextFormField(
                  prefix: FontAwesomeIcons.user,
                  controller: BlocProvider.of<SignUpCubit>(context).lName,
                  hintText: S.of(context).lastName,
                  validator: (input) {
                    return validInput(input!, 6, 16, 'username', context);
                  },
                ),
              ),
            ],
          ),
          const VerticalSpace(AppSize.s10),
          CustomeTextFormField(
            prefix: FontAwesomeIcons.envelope,
            controller: BlocProvider.of<SignUpCubit>(context).email,
            hintText: S.of(context).emailAddress,
            validator: (input) {
              return validInput(input!, 6, 16, 'email', context);
            },
          ),
          const VerticalSpace(AppSize.s10),
          CustomeTextFormField(
            prefix: Icons.lock,
            controller: BlocProvider.of<SignUpCubit>(context).password,
            hintText: S.of(context).password,
            validator: (input) {
              return validInput(input!, 6, 32, 'password', context);
            },
          ),
          const VerticalSpace(AppSize.s10),
          CustomDropDownFormField(
            prefix: FontAwesomeIcons.marsAndVenus,
            value: S.of(context).gender,
            items: BlocProvider.of<SignUpCubit>(context)
                .genderList
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: AppStyles.font14MediumlighterBlack,
                      ),
                    ))
                .toList(),
            onChanged: (e) {
              BlocProvider.of<SignUpCubit>(context).onSelectedGender(e!);
            },
            label: S.of(context).gender,
          ),
          const VerticalSpace(AppSize.s10),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return CustomButton(
                  onPressed: () {
                    if (BlocProvider.of<SignUpCubit>(context).image != null) {
                      BlocProvider.of<SignUpCubit>(context).signUp(context);
                    }
                    Fluttertoast.showToast(
                      msg: 'Please Pick a profile picture first',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  },
                  child: BlocProvider.of<SignUpCubit>(context).isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          S.of(context).SignUp,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  fontWeight: AppFontWeight.semiBold,
                                  color: AppColors.realWhiteColor),
                        ));
            },
          ),
          const VerticalSpace(AppSize.s20),
        ],
      ),
    );
  }
}
