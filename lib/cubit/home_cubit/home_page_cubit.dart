import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/model/address_model.dart';
import '../../data/model/cart_model.dart';
import '../../data/model/category_model.dart';
import '../../data/model/home_model.dart';
import '../../data/model/product_model.dart';
import '../../data/model/user_model.dart';
import '../../data/repos/home_repo.dart';
import '../../ui/page/home_layout/categories_page.dart';
import '../../ui/page/home_layout/home_page.dart';
import '../../ui/page/home_layout/orders_page.dart';
import '../../ui/page/home_layout/search_page.dart';
import '../../ui/page/home_layout/settings_page.dart';
import '../../ui/widgets.dart';

import 'home_page_state.dart';

class HomePageCubit extends Cubit<HomeLayoutState> {
  final HomeRepo repo;
  //final BuildContext context;
  HomePageCubit({required this.repo}) : super(HomeLayoutInitial());

  static HomePageCubit get(context) => BlocProvider.of(context);

  //NavigationBar items
  int currNavIndex = 0;
  List<Widget> pages = [
    HomePage(),
    CategoriesPage(),
    OrdersPage(),
    SettingsPage(),
    SearchProductPage(),
  ];

  String getTitle(BuildContext context) {
    List<String> pagesTitles = [
      getAppStrings(context).app_title,
      getAppStrings(context).app_title,
      getAppStrings(context).app_title,
      getAppStrings(context).app_title,
    ];
    return pagesTitles[currNavIndex];
  }

  void changeNavBarTab(int index) {
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
    repo.getHomeData(getAppStrings(context).language).then((value) {
      homeModel = value;
      loadHomePageCatsData(context);
    }).onError((error, stackTrace) {
      print(error);
      emit(HomePageFailedState(error.toString()));
    });
  }

  CategoryModel? categoryModel;
  loadHomePageCatsData(BuildContext context) {
    repo.getCatsData(lang: getAppStrings(context).language).then((value) {
      categoryModel = value;
      loadProductsData(context);
    }).onError((error, stackTrace) {
      print(error);
      emit(HomeCatsFailedState(error.toString()));
    });
  }

  //load products
  ProductModel? productModel;
  Map<int, bool> isFavouriteMap = {};
  Map<int, bool> inCartMap = {};
  loadProductsData(BuildContext context) {
    repo.getProductsData(lang: getAppStrings(context).language).then((value) {
      productModel = value;
      for (var element in value.products!) {
        isFavouriteMap.addAll({
          element.id!: element.inFavorites!,
        });
        inCartMap.addAll({
          element.id!: element.inCart!,
        });
      }
      print('inCartMap: $inCartMap');
      loadProfileData(context);
    }).onError((error, stackTrace) {
      print(error);
      emit(HomeCatsFailedState(error.toString()));
    });
  }

  //update favourite
  Future<bool> updateFav({required BuildContext context, required int id}) async {
    return repo.updateFav(id: id, lang: getAppStrings(context).language).then((value) {
      print(isFavouriteMap);
      if (value) {
        isFavouriteMap[id] = !isFavouriteMap[id]!;
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
  loadProfileData(BuildContext context) {
    repo.getProfileData(lang: getAppStrings(context).language).then((value) {
      userProfile = value;
      emailController.text = userProfile.email!;
      nameController.text = userProfile.name!;
      phoneController.text = userProfile.phone!;
      passwordController.text = '123456';
      getOrders(context);
      isLoaded = true;
      emit(HomePageSucState());
    }).onError((error, stackTrace) {
      print(error);
      emit(ProfileDataFailedState(error.toString()));
    });
  }

  updateProfileData(String lang) {
    emit(UpdateProfileDataLoadingState());
    repo
        .updateProfileData(
            lang: lang,
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

  //update cart items
  bool updateItemInCart({
    required BuildContext context,
    required int productId,
  }) {
    emit(UpdateCartDataLoadingState());
    repo.updateCart(lang: getAppStrings(context).language, id: productId).then((value) {
      if (value) {
        inCartMap[productId] = !inCartMap[productId]!;
        //emit(AddToCartDataSucState());
        getCartItems(context: context);
      } else {
        emit(UpdateCartDataFailedState('try again'));
      }
      return value;
    }).onError((error, stackTrace) {
      print('error cart load: $error');
      emit(UpdateCartDataFailedState(error.toString()));
      return false;
    });
    return false;
  }

  //Cart page
  //List<CartItem>
  double subtotalCart = 0.0;
  //double totalCart = 0.0;
  Map<int, int> itemsQtyMap = {};

  void getCartItems({
    required BuildContext context,
  }) {
    emit(UpdateCartDataLoadingState());
    repo.getCartItems(lang: getAppStrings(context).language).then(
      (cartItems) {
        for (var element in cartItems) {
          itemsQtyMap[element.id!] = element.quantity!;
          /* itemsQtyMap.addAll({
          element.id!: element.!,
        }); */
        }
        calculateCart(context: context, cartItems: cartItems);
      },
    );
  }

  void calculateCart({
    required BuildContext context,
    required List<CartItem> cartItems,
  }) {
    subtotalCart = 0.0;
    for (var item in cartItems) {
      subtotalCart += item.product!.price! * item.quantity!;
    }
    //totalCart = subtotalCart + 50; //shipping
    emit(UpdateCartDataSucState(cartItems, subtotalCart));
  }

  //Items qty

  void updateQtyInCart({
    required BuildContext context,
    required int productCartId,
    required double productPrice,
    required bool isIncrement,
  }) {
    //emit(UpdateCartDataLoadingState());
    int qty = 0;
    if (isIncrement && itemsQtyMap[productCartId]! < 5) {
      qty = 1;
      subtotalCart = subtotalCart + productPrice;
    } else if (!isIncrement && itemsQtyMap[productCartId]! > 1) {
      qty = -1;
      subtotalCart = subtotalCart - productPrice;
    } else {
      return;
    }

    repo
        .updateQtyInCart(
      lang: getAppStrings(context).language,
      id: productCartId,
      qty: itemsQtyMap[productCartId]! + qty,
    )
        .then((value) {
      itemsQtyMap[productCartId] = itemsQtyMap[productCartId]! + qty;
      emit(UpdateItemQty(itemsQtyMap[productCartId]!));
    });
    /* .then((value) {
      if (_) {
        getCartItems(context: context);
      } else {
        emit(UpdateCartDataFailedState('try again'));
      }
      return value;
    }).onError((error, stackTrace) {
      print('error cart load: $error');
      emit(UpdateCartDataFailedState(error.toString()));
      return false;
    }); */
  }

  //Search Page
  List<Product> searchedProducts = [];
  void updateSearchList(String productName) {
    if (productName.isNotEmpty && productModel != null) {
      searchedProducts = productModel!.products!
          .where((product) => product.name!.toLowerCase().startsWith(productName))
          .toList();
    } else {
      searchedProducts = [];
    }
    emit(UpdateSearchedListState(searchedProducts));
  }

  //Orders Page
  void getOrders(BuildContext context) {
    repo.getOrders(lang: getAppStrings(context).language).then((ordersList) {
      print('${ordersList.length} orders');
      emit(LoadingOrdersSucState(ordersList));
    });
  }

  //Address Page
  void getAddresses({
    required BuildContext context,
  }) {
    emit(LoadingAdressesState());
    repo.getAddresses(lang: getAppStrings(context).language).then((ordersList) {
      emit(LoadingAdressesSucState(ordersList));
    }).onError((error, stackTrace) {
      print('error getAddresses: $error');
      emit(LoadingAdressesFailedState(error.toString()));
    });
  }

  Future<void> addAddress({
    required BuildContext context,
    required Address address,
  }) async {
    emit(AddAdressLoadingState());
    return repo
        .addNewAddress(
      lang: getAppStrings(context).language,
      address: address,
    )
        .whenComplete(() {
      emit(AddAdressesSucState());
    });
  }
}
