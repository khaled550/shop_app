import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login_cubit/login_signup_state.dart';
import 'package:shop_app/data/model/user_model.dart';
import 'package:shop_app/data/network/endpoints.dart';
import 'package:shop_app/ui/page/home_layout.dart';
import 'package:shop_app/utils/colors.dart';
import 'package:shop_app/utils/components.dart';
import 'package:shop_app/utils/shared_pref.dart';

import '../../cubit/login_cubit/login_cubit.dart';

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
          if (state is LoginSuccessState) {
            print(state.loginModel.message);
            if (state.loginModel.status!) {
              SharedPref.putData(key: 'token', value: state.loginModel.data!.token);
              SharedPref.putData(key: LOGIN_SHARED, value: true).then((value) {
                if (value) {
                  showDoneModal(
                      context: context,
                      text: state.loginModel.message!,
                      iconData: Icons.done_outlined,
                      pagePath: HOME_PAGE_PATH);
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
                  backgroungColor: Colors.white),
              const SizedBox(
                height: 20,
              ),
              defaultBtn(
                  context: context,
                  onPressed: () {},
                  text: cubit.isLogin
                      ? getAppStrings(context).login_via_facebook
                      : getAppStrings(context).signup_via_facebook,
                  backgroungColor: Colors.white),
              const SizedBox(
                height: 100,
              ),
              defaultBtn(
                  context: context,
                  onPressed: () {
                    buildBottomSheet(context, cubit);
                  },
                  text: cubit.isLogin
                      ? getAppStrings(context).login_via_email
                      : getAppStrings(context).signup_via_email,
                  textColor: Colors.white,
                  backgroungColor: AppColors.mainColor)
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

  buildBottomSheet(context, LoginCubit cubit) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(20), topStart: Radius.circular(20))),
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) => FractionallySizedBox(
              heightFactor: 0.85,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  //key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          bigText(
                              context: context,
                              color: AppColors.mainBlackColor,
                              size: 16,
                              text: cubit.isLogin
                                  ? getAppStrings(context).login_via_email
                                  : getAppStrings(context).signup_via_email),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white70,
                        child: defaultTextField(
                            context: context,
                            text: getAppStrings(context).enter_email,
                            controller: cubit.emailController,
                            validateText: 'Email must not be empty',
                            onSubmitted: (value) {},
                            prefixIcon: Icons.email_outlined),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white70,
                        child: defaultTextField(
                            context: context,
                            text: getAppStrings(context).enter_password,
                            keyboardType: TextInputType.visiblePassword,
                            controller: cubit.passwordController,
                            onSubmitted: (value) {
                              submitLogin(context, cubit);
                            },
                            validateText: 'Date must not be empty',
                            onTap: () {},
                            prefixIcon: Icons.lock_outline),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      cubit.isLogin
                          ? clickableText(() {}, getAppStrings(context).forgot_password)
                          : Column(
                              children: [
                                defaultTextField(
                                    context: context,
                                    text: getAppStrings(context).confirm_password,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: cubit.confirmPasswordController,
                                    onSubmitted: (value) {
                                      //submitLogin();
                                    },
                                    validateText: '',
                                    onTap: () {},
                                    prefixIcon: Icons.lock_outline),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultTextField(
                                    context: context,
                                    text: getAppStrings(context).enter_name,
                                    keyboardType: TextInputType.name,
                                    controller: cubit.nameController,
                                    onSubmitted: (value) {
                                      //submitLogin();
                                    },
                                    validateText: '',
                                    onTap: () {},
                                    prefixIcon: Icons.person_outline),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultTextField(
                                    context: context,
                                    text: getAppStrings(context).enter_phone,
                                    keyboardType: TextInputType.phone,
                                    controller: cubit.phoneController,
                                    onSubmitted: (value) {
                                      //submitLogin();
                                    },
                                    validateText: '',
                                    onTap: () {},
                                    prefixIcon: Icons.phone_android_outlined),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocProvider.value(
                        value: cubit,
                        child: BlocBuilder<LoginCubit, LoginSignupState>(
                          builder: (context, state) {
                            //cubit = LoginCubit.get(c);
                            if (cubit.isLogin) {
                              if (state is LoginLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return defaultBtn(
                                    context: context,
                                    text: getAppStrings(context).login_title,
                                    backgroungColor: AppColors.mainColor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      //showDoneModal(context, getAppStrings(context).login_suc);
                                      submitLogin(context, cubit);
                                    });
                              }
                            } else {
                              if (state is SignupLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return defaultBtn(
                                    context: context,
                                    text: getAppStrings(context).signup_title,
                                    backgroungColor: AppColors.mainColor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      //showDoneModal(context, getAppStrings(context).login_suc);
                                      submitSignup(cubit);
                                    });
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  void submitLogin(context, LoginCubit cubit) {
    //cubit.loginWithEmail('khaled.mohamed@gmail.com', '123456');
    cubit.loginWithEmail(cubit.emailController.text, cubit.passwordController.text);
  }

  void submitSignup(LoginCubit cubit) {
    cubit.signupWithEmail(
        UserModel(
          name: cubit.nameController.text,
          email: cubit.emailController.text,
          phone: cubit.emailController.text,
        ),
        cubit.passwordController.text);
  }
}
