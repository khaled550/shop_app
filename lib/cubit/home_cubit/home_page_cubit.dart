import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/model/category_model.dart';
import 'package:shop_app/data/model/home_model.dart';
import 'package:shop_app/ui/page/categories_page.dart';
import 'package:shop_app/ui/page/home_page.dart';
import 'package:shop_app/ui/page/orders_page.dart';
import 'package:shop_app/ui/page/profile_page.dart';

import '../../data/network/repo.dart';
import 'home_page_state.dart';

class HomePageCubit extends Cubit<HomeLayoutState> {
  final Repo repo;
  HomePageCubit({required this.repo}) : super(HomeLayoutInitial());

  static HomePageCubit get(context) => BlocProvider.of(context);

  //NavigationBar items
  int currNavIndex = 0;
  List<Widget> pages = [HomePage(), CategoriesPage(), const OrdersPage(), const ProfilePage()];

  void changeNavBar(int index) {
    currNavIndex = index;
    emit(NavBarChangeState());
  }

  //Banner
  double currBannerPage = 0.0;
  PageController pageController = PageController(viewportFraction: .8);

  void updateBannerDots(int index) {
    currBannerPage = index.toDouble();
  }

  //Load home data
  bool isLoaded = false;
  HomeModel? homeModel;

  loadHomePageData() {
    emit(HomePageLoadingState());
    repo.getHomeData().then((value) {
      homeModel = value;
      loadHomePageCatsData();
    }).onError((error, stackTrace) {
      print(error);
      emit(HomePageFailedState(error.toString()));
    });
  }

  CategoryModel? categoryModel;
  loadHomePageCatsData() {
    repo.getCatsData().then((value) {
      isLoaded = true;
      categoryModel = value;
      emit(HomeCatsSucState());
    }).onError((error, stackTrace) {
      print(error);
      emit(HomeCatsFailedState(error.toString()));
    });
  }
}
