import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'constants/strings.dart';
import 'app_router.dart';
import 'constants/MyBlocObserver.dart';
import 'package:shop_app/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/dio_helper.dart';
import 'constants/shared_pref.dart';
import 'constants/styles.dart';

void initialization() async {
  /* print('ready in 3...');
  await Future.delayed(const Duration(seconds: 1));
  print('ready in 2...');
  await Future.delayed(const Duration(seconds: 1));
  print('ready in 1...');
  await Future.delayed(const Duration(seconds: 1));
  print('go!');
  FlutterNativeSplash.remove(); */
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  await SharedPref.init();
  BlocOverrides.runZoned(
    () {
      //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      //initialization();

      bool isDark = SharedPref.getData(key: APP_THEME) ?? false;
      print('USER_TOKEN: $USER_TOKEN');
      /* runApp(DevicePreview(
          builder: (context) => MyApp(
                isDark: isDark,
                appRouter: AppRouter(),
              ))); */
      runApp(MyApp(
        appRouter: AppRouter(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Dimentions.initDimentions(context);
    //final bool isDark = Settings.getValue<bool>(APP_THEME, false);
    return ValueChangeObserver<bool>(
        cacheKey: APP_THEME,
        defaultValue: false,
        builder: (_, isDarkMode, __) {
          isDark = isDarkMode;
          return MaterialApp(
            builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              breakpoints: const [
                ResponsiveBreakpoint.resize(350, name: MOBILE),
                ResponsiveBreakpoint.autoScale(600, name: TABLET),
                ResponsiveBreakpoint.resize(800, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
              ],
            ),
            //builder: DevicePreview.appBuilder,
            onGenerateRoute: appRouter.generateRoute,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: appTheme(),
            darkTheme: appDarkTheme(),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            //home: const CartPage(),
          );
        });
  }
}
