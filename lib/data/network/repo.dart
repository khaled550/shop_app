import 'package:shop_app/data/model/login_model.dart';
import 'package:shop_app/data/model/signup_model.dart';
import 'package:shop_app/data/model/user_model.dart';

import 'network_service.dart';

class Repo {
  late final NetworkService networkService;

  Repo({required this.networkService});

  Future<LoginModel> loginWithEmail({required String email, required String password}) async {
    return await networkService.loginWithEmail(email: email, password: password);
  }

  Future<SignupModel> signupWithEmail(
      {required UserModel userModel, required String password}) async {
    return await networkService.signupWithEmail(user: userModel, password: password);
  }
}
