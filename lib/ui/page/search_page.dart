import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../cubit/home_cubit/home_page_cubit.dart';
import '../../cubit/home_cubit/home_page_state.dart';
import '../../data/model/product_model.dart';
import '../widgets.dart';

class SearchProductPage extends StatelessWidget {
  HomePageCubit? cubit;
  TextEditingController? searchTextController;
  SearchProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit = HomePageCubit.get(context);
    searchTextController = TextEditingController();
    return _buildSearchPageBody(context);
  }

  Widget _buildSearchPageBody(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: searchInputField(context),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<HomePageCubit, HomeLayoutState>(
                    builder: (context, state) {
                      if (state is UpdateSearchedListState) {
                        return _buildProductItems(state.searchedProducts);
                      } else {
                        return const SizedBox();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget searchInputField(BuildContext context) {
    return defaultTextField(
        autofocus: true,
        context: context,
        keyboardType: TextInputType.text,
        text: getAppStrings(context).search_text_field,
        controller: searchTextController!,
        onSubmitted: (value) {},
        onChanged: (productName) {
          cubit!.updateSearchList(productName);
        },
        prefixIcon: LineIcons.search);
  }

  _buildProductItems(List<Product> searchedProducts) => SizedBox(
        height: double.maxFinite,
        child: myGrid(
          products: searchedProducts,
          favProducts: cubit!.isFavouriteMap,
        ),
      );
}
