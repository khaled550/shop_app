import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_cubit/home_page_cubit.dart';
import '../../cubit/home_cubit/home_page_state.dart';
import '../../utils/components.dart';

class CategoriesPage extends StatelessWidget {
  HomePageCubit? cubit;
  CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit = HomePageCubit.get(context);
    return BlocBuilder<HomePageCubit, HomeLayoutState>(
      builder: (context, state) {
        return buildCategoriesPage();
      },
    );
  }

  Widget buildCategoriesPage() => Container();
}
