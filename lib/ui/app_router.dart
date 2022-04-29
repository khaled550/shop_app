import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_cubit/home_page_cubit.dart';
import 'package:shop_app/data/network/repo.dart';
import 'package:shop_app/ui/page/home_layout.dart';
import 'package:shop_app/ui/page/login_signup_page.dart';
import 'package:shop_app/ui/page/on_boarding_page.dart';

import '../cubit/login_cubit/login_cubit.dart';
import '../data/network/endpoints.dart';
import '../data/network/network_service.dart';
import '../utils/shared_pref.dart';

class AppRouter {
  late Repo repo;

  AppRouter() {
    repo = Repo(networkService: NetworkService());
  }

  Route? generateRoute(RouteSettings settings) {
    String pagePath = settings.name!;
    bool isFirstTime = SharedPref.getData(key: ON_BOARDING_SHARED) ?? true;
    bool isLogged = SharedPref.getData(key: LOGIN_SHARED) ?? false;
    print('onboard?: $isFirstTime');
    if (isFirstTime) {
      pagePath = "/on_boarding";
    } else if (isLogged) {
      pagePath = "/home";
    }

    switch (pagePath) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginCubit(context: context, repo: repo),
                  child: const LoginSignupPage(),
                ));
      case "/home":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      HomePageCubit(context: context, repo: repo)..loadHomePageData(context),
                  child: const HomeLayout(),
                ));
      case "/on_boarding":
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      default:
        return null;
    }
  }
}
