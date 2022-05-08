import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:octo_image/octo_image.dart';
import '../cubit/home_cubit/home_page_cubit.dart';
import '../data/model/category_model.dart';
import '../data/model/product_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../constants/strings.dart';
import '../constants/colors.dart';

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
navigateTo({required BuildContext context, required String pagePath, Object? arguments}) {
  Navigator.pushNamed(context, pagePath, arguments: arguments);
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
  //textColor = AppColors.mainBlackColor,
  required String text,
  required void Function()? onPressed,
}) =>
    SizedBox(
      height: hieght,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: isDark
                ? MaterialStateProperty.all<Color>(
                    Colors.white,
                  )
                : MaterialStateProperty.all<Color>(
                    AppColors.mainColor,
                  ),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
          ),
          child: Text(
            text,
            style: isDark
                ? const TextStyle(color: AppColors.mainBlackColor)
                : const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

Widget defaultTextField({
  required BuildContext context,
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
  bool enabled = true,
  void Function(String)? onChanged,
  FocusNode? focusNode,
  bool autofocus = false,
}) =>
    TextFormField(
      autofocus: autofocus,
      focusNode: focusNode,
      onChanged: onChanged,
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
      style: isDark ? const TextStyle(color: Colors.white) : const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(12),
          hintText: text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), gapPadding: 1),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null
              ? (IconButton(onPressed: onSuffixPressed, icon: Icon(suffixIcon)))
              : null),
    );

Widget clickableText(Function()? onPressed, text) =>
    TextButton(onPressed: onPressed, child: Text(text));

Widget bigText(
        {required BuildContext context,
        required text,
        double size = 24,
        overflow = TextOverflow.ellipsis,
        lines = 1,
        TextAlign textAlign = TextAlign.center,
        Color? color}) =>
    Text(text,
        textAlign: textAlign,
        maxLines: lines,
        overflow: overflow,
        //style: Theme.of(context).textTheme.bodyText1,
        style: TextStyle(
            fontFamily: 'Robot',
            fontSize: size,
            color: color ?? Theme.of(context).textTheme.headline1!.color!,
            fontWeight: FontWeight.bold));

Widget smallText(
        {color = AppColors.mainGreyColor,
        required text,
        double size = 16,
        double height = 1.2,
        textOverflow = TextOverflow.visible,
        FontWeight fontWeight = FontWeight.normal,
        TextAlign textAlign = TextAlign.start,
        int? lines,
        TextDecoration textDecoration = TextDecoration.none}) =>
    Text(text,
        overflow: textOverflow,
        maxLines: (lines != null) ? lines : null,
        textAlign: textAlign,
        style: TextStyle(
            decoration: textDecoration,
            fontFamily: 'Robot',
            fontSize: size,
            color: color,
            fontWeight: fontWeight,
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
                  Expanded(child: bigText(context: context, text: text, lines: 2, size: 16)),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultBtn(
                      context: context,
                      text: getAppStrings(context).done,
                      //textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        if (pagePath != null) {
                          navigateAndReplace(context, pagePath);
                        }
                      })
                ],
              ),
            ),
          ));
}

AppBar myAppBar({
  required String tite,
  required void Function()? onSearchPressed,
  required void Function()? onCartPressed,
}) =>
    AppBar(
      centerTitle: false,
      //leading: IconButton(onPressed: (() {}), icon: const Icon(Icons.menu)),
      title: Text(tite),
      actions: [
        IconButton(
          onPressed: onSearchPressed,
          icon: const Icon(LineIcons.search),
        ),
        IconButton(
          onPressed: onCartPressed,
          icon: const Icon(LineIcons.shoppingBag),
        ),
      ],
    );

myGrid({required List<Product> products, required Map<int, bool> favProducts, int count = 0}) =>
    StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: count == 0 ? products.length : count,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => buildProductItem(context, products[index], favProducts),
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1));

Widget customIcon(BuildContext context, IconData icon) => Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.mainColor,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );

buildBottomSheet(
    {required BuildContext context,
    required String title,
    TextEditingController? nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    bool isLogin = false,
    required String btnText,
    TextEditingController? confirmPasswordController,
    TextEditingController? phoneController,
    required dynamic cubit,
    required void Function()? onPressedBtn}) {
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
                            //color: AppColors.mainBlackColor,
                            size: 16,
                            text: title),
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
                    defaultTextField(
                        context: context,
                        text: getAppStrings(context).enter_email,
                        controller: emailController,
                        validateText: 'Email must not be empty',
                        onSubmitted: (value) {},
                        prefixIcon: Icons.email_outlined),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                        context: context,
                        text: getAppStrings(context).enter_password,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        isPassword: true,
                        onSubmitted: (value) {
                          onPressedBtn;
                        },
                        validateText: 'Date must not be empty',
                        onTap: () {},
                        prefixIcon: Icons.lock_outline),
                    isLogin
                        ? clickableText(() {}, getAppStrings(context).forgot_password)
                        : Column(
                            children: [
                              if (confirmPasswordController != null)
                                defaultTextField(
                                    context: context,
                                    text: getAppStrings(context).confirm_password,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: confirmPasswordController,
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
                                  controller: nameController ?? TextEditingController(),
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
                                  controller: phoneController ?? TextEditingController(),
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
                    defaultBtn(
                        context: context,
                        text: btnText,
                        //backgroungColor: AppColors.mainColor,
                        //textColor: Colors.white,
                        onPressed: onPressedBtn)
                  ],
                ),
              ),
            ),
          ));
}

showLoadingModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(20), topStart: Radius.circular(20))),
      builder: (context) {
        //Navigator.pop(context);
        return const FractionallySizedBox(
          heightFactor: .7,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
}

//Home page components

Widget buildCatsItem(Category category) => SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CachedNetworkImage(
            imageUrl: category.image!,
            imageBuilder: (context, imageProvider) => Container(
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white24,
                  image: DecorationImage(fit: BoxFit.cover, image: imageProvider)),
            ),
            placeholder: (context, url) => Transform.scale(
              scale: 0.2,
              child: const CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                color: Colors.black.withOpacity(0.4),
              ),
              child: smallText(
                  text: category.name!, color: Colors.white, lines: 1, textAlign: TextAlign.center))
        ],
      ),
    );
/* Widget viewAllWidget(BuildContext context, String title) => Row(
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
    ); */

Widget buildProductItem(BuildContext context, Product product, Map<int, bool> favs) =>
    GestureDetector(
      onTap: () {
        navigateTo(context: context, pagePath: '/product_details', arguments: product);
      },
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDark ? AppColors.mainBlackColor : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  CachedNetworkImage(
                    imageUrl: product.image!,
                    imageBuilder: (context, imageProvider) => DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      ),
                      child: SizedBox(
                        height: 180,
                        child: OctoImage(
                          fit: BoxFit.cover,
                          image: imageProvider,
                          progressIndicatorBuilder: (context, progress) {
                            double value = 0;
                            if (progress != null && progress.expectedTotalBytes != null) {
                              value = progress.cumulativeBytesLoaded / progress.expectedTotalBytes!;
                            }
                            return CircularProgressIndicator(value: value);
                          },
                          errorBuilder: (context, error, stack) => Icon(
                            Icons.error,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (product.discount != 0)
                    Container(
                      padding: const EdgeInsets.all(3),
                      color: Colors.red,
                      child: bigText(
                          context: context,
                          text: getAppStrings(context).discount,
                          size: 12,
                          color: Colors.white),
                    ),
                  Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          print(product.id);
                          BlocProvider.of<HomePageCubit>(context)
                              .updateFav(context: context, id: product.id!);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration:
                              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            favs[product.id!] ?? false ? Icons.favorite : Icons.favorite_border,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: smallText(
                  text: product.name!,
                  color: isDark ? Colors.white : AppColors.mainBlackColor,
                  lines: 1,
                  textOverflow: TextOverflow.clip),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  smallText(
                      text: "${product.price!.toString()} ${getAppStrings(context).price_cur}",
                      color: isDark ? Colors.white : AppColors.mainBlackColor,
                      lines: 1,
                      fontWeight: FontWeight.bold),
                ],
              ),
            ),
            if (product.discount != 0)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: smallText(
                    text: '${product.oldPrice!}',
                    lines: 1,
                    size: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    textDecoration: TextDecoration.lineThrough),
              )
          ],
        ),
      ),
    );

buildOrderItem(BuildContext context, Product product) => LimitedBox(
      maxHeight: 150,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Positioned(
              top: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bigText(context: context, text: 'Order status', size: 16),
                  const SizedBox(
                    height: 5,
                  ),
                  smallText(text: '5 May 2022'),
                  const SizedBox(
                    height: 5,
                  ),
                  smallText(
                      text: 'total price', color: isDark ? Colors.white : AppColors.mainBlackColor),
                  const SizedBox(
                    height: 5,
                  ),
                  smallText(
                      text: '\$65',
                      color: isDark ? Colors.white : AppColors.mainBlackColor,
                      fontWeight: FontWeight.bold),
                ],
              ),
            ),
            Positioned(
                right: 5,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 25,
                    ))),
          ],
        ),
      ),
    );
