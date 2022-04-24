import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shop_app/cubit/home_cubit/home_page_cubit.dart';
import 'package:shop_app/ui/app_router.dart';
import 'package:shop_app/ui/page/login_signup_page.dart';
import 'package:shop_app/l10n/l10n.dart';
import 'package:shop_app/utils/MyBlocObserver.dart';
import 'package:shop_app/utils/styles.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'data/network/network_service.dart';
import 'ui/page/home_page.dart';

void initialization() async {
  print('ready in 3...');
  await Future.delayed(const Duration(seconds: 1));
  print('ready in 2...');
  await Future.delayed(const Duration(seconds: 1));
  print('ready in 1...');
  await Future.delayed(const Duration(seconds: 1));
  print('go!');
  FlutterNativeSplash.remove();
}

void main() {
  BlocOverrides.runZoned(
    () {
      //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      //initialization();
      NetworkService.init();
      runApp(MyApp(
        appRouter: AppRouter(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: MaterialApp(
        onGenerateRoute: appRouter.generateRoute,
        supportedLocales: L10n.all,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        //darkTheme: appTheme(mainColor: Colors.black, secMainColor: Colors.white),
        //home: LoginPage(),
      ),
    );
  }
}
