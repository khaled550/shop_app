import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/data/model/product_model.dart';
import 'package:shop_app/ui/widgets.dart';

import '../../cubit/home_cubit/home_page_cubit.dart';
import '../../cubit/home_cubit/home_page_state.dart';
import '../../data/model/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = Product(
      image:
          'https://student.valuxapps.com/storage/uploads/products/1615450256e0bZk.item_XXL_7582156_7501823.jpeg',
      name: 'Product name',
      price: '\$100',
      description: 'Product description',
    );
    List<CartItem> cartItems = [];
    double subtotalCart = 0;
    return Scaffold(
      appBar: myAppBar(tite: 'My Cart'),
      //body: _buildCartPage(context, product),
      body: BlocBuilder<HomePageCubit, HomeLayoutState>(builder: (ctx, state) {
        if (state is UpdateCartDataLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        cartItems = (state is UpdateCartDataSucState) ? state.cartItems : cartItems;
        subtotalCart = (state is UpdateCartDataSucState) ? state.subtotalCart : subtotalCart;
        return cartItems.isNotEmpty
            ? Center(
                child: _buildCartPage(
                  context,
                  cartItems,
                  subtotalCart,
                ),
              )
            : Center(
                child: bigText(
                context: context,
                text: getAppStrings(context).no_cart_items,
                size: 18,
              ));
      }),
    );
  }

  Widget _buildCartPage(BuildContext context, List<CartItem> cartItems, double subtotal) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildCartProductList(context, cartItems),
            const SizedBox(height: 8),
            _buildCartSectionTotal(context, subtotal),
          ],
        ),
      );

  Widget _buildCartProductList(BuildContext context, List<CartItem> cartItems) => Expanded(
        child: ListView.separated(
          itemBuilder: (ctx, index) => SizedBox(
            height: 150,
            child: ListTile(
              visualDensity: const VisualDensity(vertical: 4),
              leading: SizedBox(
                width: 90,
                height: 100,
                child: _buildProductImage(cartItems[index].product!.image!),
              ),
              title: _buildProductName(cartItems[index].product!.name!),
              subtitle: Padding(
                padding: const EdgeInsetsDirectional.only(top: 16.0),
                child: _buildProductPrice(
                  context,
                  cartItems[index].product!.price!.toString(),
                  cartItems[index].product!.oldPrice!.toString(),
                  cartItems[index].product!.id!,
                  cartItems[index].id!,
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(
            color: AppColors.mainBlackColor,
          ),
          itemCount: cartItems.length,
        ),
      );

  Widget _buildDeleteItemIcon(BuildContext context, int productId) => IconButton(
        onPressed: () {
          HomePageCubit.get(context).updateItemInCart(
            context: context,
            productId: productId,
          );
        },
        icon: const Icon(
          Icons.delete,
          size: 16,
        ),
      );

  /* Widget _buildCartItem(BuildContext context, Product product) => Row(
        children: [
          _buildProductImage(product.image!),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductName(product.name!),
              _buildProductPrice(context, product.price!, product.id!,),
              //_buildItemCounter(),
            ],
          ),
        ],
      ); */

  Widget _buildProductImage(String imgUrl) => CachedNetworkImage(
        imageUrl: imgUrl,
        imageBuilder: (context, imageProvider) => DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: SizedBox(
            height: 100,
            child: OctoImage(
              fit: BoxFit.contain,
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
      );

  Widget _buildProductName(String productName) => smallText(
        text: productName,
        color: AppColors.mainGreyColor,
        size: 14,
      );

  Widget _buildProductPrice(
    BuildContext context,
    String productPrice,
    String productOldPrice,
    int productId,
    int productCartId,
  ) =>
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              smallText(
                text: "${productPrice.toString()} ${getAppStrings(context).price_cur}",
                color: AppColors.mainBlackColor,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(width: 12),
              smallText(
                text: "${productOldPrice.toString()} ${getAppStrings(context).price_cur}",
                lines: 1,
                size: 10,
                color: AppColors.mainGreyColor,
                fontWeight: FontWeight.bold,
                textDecoration: TextDecoration.lineThrough,
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildItemCounter(
                context,
                productCartId,
                double.tryParse(productPrice)!,
              ),
              _buildDeleteItemIcon(
                context,
                productId,
              ),
            ],
          )
        ],
      );

  Widget _buildItemCounter(BuildContext context, int productCartId, double productPrice) => Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove,
              size: 14,
            ),
            onPressed: () {
              HomePageCubit.get(context).updateQtyInCart(
                context: context,
                productCartId: productCartId,
                productPrice: productPrice,
                isIncrement: false,
              );
            },
          ),
          BlocBuilder<HomePageCubit, HomeLayoutState>(
            builder: (ctx, state) {
              return smallText(
                text: HomePageCubit.get(
                  context,
                ).itemsQtyMap[productCartId].toString(),
                color: AppColors.mainBlackColor,
                size: 14,
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 14,
            ),
            onPressed: () {
              HomePageCubit.get(context).updateQtyInCart(
                context: context,
                productCartId: productCartId,
                productPrice: productPrice,
                isIncrement: true,
              );
            },
          ),
        ],
      );

  Widget _buildCartSectionTotalItem(
    BuildContext context,
    String text,
    double textSize,
    double price,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          smallText(
            text: text,
            color: AppColors.mainBlackColor,
            size: textSize,
          ),
          BlocBuilder<HomePageCubit, HomeLayoutState>(
            builder: (ctx, state) {
              return smallText(
                text: '$price ${getAppStrings(context).price_cur}',
                color: AppColors.mainGreyColor,
              );
            },
          ),
        ],
      );

  Widget _buildCartSectionTotal(BuildContext context, double subtotal) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            //subtotal
            _buildCartSectionTotalItem(
              context,
              getAppStrings(context).subtotal,
              12,
              HomePageCubit.get(context).subtotalCart,
            ),
            const SizedBox(height: 8),
            //shipping
            _buildCartSectionTotalItem(
              context,
              getAppStrings(context).shipping,
              12,
              50,
            ),
            const SizedBox(height: 12),
            //total
            _buildCartSectionTotalItem(
              context,
              getAppStrings(context).total,
              14,
              HomePageCubit.get(context).subtotalCart + 50,
            ),
            const SizedBox(height: 12),
            defaultBtn(
              context: context,
              text: getAppStrings(context).checkout,
              onPressed: () {},
            ),
          ],
        ),
      );
}
