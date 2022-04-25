import 'package:flutter/material.dart';
import 'package:shop_app/utils/components.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(getAppStrings(context).gn_profile),
    );
  }
}
