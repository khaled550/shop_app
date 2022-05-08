import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_cubit/home_page_cubit.dart';
import 'package:shop_app/data/model/product_model.dart';
import 'package:shop_app/data/repos/home_repo.dart';
import 'package:shop_app/data/repos/login_signup_repo.dart';
import 'package:shop_app/ui/page/home_layout.dart';
import 'package:shop_app/ui/page/login_signup_page.dart';
import 'package:shop_app/ui/page/on_boarding_page.dart';
import 'package:shop_app/ui/page/product_details.dart';

import 'cubit/login_cubit/login_cubit.dart';
import 'constants/strings.dart';
import 'data/api/home_api.dart';
import 'data/api/login_signup_api.dart';
import 'constants/shared_pref.dart';
import 'ui/page/search_page.dart';

class AppRouter {
  late LoginSignupRepo loginSignupRepo;
  late HomeRepo homeRepo;
  late HomePageCubit homePageCubit;

  AppRouter() {
    loginSignupRepo = LoginSignupRepo(loginSignupApi: LoginSignupApi());
    homeRepo = HomeRepo(homeApi: HomeApi());
    homePageCubit = HomePageCubit(repo: homeRepo);
    //homePageCubit = HomePageCubit(repo: homeRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    String pagePath = settings.name!;
    bool isFirstTime = SharedPref.getData(key: ON_BOARDING_SHARED) ?? true;
    bool isLogged = SharedPref.getData(key: LOGIN_SHARED) ?? false;
    print('onboard?: $isFirstTime');
    if (isFirstTime) {
      pagePath = "/on_boarding";
    } else if (isLogged && pagePath == '/') {
      pagePath = "/home";
    }

    switch (pagePath) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginCubit(repo: loginSignupRepo),
                  child: const LoginSignupPage(),
                ));
      case HOME_PAGE_PATH:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: homePageCubit..loadHomePageData(context),
                  child: const HomeLayout(),
                ));
      case PRODUCT_PAGE_PATH:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: homePageCubit,
                  child: ProductDetailsPage(product: product),
                ),
            settings: settings);
      case "/on_boarding":
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      case SEARCH_PAGE_PATH:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: homePageCubit,
                  child: SearchProductPage(),
                ));
    }
    return null;
  }
}
