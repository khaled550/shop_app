import '../../constants/strings.dart';
import '../model/login_model.dart';
import '../model/signup_model.dart';
import '../model/user_model.dart';
import '../dio_helper.dart';

class LoginSignupApi {
  Future<LoginModel> loginWithEmail(
      {required String lang,
      required String email,
      required String password}) async {
    LoginModel loginModel = LoginModel();
    await DioHelper.postData(lang: lang, url: LOGIN, data: {
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

  Future<SignupModel> signupWithEmail(
      {required String lang,
      required UserModel user,
      required String password}) async {
    await DioHelper.postData(lang: lang, url: SIGNUP, data: {
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
