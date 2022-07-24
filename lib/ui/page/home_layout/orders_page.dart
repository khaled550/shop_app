import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/home_cubit/home_page_cubit.dart';
import '../../../cubit/home_cubit/home_page_state.dart';
import '../../../data/model/order_model.dart';
import '../../widgets.dart';

class OrdersPage extends StatelessWidget {
  List<Order> ordersList = [];
  OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomeLayoutState>(
      builder: (context, state) {
        if (state is LoadingOrdersState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadingOrdersSucState) {
          print('${state.ordersList.length} state.ordersList');
        }
        ordersList = (state is LoadingOrdersSucState) ? state.ordersList : ordersList;
        //print('${ordersList.length} state.ordersList');
        return ordersList.isNotEmpty
            ? _buildOrdersPage()
            : Center(
                child: bigText(
                context: context,
                text: getAppStrings(context).no_cart_items,
                size: 18,
              ));
      },
    );
  }

  _buildOrdersPage() {
    return SizedBox(
      child: ListView.separated(
          itemBuilder: (context, index) => buildOrderItem(context, ordersList[index]),
          separatorBuilder: (context, index) => const Divider(
                thickness: 1,
              ),
          itemCount: ordersList.length),
    );
  }
}
