import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_app/cubit/home_cubit/home_page_cubit.dart';
import 'package:shop_app/data/model/home_model.dart';
import 'package:shop_app/utils/dimentions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../cubit/home_cubit/home_page_state.dart';
import '../../data/model/category_model.dart';
import '../../utils/colors.dart';
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
        if (state is HomePageLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (cubit!.isLoaded) {
          return buildHomeBody(context, cubit!.homeModel!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
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
                  viewAllWidget(context, getAppStrings(context).gn_cat),
                  buildCatsListView(cubit!.categoryModel!.cats!),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(height: 210, child: buildBannerPageView(homeModel.data!.banners!)),
                  SmoothPageIndicator(
                    controller: cubit!.pageController,
                    count: homeModel.data!.banners!.length,
                    effect: const WormEffect(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  viewAllWidget(context, getAppStrings(context).hot_deals),
                  buildDealOfTheDay(context),
                  viewAllWidget(context, getAppStrings(context).best_selling),
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

  Widget buildCatsListView(List<Category> cats) => SizedBox(
        height: 150,
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

  Widget buildDealOfTheDay(BuildContext context) => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // width / height: fixed for *all* items
          childAspectRatio: 1.2,
        ),
        // return a custom ItemCard
        itemBuilder: (_, index) => buildCatsItem(cubit!.categoryModel!.cats![index]),
        itemCount: cubit!.categoryModel!.cats!.length,
      );

  Widget buildBestSelling(BuildContext context) => SizedBox(
        height: 280,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) => SizedBox(
                height: 250,
                width: 150,
                child: buildProductItem(context, cubit!.productModel!.products![index]))),
            separatorBuilder: ((context, index) => const SizedBox(
                  width: 10,
                )),
            itemCount: cubit!.productModel!.products!.length),
      );
}
