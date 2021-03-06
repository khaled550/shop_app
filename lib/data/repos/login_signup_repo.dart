import '../api/login_signup_api.dart';
import '../model/login_model.dart';
import '../model/signup_model.dart';
import '../model/user_model.dart';

class LoginSignupRepo {
  late final LoginSignupApi loginSignupApi;

  LoginSignupRepo({required this.loginSignupApi});

  Future<LoginModel> loginWithEmail(
      {required String lang,
      required String email,
      required String password}) async {
    return await loginSignupApi.loginWithEmail(
        lang: lang, email: email, password: password);
  }

  Future<SignupModel> signupWithEmail({
    required UserModel userModel,
    required String password,
    required String lang,
  }) async {
    return await loginSignupApi.signupWithEmail(
        lang: lang, user: userModel, password: password);
  }
}
