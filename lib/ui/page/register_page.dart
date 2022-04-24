import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/utils/colors.dart';
import 'package:shop_app/utils/components.dart';

/*class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: LoginCubit.get(context).scaffoldKey,
      appBar: AppBar(
        title: Text(getAppStrings(context).login_title),
      ),
      body: buildLoginUI(context, state),
    );
  }

  Widget buildLoginUI(BuildContext context, state) => Padding(
    padding: const EdgeInsetsDirectional.only(top: 16, bottom: 30, start: 16, end: 16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            defaultBtn(
                context: context,
                onPressed: () {},
                text: getAppStrings(context).login_via_google,
                backgroungColor: Colors.white),
            const SizedBox(
              height: 20,
            ),
            defaultBtn(
                context: context,
                onPressed: () {},
                text: getAppStrings(context).login_via_facebook,
                backgroungColor: Colors.white),
            const SizedBox(
              height: 100,
            ),
            defaultBtn(
                context: context,
                onPressed: () {
                  buildBottomSheet(context);
                },
                text: getAppStrings(context).login_via_email,
                textColor: Colors.white,
                backgroungColor: AppColors.mainColor),
          ],
        ),
        Text(getAppStrings(context).no_account)
      ],
    ),
  );

  buildBottomSheet(context) {
    var cubit = LoginCubit.get(context);
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
                          text: getAppStrings(context).login_via_email),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
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
                          submitLogin(value);
                        },
                        validateText: 'Date must not be empty',
                        onTap: () {},
                        prefixIcon: Icons.lock_outline),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  clickableText(() {}, getAppStrings(context).forgot_password),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultBtn(
                      context: context,
                      text: getAppStrings(context).login_title,
                      backgroungColor: AppColors.mainColor,
                      textColor: Colors.white,
                      onPressed: () {
                        showDoneModal(context, getAppStrings(context).login_suc);
                      })
                ],
              ),
            ),
          ),
        ));
  }

  void submitLogin(String value) {}
}*/
