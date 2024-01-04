import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/pages/ar_en/ar_en_screen.dart';
import 'package:chatapp/pages/auth/signin/signin_screen.dart';
import 'package:chatapp/pages/auth/signup/signup_screen.dart';
import 'package:chatapp/pages/home/home_screen.dart';
import 'package:go_router/go_router.dart';
/*
class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.langScreen:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

*/

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ArEnScreen(),
      ),
      GoRoute(
        path: Routes.signInScreen,
        builder: (context, state) => const SignInScreen(),
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
