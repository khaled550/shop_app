import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/model/user_model.dart';
import 'package:shop_app/data/network/repo.dart';

import 'login_signup_state.dart';

class LoginCubit extends Cubit<LoginSignupState> {
  static LoginCubit get(context) => BlocProvider.of(context);

  final Repo? repo;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isLogin = false;

  LoginCubit({this.repo}) : super(const LoginInitial());

  loginWithEmail(String email, String password) {
    emit(const LoginLoadingState());
    repo!.loginWithEmail(email: email, password: password).then((loginModel) {
      emit(LoginSuccessState(loginModel: loginModel));
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(LoginFailedState(error: error.toString()));
    });
  }

  signupWithEmail(UserModel user, String password) {
    emit(const SignupLoadingState());
    repo!.signupWithEmail(userModel: user, password: password).then((value) {
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
