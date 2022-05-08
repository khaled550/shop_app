import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/model/user_model.dart';
import 'package:shop_app/data/repos/login_signup_repo.dart';

import 'login_signup_state.dart';

class LoginCubit extends Cubit<LoginSignupState> {
  static LoginCubit get(context) => BlocProvider.of(context);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isLogin = true;

  final LoginSignupRepo repo;
  LoginCubit({required this.repo}) : super(const LoginInitial());

  Future<bool> loginWithEmail(String email, String password, String lang) async {
    emit(const LoginLoadingState());
    repo.loginWithEmail(lang: lang, email: email, password: password).then((loginModel) {
      emit(LoginSuccessState(loginModel: loginModel));
      return true;
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(LoginFailedState(error: error.toString()));
      return false;
    });
    return false;
  }

  signupWithEmail(UserModel user, String password, String lang) {
    emit(const SignupLoadingState());
    repo.signupWithEmail(userModel: user, password: password, lang: lang).then((value) {
      emit(SignupSuccessState(signupModel: value));
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(SignupFailedState(error: error.toString()));
    });
  }

  void changeUI() {
    isLogin = !isLogin;
    if (isLogin) {
      emit(const LoginInitial());
    } else {
      emit(const SignupInitial());
    }
  }
}
