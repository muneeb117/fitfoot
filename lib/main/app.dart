import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../presentation/cart/provider/cart_provider.dart';
import 'navigation/routes/name.dart';
import 'navigation/routes/page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...AppPage.allBlocProviders(context),
    ChangeNotifierProvider(
    create: (context) => CartProvider(),
    ),
    ],
      child: ScreenUtilInit(
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppPage.generateRouteSettings,
            initialRoute: AppRoutes.initial,
            themeMode: ThemeMode.dark,
            theme: AppTheme(context: context).darkTheme,
            darkTheme: AppTheme(context: context).darkTheme,
          );
        },
      ),
    );
  }
}
