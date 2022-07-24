import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shop_app/cubit/home_cubit/home_page_state.dart';
import '../../constants/colors.dart';
import '../../cubit/home_cubit/home_page_cubit.dart';
import '../../data/model/product_model.dart';
import '../widgets.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  HomePageCubit? cubit;

  ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit = HomePageCubit.get(context);
    return _buildProductPage2(context);
  }

  Widget _buildProductPage2(BuildContext context) => Scaffold(
        //backgroundColor: AppColors.mainBlackColor,
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context),
            _buildSliverList(context),
          ],
        ),
      );

  Widget _buildSliverAppBar(BuildContext context) => SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        title: bigText(
          context: context,
          text: product.name!,
          size: 12,
          lines: 3,
          textAlign: TextAlign.start,
        ),
        background: appBarBackground(),
      ));

  Widget appBarBackground() => CachedNetworkImage(
        imageUrl: product.image!,
        imageBuilder: (context, imageProvider) => OctoImage(
          fit: BoxFit.cover,
          image: imageProvider,
          progressIndicatorBuilder: (context, progress) {
            double value = 0;
            if (progress != null && progress.expectedTotalBytes != null) {
              value = progress.cumulativeBytesLoaded / progress.expectedTotalBytes!;
            }
            return CircularProgressIndicator(value: value);
          },
          errorBuilder: (context, error, stack) => const Icon(
            Icons.error,
            //color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      );

  Widget _buildSliverList(BuildContext context) => SliverList(
        delegate: SliverChildListDelegate([
          Container(
            //height: MediaQuery.of(context).size.height - 90,
            //width: double.maxFinite,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.mainBlackColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAddToCartContainer(context),
                const SizedBox(
                  height: 10,
                ),
                smallText(
                  text: getAppStrings(context).description,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildDescriptionText(),
              ],
            ),
          )
        ]),
      );

  Widget _buildAddToCartContainer(BuildContext context) => Container(
        height: 60,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: AppColors.mainColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              const SizedBox(
                width: 5,
              ),
              smallText(
                  text: "${product.price!.toString()} ${getAppStrings(context).price_cur}",
                  lines: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              const SizedBox(
                width: 5,
              ),
              if (product.discount != 0)
                Positioned(
                  bottom: 0,
                  child: smallText(
                      text: '${product.oldPrice!}',
                      lines: 1,
                      size: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      textDecoration: TextDecoration.lineThrough),
                ),
              Positioned(
                right: 0,
                child: BlocBuilder<HomePageCubit, HomeLayoutState>(
                  builder: (context, state) {
                    if (state is AddToCartDataSucState) {
                      return checkInCart(context);
                    } else if (state is UpdateCartDataLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return checkInCart(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildDescriptionText() => SingleChildScrollView(
          child: smallText(
        text: product.description!,
        size: 14,
        color: Colors.white,
      ));

  Widget checkInCart(BuildContext context) {
    bool inCart = cubit!.inCartMap[product.id!] ?? false;
    if (!inCart) {
      return _buildAddCartBtn(
        context,
        getAppStrings(context).add_to_cart,
      );
    } else {
      return _buildAddCartBtn(
        context,
        'Remove',
      );
    }
  }

  Widget _buildAddCartBtn(BuildContext context, String text) => ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor: MaterialStateProperty.all<Color>(
              AppColors.mainBlackColor,
            )),
        onPressed: () {
          cubit!.updateItemInCart(
            context: context,
            productId: product.id!,
          );
        },
        child: bigText(
          text: text,
          context: context,
          size: 12,
          color: Colors.white,
        ),
      );

  //************************************************/

  /* Widget _buildProductPage(BuildContext context) {
    //final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    //product = arguments['product'];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ColoredBox(
          color: AppColors.mainGreyColor,
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(product.image!))),
                  )),
              Positioned(
                left: 20,
                right: 20,
                top: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        iconSize: 30,
                        color: AppColors.mainBlackColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          //size: 60,
                        )),
                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 265,
                  bottom: 0,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                  color: AppColors.mainBlackColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bigText(
                                      text: product.name,
                                      context: context,
                                      size: 16,
                                      lines: 2,
                                      color: Colors.white,
                                      textAlign: TextAlign.start),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 100,
                                    width: double.maxFinite,
                                    //padding: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        color: AppColors.mainColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          smallText(
                                              text:
                                                  "${product.price!.toString()} ${getAppStrings(context).price_cur}",
                                              lines: 1,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          if (product.discount != 0)
                                            smallText(
                                                text: '${product.oldPrice!}',
                                                lines: 1,
                                                size: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                textDecoration: TextDecoration.lineThrough),
                                          Positioned(
                                            right: 0,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation: MaterialStateProperty.all<double>(0),
                                                  backgroundColor: MaterialStateProperty.all<Color>(
                                                    AppColors.mainBlackColor,
                                                  )),
                                              onPressed: () {
                                                cubit!.updateItemInCart(
                                                    context: context, productId: 1);
                                              },
                                              child: bigText(
                                                  text: getAppStrings(context).add_to_cart,
                                                  context: context,
                                                  size: 12,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  smallText(
                                      text: getAppStrings(context).description,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SingleChildScrollView(
                                    child: smallText(
                                      text: product.description!,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  } */
}
