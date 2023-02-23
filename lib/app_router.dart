import 'bloc/cubit/app_cubit.dart';
import 'core/constants/strings.dart';
import 'core/models/book_model.dart';
import 'core/models/user_model.dart';
import 'features/authentication/sign_up/signup_screen.dart';
import 'features/choosing_categories_screen/intersted_screen.dart';
import 'features/home/home_screen.dart';
import 'features/on_boarding/on_boarding_screen.dart';
import 'features/on_boarding/sign_in_up_screen.dart';
import 'features/on_boarding/splash_view.dart';
import 'screens/home_layout.dart';
import 'screens/profile.dart';
import 'screens/visitor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/sign_in/signin_screen.dart';

AuthCubit? authCubit;

class AppRouter {
  AppRouter() {
    authCubit = AuthCubit();
  }

  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: const OnBoardingScreen(),
          );
        });
      case splashScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: const SplashView(),
          );
        });

      case homeLayout:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!
              // ..getCurrentFirestoreUser()
              ..getHorrorBooks()
              ..getTechnologyBooks()
              ..getFantasyBooks()
              ..getnovelBooks()
              ..getfictionBooks()
              ..getbiographyBooks(),
            child: HomeLayout(),
          );
        });

      case mainScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!..getCurrentFirestoreUser(),
            child: HomeScreen(),
          );
        });
      // case loginScreen:
      //   return MaterialPageRoute(builder: (_) {
      //     return BlocProvider<AuthCubit>.value(
      //       value: authCubit!,
      //       child: LoginScreen(),
      //     );
      //   });
      // case visitorScreen:
      //   return MaterialPageRoute(builder: (_) {
      //     final userModel = settings.arguments as UserModel;
      //     return BlocProvider<AuthCubit>.value(
      //       value: authCubit!..getUserBooks(uId: userModel.userUid),
      //       child: VisitorScreen(userModel: userModel),
      //     );
      //   });
      case signInUpScreen:
        return MaterialPageRoute(builder: (_) {
          return SignInUPScreen();
        });

      case chossingCategoryScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: const CategoryScreen(),
          );
        });
      case profileScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!..getUserBooks(),
            child: ProfileScreen(),
          );
        });
      case registerScreen:
        return MaterialPageRoute(builder: (_) {
          final type = settings.arguments as String;
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: SignupPage(type: type),
          );
        });
      case loginScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: SigninPage(),
          );
        });
      case categoryScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: CategoryScreen(),
          );
        });
    }
    return null;
  }
}
