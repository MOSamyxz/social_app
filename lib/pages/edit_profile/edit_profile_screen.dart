import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/core/functions/validation.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/core/widgets/custom_drop_down_form_field.dart';
import 'package:chatapp/core/widgets/custome_text_field.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/edit_profile/cubit/eidtprofile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.profileUser});
  final UsersModel profileUser;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EidtProfileCubit()
        ..init(
          username: profileUser.userName,
          userbio: profileUser.bio,
          userbirthday: profileUser.birthDay,
          usergender: profileUser.gender,
        ),
      child: BlocBuilder<EidtProfileCubit, EidtProfileState>(
        builder: (context, state) {
          ImageProvider<Object> coverImage;

          if (BlocProvider.of<EidtProfileCubit>(context).cover == null) {
            coverImage = NetworkImage(profileUser.coverUrl!);
          } else {
            coverImage =
                MemoryImage(BlocProvider.of<EidtProfileCubit>(context).cover!);
          }
          ImageProvider<Object> profileImage;

          if (BlocProvider.of<EidtProfileCubit>(context).profile == null) {
            profileImage = NetworkImage(profileUser.imageUrl);
          } else {
            profileImage = MemoryImage(
                BlocProvider.of<EidtProfileCubit>(context).profile!);
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: AppPadding.screenPadding,
                child: Form(
                  key: BlocProvider.of<EidtProfileCubit>(context).formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: ScreenUtil().screenWidth,
                        height: 0.25.sh,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                      width: ScreenUtil().screenWidth,
                                      height: 0.2.sh,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: coverImage,
                                        ),
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<EidtProfileCubit>(context)
                                          .selectCoverImage();
                                    },
                                    child: const CircleAvatar(
                                        backgroundColor:
                                            AppColors.lightBlackColor,
                                        child: FaIcon(FontAwesomeIcons.camera)),
                                  )
                                ],
                              ),
                            ),
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: AppSize.r55,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    CircleAvatar(
                                      radius: AppSize.r50,
                                      backgroundImage: profileImage,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<EidtProfileCubit>(context)
                                        .selectProfileImage();
                                  },
                                  child: CircleAvatar(
                                      radius: AppSize.r20,
                                      backgroundColor:
                                          AppColors.lightBlackColor,
                                      child: const FaIcon(
                                          FontAwesomeIcons.camera)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const VerticalSpace(AppSize.s10),
                      CustomeTextFormField(
                        controller:
                            BlocProvider.of<EidtProfileCubit>(context).userName,
                        hintText: 'Username',
                        prefix: FontAwesomeIcons.user,
                        validator: (input) {
                          return validInput(input!, 6, 32, 'username', context);
                        },
                      ),
                      const VerticalSpace(AppSize.s10),
                      CustomeTextFormField(
                        controller:
                            BlocProvider.of<EidtProfileCubit>(context).bio,
                        prefix: FontAwesomeIcons.penNib,
                        hintText: 'Bio',
                        validator: (input) {
                          return validInput(input!, 6, 2000, 'empty', context);
                        },
                      ),
                      const VerticalSpace(AppSize.s10),
                      CustomeTextFormField(
                        isReadOnly: true,
                        isShowCursor: true,
                        prefix: FontAwesomeIcons.calendarDays,
                        onTab: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2050),
                          ).then((value) {
                            BlocProvider.of<EidtProfileCubit>(context)
                                .birthday
                                .text = DateFormat.yMMMd().format(value!);
                          });
                        },
                        controller:
                            BlocProvider.of<EidtProfileCubit>(context).birthday,
                        hintText: 'Birthday',
                        validator: (input) {
                          return validInput(input!, 6, 32, 'empty', context);
                        },
                      ),
                      const VerticalSpace(AppSize.s10),
                      CustomDropDownFormField(
                        value: profileUser.gender == 'Male'
                            ? S.of(context).male
                            : S.of(context).female,
                        prefix: FontAwesomeIcons.marsAndVenus,
                        items: BlocProvider.of<EidtProfileCubit>(context)
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
                          BlocProvider.of<EidtProfileCubit>(context)
                              .onSelectedGender(e!);
                        },
                        label: S.of(context).gender,
                      ),
                      const VerticalSpace(AppSize.s10),
                      CustomButton(
                          onPressed: () {
                            if (BlocProvider.of<EidtProfileCubit>(context)
                                    .cover !=
                                null) {
                              BlocProvider.of<EidtProfileCubit>(context)
                                  .updateCover();
                            }
                            if (BlocProvider.of<EidtProfileCubit>(context)
                                    .profile !=
                                null) {
                              BlocProvider.of<EidtProfileCubit>(context)
                                  .updateProfile();
                            }
                            BlocProvider.of<EidtProfileCubit>(context)
                                .updateData();
                          },
                          child: BlocProvider.of<EidtProfileCubit>(context)
                                  .isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Edit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: AppFontWeight.semiBold,
                                          color: AppColors.realWhiteColor),
                                ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
