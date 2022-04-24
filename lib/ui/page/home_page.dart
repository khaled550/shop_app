import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_cubit/home_page_cubit.dart';
import 'package:shop_app/data/network/endpoints.dart';
import 'package:shop_app/utils/components.dart';
import 'package:shop_app/utils/shared_pref.dart';

import '../../cubit/home_cubit/home_page_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(getAppStrings(context).app_title),
              actions: [
                IconButton(
                    onPressed: (() {
                      signout(context);
                    }),
                    icon: const Icon(Icons.close))
              ],
            ),
            body: Center(
              child: Text(getAppStrings(context).language),
            ));
      },
    );
  }

  void signout(BuildContext context) {
    SharedPref.removeData(key: 'token').then((value) {
      SharedPref.removeData(key: LOGIN_SHARED).then((value) {
        navigateAndReplace(context, LOGIN_PAGE_PATH);
      });
    });
  }
}
