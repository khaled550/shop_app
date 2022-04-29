import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/model/category_model.dart';
import 'package:shop_app/data/model/home_model.dart';
import 'package:shop_app/data/model/product_model.dart';
import 'package:shop_app/data/model/user_model.dart';
import 'package:shop_app/ui/page/categories_page.dart';
import 'package:shop_app/ui/page/home_page.dart';
import 'package:shop_app/ui/page/orders_page.dart';
import 'package:shop_app/ui/page/settings_page.dart';

import '../../data/model/user_model.dart';
import '../../data/network/repo.dart';
import 'home_page_state.dart';

class HomePageCubit extends Cubit<HomeLayoutState> {
  final Repo repo;
  final BuildContext? context;
  HomePageCubit({required this.context, required this.repo}) : super(HomeLayoutInitial());

  static HomePageCubit get(context) => BlocProvider.of(context);

  //NavigationBar items
  int currNavIndex = 0;
  List<Widget> pages = [HomePage(), CategoriesPage(), OrdersPage(), SettingsPage()];

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

  loadHomePageData(BuildContext context) {
    emit(HomePageLoadingState());
    repo.getHomeData(context).then((value) {
      homeModel = value;
      loadHomePageCatsData();
    }).onError((error, stackTrace) {
      print(error);
      emit(HomePageFailedState(error.toString()));
    });
  }

  CategoryModel? categoryModel;
  loadHomePageCatsData() {
    repo.getCatsData(context: context!).then((value) {
      categoryModel = value;
      loadProductsData();
    }).onError((error, stackTrace) {
      print(error);
      emit(HomeCatsFailedState(error.toString()));
    });
  }

  //load products
  ProductModel? productModel;
  Map<int, bool>? favProducts = {};
  loadProductsData() {
    repo.getProductsData(context: context!).then((value) {
      productModel = value;

      for (var element in value.products!) {
        print('FavData: ${element.inFavorites} for id: ${element.id}');
        print('addedd');
        favProducts!.addAll({
          element.id!: element.inFavorites!,
        });
      }
      loadProfileData();
    }).onError((error, stackTrace) {
      print(error);
      emit(HomeCatsFailedState(error.toString()));
    });
  }

  //update favourite
  Future<bool> updateFav({required BuildContext context, required int id}) async {
    return repo.updateFav(context: context, id: id).then((value) {
      print(favProducts!);
      if (value) {
        favProducts![id] = !favProducts![id]!;
        emit(UpdateFavSucState());
      } else {
        emit(UpdateFavFailedState('try again'));
      }
      return value;
    }).onError((error, stackTrace) {
      emit(UpdateFavFailedState(error.toString()));
      return false;
    });
  }

  //load profile data
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UserModel userProfile = UserModel();
  loadProfileData() {
    repo.getProfileData(context: context!).then((value) {
      userProfile = value;
      emailController.text = userProfile.email!;
      nameController.text = userProfile.name!;
      phoneController.text = userProfile.phone!;
      passwordController.text = '123456';
      isLoaded = true;
      emit(HomePageSucState());
    }).onError((error, stackTrace) {
      print(error);
      emit(ProfileDataFailedState(error.toString()));
    });
  }

  updateProfileData() {
    emit(UpdateProfileDataLoadingState());
    repo
        .updateProfileData(
            context: context!,
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text)
        .then((value) {
      userProfile = value;
      emit(UpdateProfileDataSucState());
    }).onError((error, stackTrace) {
      print(error);
      emit(UpdateProfileDataFailedState(error.toString()));
    });
  }
}
