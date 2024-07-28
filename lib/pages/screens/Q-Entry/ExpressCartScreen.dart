import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quadrant_app/blocs/cart/bloc/cart_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/cart_item.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Checkout/CheckoutScreen.dart';
import 'package:quadrant_app/repositories/CartRepository/cart_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/enums/cart_type.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:sheet/sheet.dart';

class ExpressCartScreen extends StatefulWidget {
  const ExpressCartScreen({super.key});

  @override
  State<ExpressCartScreen> createState() => _ExpressCartScreenState();
}

class _ExpressCartScreenState extends State<ExpressCartScreen> {
  late final CartRepository _cartRepository;

  @override
  void initState() {
    super.initState();
    _cartRepository = CartRepository(DioManager.instance);
    // Future.delayed(const Duration(seconds: 2), () {
    //   context.read<CartBloc>().add(const FetchCart(CartType.IN_STORE));
    // });
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => CartBloc(cartRepository: _cartRepository)
        ..add(const FetchCart(CartType.IN_STORE)),
      child: Material(
        child: SheetMediaQuery(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Q-ExpressCart'),
              leading: IconButton(
                icon: const Icon(Iconsax.arrow_down_1),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: BlocBuilder<CartBloc, CartState>(
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
                            child: SizedBox(
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
                                            RemoveProductQtyFromCart(
                                                productId:
                                                    cartItem.product!.id!,
                                                cartType: CartType.IN_STORE));
                                      },
                                      background: Container(
                                        color: Colors.redAccent,
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 20),
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
                                        child: ShoppingCartItem(
                                          cartItem: cartItem,
                                          onIncrement: () {
                                            context.read<CartBloc>().add(
                                                AddProductQtyFromCart(
                                                    productId:
                                                        cartItem.product!.id!,
                                                    qty: 1,
                                                    cartType:
                                                        CartType.IN_STORE));
                                          },
                                          onDecrement: () {
                                            context.read<CartBloc>().add(
                                                RemoveProductQtyFromCart(
                                                    productId:
                                                        cartItem.product!.id!,
                                                    qty: 1,
                                                    cartType:
                                                        CartType.IN_STORE));
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ).animate().fade();
                        case CartError():
                          return const Text('Something went wrong!');
                        case CartInitial():
                          return const Center(child: Text("Loading"));
                        default:
                          return const Placeholder();
                      }
                    },
                  ),
                )
              ],
            ),
            bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Container(
                  height: displayHeight / 10,
                  decoration: BoxDecoration(
                    color: isDark
                        ? CustomColors.navBarBackgroundDark
                        : CustomColors.navBarBackgroundLight,
                    borderRadius: const BorderRadius.only(
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
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if(state is CartLoaded){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SectionText(
                                  isDark: isDark,
                                  text: "RM ${state.meta.total!.toStringAsFixed(2)}",
                                  size: 20.0,
                                  bold: true),
                              if(state.meta.total != 0) SizedBox(
                                height: 50,
                                width: 150,
                                child: AppFilledButton(
                                    isDark: isDark,
                                    text: "Checkout",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => const CheckoutScreen(
                                            cartType: CartType.IN_STORE,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          );
                        }else if(state is CartLoading){
                          return LoadingAnimationWidget.waveDots(
                                    color: isDark
                                        ? CustomColors.primaryLight
                                        : CustomColors.textColorLight,
                                    size: 24);
                        }else{
                          return Container();
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
