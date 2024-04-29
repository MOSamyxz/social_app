import 'package:chatapp/core/constants/theme.dart';
import 'package:chatapp/core/routes/app_router.dart';
import 'package:chatapp/core/services/app_lifecycle.dart';
import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/core/services/local_notifications.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/firebase_notifications.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/generated/l10n.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  await AwesomeNotificationServices().initializeNotifications();
  AppLifecycleObserver appLifecycleObserver = AppLifecycleObserver();
  WidgetsBinding.instance.addObserver(appLifecycleObserver);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool? isDark = CacheHelper.sharedPreferences.getBool('isDark');
  runApp(MyApp(
    isDark,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp(
    this.isDark, {
    super.key,
  });
  final bool? isDark;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseNotification().requestPermission();
    FirebaseNotification().setupFirebaseMessaging();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return App(isDark: widget.isDark);
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.isDark,
  });

  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..init()
        ..getUserData()
        ..changeAppMode(fromShared: isDark),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
              BlocProvider.of<AppCubit>(context).isDark
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark);
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
                locale: CacheHelper.sharedPreferences.getString('lang') == 'ar'
                    ? const Locale('ar')
                    : const Locale('en'),
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
