import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/network/repo.dart';
import 'package:shop_app/ui/page/home_page.dart';
import 'package:shop_app/ui/page/login_signup_page.dart';
import 'package:shop_app/ui/page/register_page.dart';

import '../cubit/login_cubit/login_cubit.dart';
import '../data/network/network_service.dart';

class AppRouter {
  late Repo repo;

  AppRouter() {
    repo = Repo(networkService: NetworkService());
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (_) => const HomePage());
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginCubit(repo: repo),
                  child: LoginSignupPage(),
                ));
      case "/register":
        return MaterialPageRoute(builder: (_) => LoginSignupPage());
      default:
        return null;
    }
  }
}
