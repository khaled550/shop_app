import 'package:shop_app/data/model/home_model.dart';

abstract class HomeLayoutState {}

class HomeLayoutInitial extends HomeLayoutState {}

class NavBarChangeState extends HomeLayoutState {}

class BannerChangeState extends HomeLayoutState {}

class HomePageLoadingState extends HomeLayoutState {}

class HomePageSucState extends HomeLayoutState {
  final HomeModel homeModel;

  HomePageSucState(this.homeModel);
}

class HomePageFailedState extends HomeLayoutState {
  final String error;

  HomePageFailedState(this.error);
}

class HomeCatsSucState extends HomeLayoutState {
  HomeCatsSucState();
}

class HomeCatsFailedState extends HomeLayoutState {
  final String error;

  HomeCatsFailedState(this.error);
}
