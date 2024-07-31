// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quadrant_app/blocs/cart/bloc/cart_bloc.dart';
import 'package:quadrant_app/pages/components/cart_item.dart';
import 'package:quadrant_app/pages/components/checkout_cart_item.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Checkout/GatewayWebviewScreen.dart';
import 'package:quadrant_app/repositories/CartRepository/cart_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/enums/cart_type.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CheckoutScreen extends StatefulWidget {
  final CartType cartType;
  const CheckoutScreen({super.key, this.cartType = CartType.ONLINE});

  static Route<void> route() {
    return CupertinoPageRoute<void>(builder: (_) => const CheckoutScreen());
  }

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _slideToActKey = GlobalKey<SlideActionState>();
  final _scrollController = ScrollController();

  List<PaymentMethod> paymentMethods = [
    PaymentMethod('Google Pay', 'assets/icons/gpay.svg'),
    PaymentMethod('Apple Pay', 'assets/icons/applepay.svg'),
    PaymentMethod('Online Banking', 'assets/icons/online1.svg'),
    PaymentMethod('Q-Wallet', 'assets/icons/qpay.svg'),
  ];

  late PaymentMethod selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    selectedPaymentMethod = paymentMethods[0];
  }

  void _changePaymentMethod(PaymentMethod method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  void _showPaymentMethodSelection(BuildContext context) {
    showBarModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Column(
              children: [
                Wrap(
                  children: paymentMethods.map((method) {
                    return ListTile(
                      leading: SvgPicture.asset(
                        method.assetPath,
                        width: 30,
                      ),
                      title: SideSectionText(
                          isDark: false,
                          text: method.name,
                          color: Colors.black),
                      onTap: () {
                        _changePaymentMethod(method);
                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 50)
              ],
            ),
          ],
        );
      },
    );
  }

  void _checkout(BuildContext context) {
    if (selectedPaymentMethod == paymentMethods[2]) {
      context.read<CartBloc>().add(CartCheckout(paymentMethodId: '2', cartType: widget.cartType));
    } else if (selectedPaymentMethod == paymentMethods[3]) {
      context.read<CartBloc>().add(CartCheckout(paymentMethodId: '3', cartType: widget.cartType));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${selectedPaymentMethod.name} is not available yet!'),
          duration: const Duration(seconds: 3),
        ),
      );
      Future.delayed(
        Duration(seconds: 1),
        () => {_slideToActKey.currentState!.reset()},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocProvider(
      create: (context) =>
          CartBloc(cartRepository: CartRepository(DioManager.instance))
            ..add(FetchCart(widget.cartType)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartCheckoutCallback) {
              final result = Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => PaymentWebViewScreen(
                      url: state.cartCheckout.redirectUrl!),
                ),
              );
              if (!context.mounted) return;
              result.then((value) {
                // context.read<CartBloc>().add(FetchCart(widget.cartType));
                Navigator.pop(context, true);
              });
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FadingEdgeScrollView.fromScrollView(
                child: ListView(
                  controller: _scrollController,
                  children: [
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
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? CustomColors.secondaryDark
                                    : CustomColors.secondaryLight,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        CustomSizes.borderRadiusLg)),
                              ),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: state.cart.length,
                                  itemBuilder: (context, index) {
                                    final cartItem = state.cart[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1),
                                      child:
                                          CheckoutCartItem(cartItem: cartItem),
                                    );
                                  }),
                            ).animate().fade();
                          case CartError():
                            return const Text('Something went wrong!');
                          case CartInitial():
                            return const Center(child: Text("Loading"));
                          default:
                            return Center(
                                child: LoadingAnimationWidget.waveDots(
                                    color: isDark
                                        ? CustomColors.primaryLight
                                        : CustomColors.textColorLight,
                                    size: 24));
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SectionText(
                          isDark: isDark,
                          text: "Offers & Benefits",
                          size: 20.0,
                          bold: true),
                    ),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? CustomColors.secondaryDark
                                    : CustomColors.secondaryLight,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        CustomSizes.borderRadiusLg)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SideSectionText(
                                      isDark: isDark,
                                      text: "Add Voucher",
                                      color: isDark
                                          ? CustomColors.textColorDark
                                          : CustomColors.textColorLight),
                                  Icon(
                                    Iconsax.arrow_right_3,
                                    color: isDark
                                        ? CustomColors.textColorDark
                                        : CustomColors.textColorLight,
                                    size: 16,
                                  )
                                ],
                              ),
                            );
                          default:
                            return Center(
                                child: LoadingAnimationWidget.waveDots(
                                    color: isDark
                                        ? CustomColors.primaryLight
                                        : CustomColors.textColorLight,
                                    size: 24));
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SectionText(
                          isDark: isDark,
                          text: "Order Summary",
                          size: 20.0,
                          bold: true),
                    ),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? CustomColors.secondaryDark
                                    : CustomColors.secondaryLight,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        CustomSizes.borderRadiusLg)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SideSectionText(
                                          isDark: isDark,
                                          text: "Subtotal",
                                          color: isDark
                                              ? CustomColors.textColorDark
                                              : CustomColors.textColorLight),
                                      SideSectionText(
                                          isDark: isDark,
                                          text:
                                              "RM ${state.meta.subtotal?.toStringAsFixed(2)}",
                                          color: isDark
                                              ? CustomColors.textColorDark
                                              : CustomColors.textColorLight),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SideSectionText(
                                          isDark: isDark,
                                          text: "Discount & Rebates",
                                          color: isDark
                                              ? CustomColors.textColorDark
                                              : CustomColors.textColorLight),
                                      SideSectionText(
                                          isDark: isDark,
                                          text:
                                              "- RM ${state.meta.discount?.toStringAsFixed(2)}",
                                          color: isDark
                                              ? CustomColors.textColorDark
                                              : CustomColors.textColorLight),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SideSectionText(
                                          isDark: isDark,
                                          text: "Total",
                                          color: isDark
                                              ? CustomColors.textColorDark
                                              : CustomColors.textColorLight,
                                          bold: true),
                                      SideSectionText(
                                        isDark: isDark,
                                        text:
                                            "RM ${state.meta.total?.toStringAsFixed(2)}",
                                        color: isDark
                                            ? CustomColors.textColorDark
                                            : CustomColors.textColorLight,
                                        bold: true,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );

                          default:
                            return Center(
                                child: LoadingAnimationWidget.waveDots(
                                    color: isDark
                                        ? CustomColors.primaryLight
                                        : CustomColors.textColorLight,
                                    size: 24));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 190,
          decoration: BoxDecoration(
              color: isDark
                  ? CustomColors.navBarBackgroundDark
                  : CustomColors.navBarBackgroundLight,
              borderRadius: const BorderRadius.all(
                  Radius.circular(CustomSizes.borderRadiusMd)),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? CustomColors.primaryDark.withOpacity(0.2)
                      : CustomColors.primaryLight.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 100,
                  offset: const Offset(0, 3),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark
                                  ? CustomColors.borderDark
                                  : CustomColors.borderLight,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              selectedPaymentMethod.assetPath,
                              height: 50,
                              colorFilter:
                                  (selectedPaymentMethod == paymentMethods[2] ||
                                          selectedPaymentMethod ==
                                              paymentMethods[3])
                                      ? ColorFilter.mode(
                                          isDark
                                              ? CustomColors.textColorDark
                                              : CustomColors.textColorLight,
                                          BlendMode.srcIn)
                                      : null,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SideSectionText(
                                isDark: isDark,
                                text: "Pay using",
                                size: 13.0,
                                color: isDark
                                    ? CustomColors.textColorDark
                                    : CustomColors.textColorLight),
                            SideSectionText(
                                isDark: isDark,
                                text: selectedPaymentMethod.name,
                                size: 15.0,
                                bold: true,
                                color: isDark
                                    ? CustomColors.textColorDark
                                    : CustomColors.textColorLight),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _showPaymentMethodSelection(context),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SideSectionText(
                              isDark: isDark, text: "Change", size: 16.0),
                          Icon(
                            Iconsax.arrow_right_3,
                            color: isDark
                                ? CustomColors.primaryDark
                                : CustomColors.primaryLight,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    switch (state) {
                      case CartLoading():
                        return Center(
                            child: LoadingAnimationWidget.threeArchedCircle(
                                color: isDark
                                    ? CustomColors.primaryLight
                                    : CustomColors.textColorLight,
                                size: 24));
                      case CartLoaded():
                        return SlideAction(
                          key: _slideToActKey,
                          borderRadius: 50,
                          elevation: 0,
                          innerColor: CustomColors.secondaryLight,
                          outerColor: isDark
                              ? CustomColors.primaryDark
                              : CustomColors.primaryDark,
                          sliderButtonIcon: Icon(Iconsax.arrow_right_3),
                          text:
                              'Slide to Pay | RM ${state.meta.total?.toStringAsFixed(2)}',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          submittedIcon:
                              LoadingAnimationWidget.threeArchedCircle(
                            color: CustomColors.secondaryLight,
                            size: 21,
                          ),
                          trigger: 0.99,
                          animationDuration: Duration(milliseconds: 450),
                          onSubmit: () {
                            _checkout(context);
                          },
                        );

                      default:
                        return Center(
                            child: LoadingAnimationWidget.threeArchedCircle(
                                color: isDark
                                    ? CustomColors.primaryLight
                                    : CustomColors.textColorLight,
                                size: 24));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethod {
  final String name;
  final String assetPath;

  PaymentMethod(this.name, this.assetPath);
}
