import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_app/cubit/home_cubit/home_page_cubit.dart';
import 'package:shop_app/data/network/endpoints.dart';
import 'package:shop_app/utils/colors.dart';
import 'package:shop_app/utils/components.dart';
import 'package:shop_app/utils/shared_pref.dart';

import '../../cubit/home_cubit/home_page_state.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageCubit cubit = HomePageCubit.get(context);
    return BlocConsumer<HomePageCubit, HomeLayoutState>(
      listener: (context, state) {
        print(state);
        if (state is HomeLayoutInitial) {}
        if (state is NavBarChangeState) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: cubit.pages[cubit.currNavIndex],
          bottomNavigationBar: buildNavBar(context),
        );
      },
    );
  }

  Widget buildNavBar(BuildContext context) {
    HomePageCubit cubit = HomePageCubit.get(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: GNav(
          rippleColor: Colors.blue[800]!, // tab button ripple color when pressed
          hoverColor: Colors.blue[700]!, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 10,
          tabActiveBorder: Border.all(color: Colors.black, width: 1.5), // tab button border
          curve: Curves.easeOutQuad, // tab animation curves
          duration: const Duration(milliseconds: 200), // tab animation duration
          gap: 2, // the tab button gap between icon and text
          color: AppColors.mainBlackColor, // unselected icon color
          activeColor: Colors.white, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor: AppColors.mainColor, // selected tab background color
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
          onTabChange: (index) {
            cubit.changeNavBar(index);
          },
          tabs: [
            GButton(
              iconColor: AppColors.mainColor,
              icon: Icons.home,
              text: getAppStrings(context).gn_home,
            ),
            GButton(
              iconColor: AppColors.mainColor,
              icon: Icons.category_outlined,
              text: getAppStrings(context).gn_cat,
            ),
            GButton(
              iconColor: AppColors.mainColor,
              icon: Icons.watch_later_outlined,
              text: getAppStrings(context).gn_orders,
            ),
            GButton(
              iconColor: AppColors.mainColor,
              icon: LineIcons.user,
              text: getAppStrings(context).gn_profile,
            )
          ]),
    );
  }

  void signout(BuildContext context) {
    SharedPref.removeData(key: 'token').then((value) {
      SharedPref.removeData(key: LOGIN_SHARED).then((value) {
        navigateAndReplace(context, LOGIN_PAGE_PATH);
      });
    });
  }

  Widget buildHomeLayoutBody(BuildContext context, HomePageCubit cubit) =>
      cubit.pages[cubit.currNavIndex];
}
