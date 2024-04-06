import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/firebase_auth/firebase_auth.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/edit_profile/edit_profile_screen.dart';
import 'package:chatapp/pages/settings/privacy_policy_screen.dart';
import 'package:chatapp/pages/settings/security_authentication_screen.dart';
import 'package:chatapp/pages/settings/widgets/setting_button_tile.dart';
import 'package:chatapp/pages/settings/widgets/setting_category.dart';
import 'package:chatapp/pages/settings/widgets/setting_switch_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Column(children: [
            const SettingCategory(
              title: 'General',
            ),
            SettingSwitchTile(
              leadingIcon: Icons.brightness_4_outlined,
              firstSwitchIcon: FontAwesomeIcons.sun,
              secondeSwitchIcon: FontAwesomeIcons.moon,
              leadingTitle: 'Theme',
              currentValue: BlocProvider.of<AppCubit>(context).isDark ? 1 : 0,
              onChanged: (i) {
                BlocProvider.of<AppCubit>(context).changeAppMode();
              },
            ),
            SettingSwitchTile(
              leadingIcon: Icons.translate_outlined,
              firstTextIcon: 'عربي',
              secondeTextIcon: 'انجليزي',
              leadingTitle: 'Language',
              currentValue:
                  CacheHelper.sharedPreferences.getString('lang') == 'en'
                      ? 1
                      : 0,
              onChanged: (i) {
                BlocProvider.of<AppCubit>(context).changLang();
              },
            ),
            const SettingCategory(
              title: 'Account and Security',
            ),
            SettingButtonTile(
              onTap: () {
                UsersModel profileUser =
                    BlocProvider.of<AppCubit>(context).getUser;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                              profileUser: profileUser,
                            )));
              },
              leadingIcon: FontAwesomeIcons.user,
              leadingTitle: 'Account Information',
            ),
            SettingButtonTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const SecurityAndAuthenticationScreen()));
                },
                leadingIcon: Icons.verified_user_outlined,
                leadingTitle: 'Security & Authentication'),
            const SettingCategory(
              title: 'About App',
            ),
            SettingButtonTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen()));
                },
                leadingIcon: Icons.lock,
                leadingTitle: 'Privacy Policy'),
            const SettingButtonTile(
                leadingIcon: Icons.assignment,
                leadingTitle: 'Terms & Conditions'),
            const SettingButtonTile(
                leadingIcon: Icons.group, leadingTitle: 'About Us'),
            const SettingButtonTile(
              leadingIcon: Icons.info_outline,
              leadingTitle: 'App Version',
              trillingText: '1.0.0',
            ),
            const SettingCategory(
              title: ' ',
            ),
            SettingButtonTile(
              leadingIcon: Icons.logout,
              leadingTitle: 'Sign Out',
              onTap: () async {
                await FirebaseAuthServices().signOut(context);
              },
            ),
          ]);
        },
      ),
    );
  }
}
