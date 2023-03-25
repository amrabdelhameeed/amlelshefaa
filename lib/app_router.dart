import 'package:amlelshefaa/core/models/doctor.dart';
import 'package:amlelshefaa/core/models/exercise_model.dart';
import 'package:amlelshefaa/core/models/fake_screen_atg.dart';
import 'package:amlelshefaa/features/authentication/choose_photo/choose_photo_screen.dart';
import 'package:amlelshefaa/features/authentication/exercise/screens/upload_exercise.dart';
import 'package:amlelshefaa/features/authentication/sign_up/sign_up_as_doctor.dart';
import 'package:amlelshefaa/features/fake_payment.dart/screens/fake_payment.dart';
import 'package:amlelshefaa/screens/doctor_screen.dart';
import 'package:amlelshefaa/screens/exercise_screen.dart';

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
              ..getCurrentFirestoreUser()
              ..goToHome(),
            child: HomeLayout(),
          );
        });
      case fakePaymentScreen:
        final fake = settings.arguments as FakeScreenArgument;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: FakePriceScreen(
              fakeScreenArgument: fake,
            ),
          );
        });
      case exerciseScreen:
        final exercise = settings.arguments as ExerciseModel;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: ExerciseScreen(exerciseModel: exercise),
          );
        });
      case mainScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
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
      case doctorScreen:
        return MaterialPageRoute(builder: (_) {
          final arg = settings.arguments as Doctor;
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: DoctorScreen(
              doctorModel: arg,
            ),
          );
        });
      case uploadExerciseScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: UploadExercise(),
          );
        });
      case choosePhotoScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: ChoosePhotoScreen(),
          );
        });
      case signUpAsDoctorScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: SignUpAsDoctorPage(),
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
