import 'package:shop_app/data/model/category_model.dart';
import 'package:shop_app/data/model/home_model.dart';
import 'package:shop_app/data/model/product_model.dart';
import 'package:shop_app/data/model/user_model.dart';

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

  Future<bool> updateFav({required String lang, required int id}) async {
    return await homeApi.updateCartFav(lang: lang, id: id, isCart: false);
  }

  Future<bool> updateCart({required String lang, required int id}) async {
    return await homeApi.updateCartFav(lang: lang, id: id, isCart: true);
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
}
