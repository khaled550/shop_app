import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/utils/dimentions.dart';

import '../../cubit/home_cubit/home_page_cubit.dart';
import '../../cubit/home_cubit/home_page_state.dart';
import '../../data/model/category_model.dart';
import '../../utils/colors.dart';
import '../../utils/components.dart';

class CategoriesPage extends StatelessWidget {
  HomePageCubit? cubit;
  CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit = HomePageCubit.get(context);
    return BlocBuilder<HomePageCubit, HomeLayoutState>(
      builder: (context, state) {
        return _buildCategoriesPage(context);
      },
    );
  }

  _buildCategoriesPage(BuildContext context) => Center(
        child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
                [mySliverAppBar(getAppStrings(context).gn_cat)],
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildNavRail(),
                  flex: 1,
                ),
                Expanded(
                  child: _buildProductItems(context),
                  flex: 4,
                )
              ],
            )),
      );

  _buildNavRail() => LayoutBuilder(builder: (context, boxConstraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: boxConstraints.maxHeight),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: IntrinsicHeight(
              child: NavigationRail(
                selectedIndex: 0,
                onDestinationSelected: (int index) {},
                labelType: NavigationRailLabelType.all,
                destinations: _buildNavRailItem(cats: cubit!.categoryModel!.cats!),
              ),
            ),
          ),
        );
      });

  List<NavigationRailDestination> _buildNavRailItem({required List<Category> cats}) {
    List<NavigationRailDestination> list = [];
    for (var element in cats) {
      list.add(NavigationRailDestination(
          icon: buildCatsItem(element), label: const Text(''), padding: EdgeInsets.zero));
    }
    return list;
  }

  _buildProductItems(BuildContext context) => SizedBox(
      height: double.maxFinite,
      child: myGrid(products: cubit!.productModel!.products!, favProducts: cubit!.favProducts!));
  /*buildGridView(
          itemBuilder: ((context, index) {
            return buildProductItem(
              context, cubit!.homeModel!.data!.products![index]);
          }),
          itemCount: cubit!.homeModel!.data!.products!.length));*/
}
