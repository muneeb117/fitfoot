import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/local/user_database.dart';
import '../../presentation/application/bloc/app_bloc.dart';
import '../../presentation/authentication/screens/login/bloc/login_bloc.dart';
import '../../presentation/authentication/screens/register/bloc/register_bloc.dart';
import '../../presentation/onboarding/bloc/onboarding_bloc.dart';
import '../../presentation/profile/bloc/profile_bloc.dart';
import '../../presentation/profile/bloc/profile_event.dart';

class AppBlocProviders {
  static get allBlocProvider => [
        BlocProvider(create: (BuildContext context) => OnBoardingBloc()),
        BlocProvider(
          create: (BuildContext context) =>
              ProfileBloc(databaseHelper: DatabaseHelper())..add(LoadProfile()),
        ),
        BlocProvider(create: (BuildContext context) => LoginBloc()),
        BlocProvider(create: (BuildContext context) => RegisterBloc()),
        BlocProvider(create: (BuildContext context) => AppBlocs()),
      ];
}
