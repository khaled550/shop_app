import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_app/data/model/category_model.dart';
import 'package:shop_app/data/model/product_model.dart';
import 'package:shop_app/ui/page/home_layout.dart';
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

// App utills
navigateTo(BuildContext context, String pagePath) {
  Navigator.pushNamed(context, pagePath);
}

navigateAndReplace(BuildContext context, String pagePath) {
  Navigator.pushReplacementNamed(context, pagePath);
}

getAppStrings(BuildContext context) {
  return AppLocalizations.of(context);
}

// App shared components
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
  double size = 24,
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

Widget smallText(
        {color = AppColors.mainGreyColor,
        required text,
        double size = 16,
        double height = 1.2,
        textOverflow = TextOverflow.visible,
        int lines = 1}) =>
    Text(text,
        overflow: textOverflow,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Robot',
            fontSize: size,
            color: color,
            fontWeight: FontWeight.w400,
            height: height));

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

SliverAppBar mySliverAppBar(String tite) => SliverAppBar(
      floating: true,
      pinned: true,
      snap: false,
      centerTitle: false,
      leading: IconButton(onPressed: (() {}), icon: const Icon(Icons.menu)),
      title: Text(tite),
      actions: [
        IconButton(
            onPressed: (() {}),
            icon: const Icon(
              LineIcons.bell,
              color: AppColors.mainColor,
            )),
        IconButton(
            onPressed: (() {}),
            icon: const Icon(LineIcons.shoppingBag, color: AppColors.mainColor)),
      ],
    );

//Home page components

Widget buildCatsItem(Category category) => Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white24,
              image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(category.image!))),
        ),
        const SizedBox(
          height: 20,
        ),
        smallText(text: category.name!, color: AppColors.mainBlackColor)
      ],
    );
Widget viewAllWidget(BuildContext context, String title) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        bigText(context: context, text: title, color: AppColors.mainBlackColor),
        Row(
          children: [
            smallText(text: getAppStrings(context).view_all),
            const Icon(
              LineIcons.arrowLeft,
              size: 16,
              color: AppColors.mainGreyColor,
            )
          ],
        )
      ],
    );

Widget buildBestSellingContent(Product product) => Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 120,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white24,
                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(product.image!))),
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white.withOpacity(.4),
              child: IconButton(
                icon: const Icon(
                  LineIcons.heart,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: 140,
            height: 10,
            child: smallText(text: product.name!, color: AppColors.mainBlackColor, lines: 1)),
      ],
    );
