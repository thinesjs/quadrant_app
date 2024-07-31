// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

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
import 'package:quadrant_app/blocs/order/bloc/order_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/cart_item.dart';
import 'package:quadrant_app/pages/components/checkout_cart_item.dart';
import 'package:quadrant_app/pages/components/order_item_component.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Checkout/GatewayWebviewScreen.dart';
import 'package:quadrant_app/repositories/CartRepository/cart_repository.dart';
import 'package:quadrant_app/repositories/OrderRepository/order_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/enums/cart_type.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:slide_to_act/slide_to_act.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  static Route<void> route(String orderId) {
    return CupertinoPageRoute<void>(
        builder: (_) => OrderDetailsScreen(orderId: orderId));
  }

  @override
  State<OrderDetailsScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<OrderDetailsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocProvider(
      create: (context) =>
          OrderBloc(orderRepository: OrderRepository(DioManager.instance))
            ..add(FetchOrder(widget.orderId)),
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          switch (state) {
            case OrderLoading():
              return Scaffold(
                body: Center(
                  child: LoadingAnimationWidget.waveDots(
                      color: isDark
                          ? CustomColors.primaryLight
                          : CustomColors.textColorLight,
                      size: 24),
                ),
              );
            case OrderLoaded():
              return Scaffold(
                appBar: AppBar(
                  title: Text("Order Details"),
                ),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FadingEdgeScrollView.fromScrollView(
                      child: ListView(
                        controller: _scrollController,
                        children: [
                          if (!state.order.isPaid!)
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Iconsax.warning_2,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10.0),
                                      Expanded(
                                        child: Text(
                                          "Please complete your payment to confirm order.",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                AppFilledButton(
                                  isDark: isDark, 
                                  text: "Complete Payment Now", 
                                  onTap: (){
                                    final result = Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => PaymentWebViewScreen(
                                            url: "https://www.billplz-sandbox.com/bills/${state.order.bplzId}"),
                                      ),
                                    );
                                  })
                              ],
                            ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: state.order.orderItems!.length,
                              itemBuilder: (context, index) {
                                final orderItem =
                                    state.order.orderItems![index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1),
                                  child:
                                      OrderItemComponent(orderItem: orderItem),
                                );
                              }),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SectionText(
                                isDark: isDark,
                                text: "Order Summary",
                                size: 20.0,
                                bold: true),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? CustomColors.secondaryDark
                                  : CustomColors.secondaryLight,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(CustomSizes.borderRadiusLg)),
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
                                            "RM ${state.order.total?.toStringAsFixed(2)}",
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
                                        text: "- RM 0.00",
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
                                          "RM ${state.order.total?.toStringAsFixed(2)}",
                                      color: isDark
                                          ? CustomColors.textColorDark
                                          : CustomColors.textColorLight,
                                      bold: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            default:
              return Scaffold(
                body: Center(
                  child: LoadingAnimationWidget.waveDots(
                      color: isDark
                          ? CustomColors.primaryLight
                          : CustomColors.textColorLight,
                      size: 24),
                ),
              );
          }
        },
      ),
    );
  }
}
