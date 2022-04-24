import 'package:shop_app/data/model/signup_model.dart';
import 'package:shop_app/data/model/user_model.dart';

import '../../data/model/login_model.dart';

abstract class LoginSignupState {
  const LoginSignupState();
}

class LoginInitial extends LoginSignupState {
  const LoginInitial();
}

class LoginSuccessState extends LoginSignupState {
  final LoginModel loginModel;
  LoginSuccessState({required this.loginModel});
}

class LoginFailedState extends LoginSignupState {
  final String error;
  const LoginFailedState({required this.error});
}

class LoginLoadingState extends LoginSignupState {
  const LoginLoadingState();
}

class SignupInitial extends LoginSignupState {
  const SignupInitial();
}

class SignupSuccessState extends LoginSignupState {
  final int? userId;
  final SignupModel signupModel;
  const SignupSuccessState({this.userId, required this.signupModel});
}

class SignupFailedState extends LoginSignupState {
  final String error;
  const SignupFailedState({required this.error});
}

class SignupLoadingState extends LoginSignupState {
  const SignupLoadingState();
}
