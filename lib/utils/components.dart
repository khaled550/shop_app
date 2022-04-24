import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shop_app/ui/page/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'colors.dart';

// onboarding pages list
PageViewModel introPages(String imgPath) => PageViewModel(
      title: "Title of first page",
      body: "Here you can write the description of the page, to explain someting...",
      image: Center(child: Image.asset(imgPath, height: 175.0)),
      decoration: const PageDecoration(
        pageColor: Colors.white,
      ),
    );

navigateTo(BuildContext context, String pagePath) {
  Navigator.pushNamed(context, pagePath);
}

navigateAndReplace(BuildContext context, String pagePath) {
  Navigator.pushReplacementNamed(context, pagePath);
}

getAppStrings(BuildContext context) {
  return AppLocalizations.of(context);
}

Widget defaultBtn({
  required BuildContext context,
  hieght = 50.0,
  width = double.infinity,
  backgroungColor = Colors.white,
  textColor = AppColors.mainBlackColor,
  required String text,
  required void Function()? onPressed,
}) =>
    SizedBox(
      height: hieght,
      width: width,
      child: DecoratedBox(
        decoration:
            BoxDecoration(color: backgroungColor, borderRadius: BorderRadius.circular(10.0)),
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            //backgroundColor: backgroungColor,
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          /* child: bigText(
            context: context,
            text: text,
            color: textColor,
            size: 20.0,
          ), */
        ),
      ),
    );

Widget defaultTextField(
        {required BuildContext context,
        required String text,
        required TextEditingController controller,
        keyboardType = TextInputType.text,
        isPassword = false,
        required void Function(String)? onSubmitted,
        required IconData prefixIcon,
        IconData? suffixIcon,
        void Function()? onSuffixPressed,
        String? validateText,
        void Function()? onTap,
        bool enabled = true}) =>
    TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      onFieldSubmitted: onSubmitted,
      validator: (value) {
        if (value!.isEmpty) {
          return validateText;
        }
        return null;
      },
      onTap: onTap,
      decoration: InputDecoration(
          hintText: text,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null
              ? (IconButton(onPressed: onSuffixPressed, icon: Icon(suffixIcon)))
              : null),
    );

Widget clickableText(Function()? onPressed, text) =>
    TextButton(onPressed: onPressed, child: Text(text));

Widget bigText({
  required BuildContext context,
  color = AppColors.mainColor,
  required text,
  double size = 20,
  overflow = TextOverflow.ellipsis,
  lines = 1,
}) =>
    Text(text,
        textAlign: TextAlign.center,
        maxLines: lines,
        overflow: overflow,
        //style: Theme.of(context).textTheme.bodyText1,
        style: TextStyle(
            fontFamily: 'Robot', fontSize: size, color: color, fontWeight: FontWeight.bold));

void showDoneModal(
    {required BuildContext context,
    required String text,
    String? pagePath,
    required IconData iconData}) async {
  Navigator.pop(context);
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(20), topStart: Radius.circular(20))),
      context: context,
      builder: (context) => FractionallySizedBox(
            heightFactor: .7,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    iconData,
                    size: 50,
                    color: AppColors.mainColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: bigText(
                          context: context, color: AppColors.mainBlackColor, text: text, lines: 2)),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultBtn(
                      context: context,
                      text: getAppStrings(context).done,
                      backgroungColor: AppColors.mainColor,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        navigateAndReplace(context, pagePath!);
                      })
                ],
              ),
            ),
          ));
}
