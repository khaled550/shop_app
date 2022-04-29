import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_app/cubit/home_cubit/home_page_cubit.dart';
import 'package:shop_app/data/model/home_model.dart';
import 'package:shop_app/data/model/product_model.dart';

import '../../cubit/home_cubit/home_page_state.dart';
import '../../data/model/category_model.dart';
import '../../utils/components.dart';

class HomePage extends StatelessWidget {
  HomePageCubit? cubit;
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //HomeModel homeModel = HomeModel();
    cubit = HomePageCubit.get(context);
    return BlocConsumer<HomePageCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return buildHomeBody(context, cubit!.homeModel!);
      },
    );
  }

  Widget buildHomeBody(BuildContext context, HomeModel homeModel) {
    return Center(
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
              [mySliverAppBar(getAppStrings(context).app_title)],
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultTextField(
                      context: context,
                      keyboardType: TextInputType.text,
                      text: getAppStrings(context).search_text_field,
                      controller: TextEditingController(),
                      onSubmitted: (value) {},
                      prefixIcon: LineIcons.search),
                  const SizedBox(
                    height: 10,
                  ),
                  bigText(
                    context: context,
                    text: getAppStrings(context).gn_cat,
                    //color: AppColors.mainBlackColor
                  ),
                  buildCatsListView(cubit!.categoryModel!.cats!),
                  const SizedBox(
                    height: 30,
                  ),
                  buildSliderView(homeModel),
                  /* SmoothPageIndicator(
                    controller: cubit!.pageController,
                    count: homeModel.data!.banners!.length,
                    effect: const WormEffect(),
                  ), */
                  const SizedBox(
                    height: 30,
                  ),
                  //viewAllWidget(context, getAppStrings(context).hot_deals),
                  bigText(
                    context: context,
                    text: getAppStrings(context).hot_deals,
                    //color: AppColors.mainBlackColor
                  ),
                  buildDealOfTheDay(context),
                  const SizedBox(
                    height: 30,
                  ),
                  bigText(
                    context: context,
                    text: getAppStrings(context).best_selling,
                    //color: AppColors.mainBlackColor
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildBestSelling(context)
                ],
              ),
            ),
          )),
    );
  }

  CarouselSlider buildSliderView(HomeModel homeModel) {
    return CarouselSlider(
        items: homeModel.data!.banners!
            .map((e) => CachedNetworkImage(
                  imageUrl: e.image!,
                  imageBuilder: (context, imageProvider) => Container(
                    margin: const EdgeInsets.all(5),
                    //height: 50,
                    //width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white24,
                        image: DecorationImage(fit: BoxFit.cover, image: imageProvider)),
                  ),
                  placeholder: (context, url) => Transform.scale(
                    scale: 0.2,
                    child: Transform.scale(
                      scale: 0.2,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          initialPage: 0,
          reverse: false,
          enableInfiniteScroll: true,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
        ));
  }

  Widget buildCatsListView(List<Category> cats) => SizedBox(
        height: 100,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) => buildCatsItem(cats[index])),
            separatorBuilder: ((context, index) => const SizedBox(
                  width: 15,
                )),
            itemCount: cats.length),
      );

  Widget buildBannerPageView(List<Banners> bannerModel) => PageView.builder(
      controller: cubit!.pageController,
      onPageChanged: (index) {
        cubit!.updateBannerDots(index.toInt());
      },
      itemCount: bannerModel.length,
      itemBuilder: (context, position) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white24,
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(bannerModel[position].image!))),
          ),
        );
      });

  Widget buildDealOfTheDay(BuildContext context) {
    List<Product> discountedProducts = [];
    for (var element in cubit!.productModel!.products!) {
      if (element.discount != 0) {
        discountedProducts.add(element);
      }
    }
    return SizedBox(
      height: 600,
      child: myGrid(products: discountedProducts, count: 4, favProducts: cubit!.favProducts!),
    );
  }

  Widget buildBestSelling(BuildContext context) => SizedBox(
        height: 300,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) => SizedBox(
                width: 150,
                child: buildProductItem(
                    context, cubit!.productModel!.products![index], cubit!.favProducts!))),
            separatorBuilder: ((context, index) => const SizedBox(
                  width: 10,
                )),
            itemCount: cubit!.productModel!.products!.length),
      );
}
