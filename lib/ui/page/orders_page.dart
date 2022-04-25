import 'package:flutter/material.dart';

import '../../utils/components.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(getAppStrings(context).gn_orders),
    );
  }
}
