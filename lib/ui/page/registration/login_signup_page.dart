import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/login_cubit/login_signup_state.dart';
import '../../../data/model/user_model.dart';
import '../../../constants/strings.dart';
import '../../widgets.dart';
import '../../../constants/shared_pref.dart';

import '../../../cubit/login_cubit/login_cubit.dart';

class LoginSignupPage extends StatelessWidget {
  const LoginSignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: LoginCubit.get(context).scaffoldKey,
      appBar: AppBar(
        title: Text(getAppStrings(context).app_title),
      ),
      body: BlocConsumer<LoginCubit, LoginSignupState>(
        listener: (context, state) {
          print(state);
          if (state is LoginLoadingState) {
            showLoadingModal(context);
          }
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              SharedPref.putData(key: 'token', value: state.loginModel.data!.token);
              SharedPref.putData(key: LOGIN_SHARED, value: true).then((value) {
                if (value) {
                  showDoneModal(
                    context: context,
                    text: state.loginModel.message!,
                    iconData: Icons.done_outlined,
                    pagePath: HOME_PAGE_PATH,
                  );
                }
              });
            } else {
              showDoneModal(
                  context: context, text: state.loginModel.message!, iconData: Icons.error_outline);
            }
          } else {}
        },
        builder: (context, state) {
          return BlocBuilder<LoginCubit, LoginSignupState>(
            builder: (context, state) {
              return buildLoginUI(context);
            },
          );
        },
      ),
    );
  }

  Widget buildLoginUI(BuildContext context) {
    LoginCubit cubit = LoginCubit.get(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 16, bottom: 30, start: 16, end: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              defaultBtn(
                context: context,
                onPressed: () {},
                text: cubit.isLogin
                    ? getAppStrings(context).login_via_google
                    : getAppStrings(context).signup_via_google,
              ),
              const SizedBox(
                height: 20,
              ),
              defaultBtn(
                context: context,
                onPressed: () {},
                text: cubit.isLogin
                    ? getAppStrings(context).login_via_facebook
                    : getAppStrings(context).signup_via_facebook,
              ),
              const SizedBox(
                height: 100,
              ),
              cubit.isLogin
                  ? defaultBtn(
                      context: context,
                      onPressed: () {
                        buildAuthBottomSheet(
                            context: context,
                            title: cubit.isLogin
                                ? getAppStrings(context).login_via_email
                                : getAppStrings(context).signup_via_email,
                            emailController: cubit.emailController,
                            passwordController: cubit.passwordController,
                            isLogin: cubit.isLogin,
                            btnText: cubit.isLogin
                                ? getAppStrings(context).login_via_email
                                : getAppStrings(context).signup_via_email,
                            cubit: cubit,
                            onPressedBtn: () {
                              submitLogin(context, cubit);
                            });
                      },
                      text: cubit.isLogin
                          ? getAppStrings(context).login_via_email
                          : getAppStrings(context).signup_via_email,
                      //textColor: Colors.white,
                      //backgroungColor: AppColors.mainColor
                    )
                  : defaultBtn(
                      context: context,
                      onPressed: () {
                        buildAuthBottomSheet(
                            context: context,
                            title: getAppStrings(context).signup_via_email,
                            emailController: cubit.emailController,
                            passwordController: cubit.passwordController,
                            isLogin: cubit.isLogin,
                            btnText: getAppStrings(context).signup_via_email,
                            cubit: cubit,
                            onPressedBtn: () {});
                      },
                      text: getAppStrings(context).signup_via_email,
                      //textColor: Colors.white,
                      //backgroungColor: AppColors.mainColor
                    )
              /*BlocBuilder<LoginCubit, LoginSignupState>(
                builder: (c, state) {
                  return defaultBtn(
                      context: c,
                      onPressed: () {
                        //submitLogin();
                        buildBottomSheet(c, cubit);
                      },
                      text: cubit.isLogin
                          ? getAppStrings(context).login_via_email
                          : getAppStrings(context).signup_via_email,
                      textColor: Colors.white,
                      backgroungColor: AppColors.mainColor);
                },
              ),*/
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(cubit.isLogin
                  ? getAppStrings(context).no_account
                  : getAppStrings(context).have_account),
              cubit.isLogin
                  ? clickableText(() {
                      cubit.changeUI();
                    }, getAppStrings(context).signup)
                  : clickableText(() {
                      cubit.changeUI();
                    }, getAppStrings(context).login_title),
            ],
          )
        ],
      ),
    );
  }

  void submitLogin(BuildContext context, LoginCubit cubit) {
    //cubit.loginWithEmail('khaled.mohamed@gmail.com', '123456');
    Navigator.pop(context);
    cubit
        .loginWithEmail(
      cubit.emailController.text,
      cubit.passwordController.text,
      getAppStrings(context).language,
    )
        .then((value) {
      if (value) {}
    });
  }

  void submitSignup(BuildContext context, LoginCubit cubit) {
    cubit.signupWithEmail(
      UserModel(
        name: cubit.nameController.text,
        email: cubit.emailController.text,
        phone: cubit.emailController.text,
      ),
      cubit.passwordController.text,
      getAppStrings(context).language,
    );
  }
}
