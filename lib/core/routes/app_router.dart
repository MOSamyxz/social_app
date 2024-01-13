import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/pages/ar_en/ar_en_screen.dart';
import 'package:chatapp/pages/auth/reset_password/reset_password_screen.dart';
import 'package:chatapp/pages/auth/signin/signin_screen.dart';
import 'package:chatapp/pages/auth/signup/signup_screen.dart';
import 'package:chatapp/pages/auth/verification/verification_screen.dart';
import 'package:chatapp/pages/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            CacheHelper.sharedPreferences.getString('lang') == null
                ? const ArEnScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        // Checking if the snapshot has any data or not
                        if (snapshot.hasData) {
                          // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                          return HomeScreen();
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        }
                      }
                      // means connection to future hasnt been made yet
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return const SignInScreen();
                    },
                  ),
      ),
      GoRoute(
        path: Routes.signInScreen,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: Routes.forgetPasswordScreen,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: Routes.verificationScreen,
        builder: (context, state) => const VerificationScreen(),
      ),
      GoRoute(
        path: Routes.signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: Routes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
