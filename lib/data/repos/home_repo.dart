import 'package:shop_app/data/model/address_model.dart';
import 'package:shop_app/data/model/cart_model.dart';
import 'package:shop_app/data/model/order_model.dart';

import '../model/category_model.dart';
import '../model/home_model.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';

import '../../constants/shared_pref.dart';
import '../api/home_api.dart';

class HomeRepo {
  late final HomeApi homeApi;

  HomeRepo({required this.homeApi});

  Future<HomeModel> getHomeData(String lang) async {
    return await homeApi.getHomeData();
  }

  Future<CategoryModel> getCatsData({required String lang}) async {
    return await homeApi.getCatsData(lang: lang);
  }

  Future<ProductModel> getProductsData({required String lang}) async {
    return await homeApi.getProductsData(lang: lang);
  }

  Future<UserModel> getProfileData({required String lang}) async {
    UserModel userModel = UserModel();
    await homeApi.getProfileData(lang: lang).then((value) {
      userModel = UserModel.fromJson(value.data['data']);
      SharedPref.putData(key: 'token', value: userModel.token).whenComplete(() {
        print('User getProfileData: ${userModel.token} saved');
      });
    }).onError((error, stackTrace) {
      print(error);
    });
    return userModel;
  }

  Future<UserModel> updateProfileData(
      {required String lang,
      required String name,
      required String email,
      required String phone}) async {
    UserModel userModel = UserModel();
    await homeApi.updateProfileData(
        lang: lang, data: {'name': name, 'phone': phone, 'email': email}).then((value) {
      userModel = UserModel.fromJson(value.data['data']);
      print('User getProfileData: ${userModel.email}');
      SharedPref.putData(key: 'token', value: userModel.token).whenComplete(() {
        print('User getProfileData: ${userModel.token} saved');
      });
    });
    return userModel;
  }

  Future<List<CartItem>> getCartItems({
    required String lang,
  }) async {
    List<CartItem> cartItems = [];
    await homeApi.getCartItems(lang: lang).then((value) {
      cartItems = value.data!;
      print('cartItems.length:: ');
      print(cartItems.length);
      //return cartItems;
    });
    return cartItems;
  }

  Future<bool> updateFav({
    required String lang,
    required int id,
  }) async {
    return await homeApi.updateCartFav(lang: lang, id: id, isCart: false);
  }

  Future<bool> updateCart({
    required String lang,
    required int id,
  }) async {
    return await homeApi.updateCartFav(lang: lang, id: id, isCart: true);
  }

  Future<void> updateQtyInCart({lang, required int id, required int qty}) async {
    await homeApi.updateQtyInCart(lang: lang, productCartId: id, qty: qty);
  }

  Future<List<Order>> getOrders({
    required String lang,
  }) async {
    List<Order> orders = [];
    await homeApi.fetchOrdersData(lang: lang).then((value) {
      for (var order in value.data['data']['data']!) {
        orders.add(Order.fromJson(order));
      }
      print('orders.length: ${orders.length}');
    }).onError((error, stackTrace) {
      print('error orders: $error');
    });
    return orders;
  }

  Future<List<Address>> getAddresses({
    required String lang,
  }) async {
    List<Address> addresses = [];
    await homeApi.fetchAddressesData(lang: lang).then((value) {
      for (var address in value.data['data']['data']!) {
        addresses.add(Address.fromJson(address));
      }
      print('addresses.length: ${addresses.length}');
    }).onError((error, stackTrace) {
      print('error orders: $error');
    });
    return addresses;
  }

  Future<void> addNewAddress({required String lang, required Address address,}) async {
    //Address address = Address();
    await homeApi.addNewAddress(lang: lang, address: address).then((value) {
      //address = Address.fromJson(value.data['data']['data']!);
      print('addNewAddress: ${value.data['data']['data']!}');
    });
    return ;
  }
}
