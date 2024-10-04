import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/local/user_database.dart';
import '../../../presentation/application/bloc/app_bloc.dart';
import '../../../presentation/application/screens/application_screen.dart';
import '../../../presentation/authentication/screens/forgetPassword/forgot_notification.dart';
import '../../../presentation/authentication/screens/forgetPassword/forgot_password.dart';
import '../../../presentation/authentication/screens/login/bloc/login_bloc.dart';
import '../../../presentation/authentication/screens/login/screens/login_screen.dart';
import '../../../presentation/authentication/screens/register/bloc/register_bloc.dart';
import '../../../presentation/authentication/screens/register/screens/register_screen.dart';
import '../../../presentation/onboarding/bloc/onboarding_bloc.dart';
import '../../../presentation/onboarding/screens/onboarding_screen.dart';
import '../../../presentation/profile/bloc/profile_bloc.dart';
import '../../../presentation/profile/screens/profile_screen.dart';
import '../../global.dart';
import 'name.dart';

class AppPage {
  static List<PageEntity> routes = [
    PageEntity(
      route: AppRoutes.initial,
      page: OnBoardingScreen(),
      bloc: BlocProvider(
        create: (_) => OnBoardingBloc(),
      ),
    ),
    PageEntity(
      route: AppRoutes.login,
      page: const LoginScreen(),
      bloc: BlocProvider(
        create: (_) => LoginBloc(),
      ),
    ),
    PageEntity(
      route: AppRoutes.register,
      page: const RegistrationScreen(),
      bloc: BlocProvider(
        create: (_) => RegisterBloc(),
      ),
    ),
    PageEntity(
      route: AppRoutes.application,
      page: const ApplicationPage(),
      bloc: BlocProvider(
        create: (_) => AppBlocs(),
      ),
    ),
    PageEntity(
      route: AppRoutes.forgetPassword,
      page: ForgotPasswordScreen(),
    ),
    PageEntity(
      route: AppRoutes.forgetNotification,
      page: const ForgotNotificationScreen(),
    ),
    PageEntity(
      route: AppRoutes.profile,
      page: const ProfileScreen(),
      bloc: BlocProvider(
        create: (_) => ProfileBloc(databaseHelper: DatabaseHelper()),
      ),
    ),
  ];

  static List<BlocProvider> allBlocProviders(BuildContext context) {
    List<BlocProvider> blocProviders = <BlocProvider>[];
    for (var bloc in routes) {
      if (bloc.bloc != null) {
        blocProviders.add(bloc.bloc as BlocProvider);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    var result = routes.where((element) => element.route == settings.name);
    if (result.isNotEmpty) {
      bool deviceFirstOpen = Global.storageServices.getDeviceFirstOpen();
      bool isLoggedIn = Global.storageServices.getIsLoggedIn();

      if (result.first.route == AppRoutes.initial) {
        if (!deviceFirstOpen) {
          return MaterialPageRoute(
              builder: (_) => OnBoardingScreen(), settings: settings);
        } else if (isLoggedIn) {
          return MaterialPageRoute(
              builder: (_) => const ApplicationPage(), settings: settings);
        } else {
          return MaterialPageRoute(
              builder: (_) => const LoginScreen(), settings: settings);
        }
      }
      return MaterialPageRoute(
          builder: (_) => result.first.page, settings: settings);
    }
    return MaterialPageRoute(
        builder: (_) => OnBoardingScreen(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;
  PageEntity({required this.route, required this.page, this.bloc});
}
