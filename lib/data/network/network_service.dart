import 'package:dio/dio.dart';
import 'package:shop_app/data/model/login_model.dart';
import 'package:shop_app/data/model/signup_model.dart';
import 'package:shop_app/data/network/endpoints.dart';

import '../model/user_model.dart';

class NetworkService {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(baseUrl: BASE_URL, receiveDataWhenStatusError: true));
  }

  Future<Response> getData({required String url, required Map<String, dynamic> query}) async {
    return await dio.get(url, queryParameters: query);
  }

  Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'ar',
      String? token}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  Future<LoginModel> loginWithEmail({required String email, required String password}) async {
    LoginModel loginModel = LoginModel();
    await postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print('User login: ${value.data}');
      loginModel = LoginModel.fromJson(value.data);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
    return loginModel;
  }

  Future<SignupModel> signupWithEmail({required UserModel user, required String password}) async {
    await postData(url: SIGNUP, data: {
      'name': user.name,
      'email': user.email,
      'password': password,
      'phone': user.phone,
    }).then((value) {
      print('User signup: ${value.data['data']['token']}');
      return value.data;
    }).onError((error, stackTrace) {
      print(error.toString());
      SignupModel();
    });
    return SignupModel();
  }
}
