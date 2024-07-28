// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/cart/bloc/cart_bloc.dart';
import 'package:quadrant_app/blocs/product/bloc/product_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/repositories/CartRepository/cart_repository.dart';
import 'package:quadrant_app/repositories/ProductRepository/product_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/enums/cart_type.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class ProductScreen extends StatelessWidget {
  final String productId;
  final CartType cartType;
  const ProductScreen({super.key, required this.productId, this.cartType = CartType.ONLINE});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (_) => ProductBloc(
            productRepository: ProductRepository(DioManager.instance))
          ..add(FetchProduct(productId)),
        child:
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          switch (state) {
            case ProductLoading():
              return Scaffold(
                  body: Center(
                      child: LoadingAnimationWidget.waveDots(
                          color: isDark
                              ? CustomColors.primaryLight
                              : CustomColors.textColorLight,
                          size: 24)));
            case ProductLoaded():
              return Scaffold(
                body: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 330,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(state.product.images![0].url!),
                            fit: BoxFit.cover,
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: displayHeight / 14),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleActionButton(
                                  isDark: isDark,
                                  icon: Iconsax.arrow_left,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Row(
                                  children: [
                                    CircleActionButton(
                                      isDark: isDark,
                                      icon: Iconsax.export,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(width: 14),
                                    CircleActionButton(
                                      isDark: isDark,
                                      icon: Iconsax.heart,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ScrollingSectionText(
                                      isDark: isDark,
                                      text: state.product.name!,
                                      size: 20.0,
                                      bold: true),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Iconsax.star1, color: Colors.amber),
                                    NormalText(isDark: isDark, text: "2.4"),
                                  ],
                                ),
                              ],
                            ),
                            SectionHelperText(
                                isDark: isDark,
                                text: 'Description',
                                bold: true),
                            DescriptionText(text: state.product.desc!),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                bottomNavigationBar: Container(
                  height: displayHeight / 10,
                  decoration: BoxDecoration(
                    color: isDark
                      ? CustomColors.navBarBackgroundDark
                      : CustomColors.navBarBackgroundLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionText(
                            isDark: isDark,
                            text:
                                "RM ${state.product.price?.toStringAsFixed(2)}",
                            size: 20.0,
                            bold: true),
                        BlocProvider(
                          create: (_) => CartBloc(
                              cartRepository:
                                  CartRepository(DioManager.instance))
                            ..add(FetchProductIsInCart(productId, cartType)),
                          child: BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              switch (state) {
                                case CartLoading():
                                  return Center(
                                    child: LoadingAnimationWidget.waveDots(
                                        color: isDark
                                            ? CustomColors.primaryLight
                                            : CustomColors.textColorLight,
                                        size: 24),
                                  );
                                case ProductIsInCartLoaded():
                                  return (state.data == null)
                                      ? SizedBox(
                                          height: 50,
                                          width: 150,
                                          child: AppFilledButton(
                                              isDark: isDark,
                                              text: "Add to Cart",
                                              onTap: () {
                                                context.read<CartBloc>().add(AddProductToCart(productId: productId, cartType: cartType, refreshStatus: true));
                                              }))
                                      : SizedBox(
                                          height: 50,
                                          width: 150,
                                          child: AppFilledButton(
                                              isDark: isDark,
                                              text: "Remove",
                                              onTap: () {
                                                context.read<CartBloc>().add(RemoveProductQtyFromCart(productId: productId, cartType: cartType, refreshStatus: true));
                                              }));
                                case CartError():
                                  return Container();
                                default:
                                  return const Placeholder();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            case ProductError():
              return ErrorComponent(
                  productId: productId, errorText: "Product not found.");
            case ProductInitial():
              return const Center(child: Text("Initial"));
            default:
              return const Placeholder();
          }
        }));
  }
}

class ErrorComponent extends StatelessWidget {
  final String productId;
  final String errorText;
  const ErrorComponent(
      {super.key, required this.productId, required this.errorText});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "We're unable to retrive this product, report to us this issue or try again some time later.",
                textAlign: TextAlign.center),
            SizedBox(height: 5),
            Text("[$productId]", textAlign: TextAlign.center),
            SizedBox(height: 20),
            CircleActionButton(
              isDark: isDark,
              icon: Iconsax.arrow_left,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
