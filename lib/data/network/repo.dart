import 'package:flutter/cupertino.dart';
import 'package:shop_app/data/model/category_model.dart';
import 'package:shop_app/data/model/home_model.dart';
import 'package:shop_app/data/model/login_model.dart';
import 'package:shop_app/data/model/product_model.dart';
import 'package:shop_app/data/model/signup_model.dart';
import 'package:shop_app/data/model/user_model.dart';

import 'network_service.dart';

class Repo {
  late final NetworkService networkService;

  Repo({required this.networkService});

  Future<LoginModel> loginWithEmail(
      {required BuildContext context, required String email, required String password}) async {
    return await networkService.loginWithEmail(context: context, email: email, password: password);
  }

  Future<SignupModel> signupWithEmail(
      {required BuildContext context,
      required UserModel userModel,
      required String password}) async {
    return await networkService.signupWithEmail(
        context: context, user: userModel, password: password);
  }

  Future<HomeModel> getHomeData(BuildContext context) async {
    return await networkService.getHomeData(context: context);
  }

  Future<CategoryModel> getCatsData({required BuildContext context}) async {
    return await networkService.getCatsData(context: context);
  }

  Future<ProductModel> getProductsData({required BuildContext context}) async {
    return await networkService.getProductsData(context: context);
  }

  Future<bool> updateFav({required BuildContext context, required int id}) async {
    return await networkService.updateFav(context: context, id: id);
  }

  Future<UserModel> getProfileData({required BuildContext context}) async {
    return await networkService.getProfileData(context: context);
  }

  Future<UserModel> updateProfileData(
      {required BuildContext context,
      required String name,
      required String email,
      required String phone}) async {
    return await networkService.updateProfileData(
        context: context, name: name, email: email, phone: phone);
  }
}
