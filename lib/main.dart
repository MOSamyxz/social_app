import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/cubit/localization_cubit.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/ar_en/ar_en_screen.dart';
import 'package:chatapp/pages/auth/signup/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalizationCubit()..init(),
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                      seedColor: const Color.fromARGB(255, 54, 177, 93)),
                  useMaterial3: true,
                ),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: BlocProvider.of<LocalizationCubit>(context).locale,
                home: CacheHelper.sharedPreferences.get('lang') == null
                    ? const ArEnScreen()
                    : const SignUpScreen(),
              );
            },
          );
        },
      ),
    );
  }
}







/* localizationsDelegates: const [
            AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar', ''),
            Locale('en', ''),
          ],
          localeResolutionCallback: (currentLang, supportLang) {
            if (currentLang != null) {
              for (Locale local in supportLang) {
                if (local.languageCode == currentLang.languageCode) {
                  return currentLang;
                }
              }
            }
            return supportLang.first;
          }, */