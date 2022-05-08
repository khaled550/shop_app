import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../../../cubit/home_cubit/home_page_cubit.dart';
import '../../../constants/colors.dart';
import '../../widgets.dart';

import '../../../cubit/home_cubit/home_page_state.dart';
import '../../../constants/strings.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageCubit cubit = HomePageCubit.get(context);
    return BlocBuilder<HomePageCubit, HomeLayoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: myAppBar(
              tite: cubit.getTitle(context),
              onSearchPressed: () {
                //cubit.changeNavBarTab(4);
                navigateTo(context: context, pagePath: SEARCH_PAGE_PATH);
              },
              onCartPressed: () {
                navigateTo(context: context, pagePath: CART_PAGE_PATH);
              }),
          body: cubit.isLoaded
              ? cubit.pages[cubit.currNavIndex]
              : const Center(child: CircularProgressIndicator()),
          bottomNavigationBar: buildNavBar(context, cubit),
        );
      },
    );
  }

  Widget buildNavBar(BuildContext context, HomePageCubit cubit) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(8.0),
      color: isDark ? AppColors.mainBlackColor : Colors.white,
      child: GNav(
          rippleColor: Colors.blue[800]!, // tab button ripple color when pressed
          hoverColor: Colors.blue[700]!, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 10,
          tabActiveBorder: Border.all(color: Colors.black, width: 1.5), // tab button border
          curve: Curves.easeOutQuad, // tab animation curves
          duration: const Duration(milliseconds: 200), // tab animation duration
          gap: 2, // the tab button gap between icon and text
          color: isDark ? Colors.white : AppColors.mainBlackColor, // unselected icon color
          activeColor:
              isDark ? AppColors.mainBlackColor : Colors.white, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor:
              isDark ? Colors.white : AppColors.mainColor, // selected tab background color
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
          onTabChange: (index) {
            cubit.changeNavBarTab(index);
          },
          tabs: [
            gnBtn(text: getAppStrings(context).gn_home, icon: Icons.home),
            gnBtn(text: getAppStrings(context).gn_cat, icon: Icons.category_outlined),
            gnBtn(text: getAppStrings(context).gn_orders, icon: Icons.watch_later_outlined),
            gnBtn(text: getAppStrings(context).gn_profile, icon: LineIcons.user)
          ]),
    );
  }

  gnBtn({required String text, required IconData icon}) => GButton(
        iconColor: isDark ? Colors.white : AppColors.mainColor,
        icon: icon,
        text: text,
      );

  Widget buildHomeLayoutBody(HomePageCubit cubit) => cubit.pages[cubit.currNavIndex];
}
