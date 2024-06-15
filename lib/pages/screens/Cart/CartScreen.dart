import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/cart/bloc/cart_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/cart_item.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Checkout/CheckoutScreen.dart';
import 'package:quadrant_app/repositories/CartRepository/cart_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartRepository _cartRepository;

  @override
  void initState() {
    super.initState();
    _cartRepository = CartRepository(DioManager.instance);
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          CartBloc(cartRepository: _cartRepository)..add(FetchCart()),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                SectionText(
                    isDark: isDark, text: 'Cart', size: 32.0, bold: true),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    switch (state) {
                      case CartLoading():
                        return Center(
                            child: LoadingAnimationWidget.waveDots(
                                color: isDark
                                    ? CustomColors.primaryLight
                                    : CustomColors.textColorLight,
                                size: 24));
                      case CartLoaded():
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? CustomColors.secondaryDark
                                : CustomColors.secondaryLight,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(CustomSizes.borderRadiusLg)),
                          ),
                          child: Container(
                            height: displayHeight / 1.6,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.cart.length,
                                itemBuilder: (context, index) {
                                  final cartItem = state.cart[index];
                                  return Dismissible(
                                    key: Key(cartItem.product!.id.toString()),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      context.read<CartBloc>().add(
                                          RemoveProductFromCart(
                                              productId:
                                                  cartItem.product!.id!));
                                    },
                                    background: Container(
                                      color: Colors.redAccent,
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: 20),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.delete,
                                              color: Colors.white),
                                          SizedBox(width: 8),
                                          Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1),
                                      child:
                                          ShoppingCartItem(cartItem: cartItem),
                                    ),
                                  );
                                }),
                          ),
                        );
                      case CartError():
                        return const Text('Something went wrong!');
                      case CartInitial():
                        return const Center(child: Text("Loading"));
                      default:
                        return const Placeholder();
                    }
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              switch (state) {
                case CartLoading():
                return Container();
                  // return Center(
                  //     child: LoadingAnimationWidget.waveDots(
                  //         color: isDark
                  //             ? CustomColors.primaryLight
                  //             : CustomColors.textColorLight,
                  //         size: 24));
                case CartLoaded():
                if(state.cart.isNotEmpty){
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? CustomColors.navBarBackgroundDark
                            : CustomColors.navBarBackgroundLight,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(CustomSizes.borderRadiusMd)),
                      ),
                      height: displayHeight / 5.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            AppFilledButton(
                                isDark: isDark,
                                text: "Checkout",
                                onTap: () {
                                  Navigator.push(
                                      context, CheckoutScreen.route());
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                }else{
                  return Container();
                }
                default:
                  return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
