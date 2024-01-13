import 'package:chatapp/core/constants/theme.dart';
import 'package:chatapp/core/routes/app_router.dart';
import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/generated/l10n.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool? isDark = CacheHelper.sharedPreferences.getBool('isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  const MyApp(
    this.isDark, {
    super.key,
  });
  final bool? isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..init()
        ..changeAppMode(fromShared: isDark),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: BlocProvider.of<AppCubit>(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale:
                    Locale(CacheHelper.sharedPreferences.getString('lang')!),
                routerConfig: AppRouter.router,
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