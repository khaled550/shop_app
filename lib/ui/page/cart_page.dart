import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_cubit/home_page_cubit.dart';
import 'package:shop_app/cubit/home_cubit/home_page_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //body: _buildCartPage(context),
      body: BlocBuilder<HomePageCubit, HomeLayoutState>(
        builder: (context, state) {
          if (state is UpdateCartDataSucState) {
            print(state.cartItems.length);
            return Center(
              child: Text(state.cartItems[0].product!.name!),
            );
          } else if (state is UpdateCartDataLoadingState) {
            return const Center(child: LinearProgressIndicator());
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildCartPage(BuildContext context) => Column(
        children: [
          _buildCartItem(context),
        ],
      );

  _buildCartItem(BuildContext context) => Row(
        children: const [
          /* CachedNetworkImage(
            imageUrl: product.image!,
            imageBuilder: (context, imageProvider) => DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
          ), */
        ],
      );
}
