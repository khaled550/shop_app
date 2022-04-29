import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_cubit/home_page_cubit.dart';
import '../../cubit/home_cubit/home_page_state.dart';
import '../../utils/components.dart';

class OrdersPage extends StatelessWidget {
  HomePageCubit? cubit;
  OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit = HomePageCubit.get(context);
    return BlocBuilder<HomePageCubit, HomeLayoutState>(
      builder: (context, state) {
        return _buildOrdersPage();
      },
    );
  }

  _buildOrdersPage() {
    return Center(
      child: NestedScrollView(
          headerSliverBuilder: (context, val) {
            return [
              mySliverAppBar(getAppStrings(context).gn_orders),
            ];
          },
          body: SizedBox(
            height: 350.0,
            width: 333.0,
            child: ListView.separated(
                itemBuilder: (context, index) =>
                    buildOrderItem(context, cubit!.productModel!.products![index]),
                separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                    ),
                itemCount: 5),
          )),
    );
  }
}
