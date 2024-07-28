import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/order/bloc/order_bloc.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/order_card.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/repositories/OrderRepository/order_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  static Route<void> route() {
    return CupertinoPageRoute<void>(builder: (_) => const OrdersScreen());
  }

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final OrderRepository _orderRepository;

  @override
  void initState() {
    super.initState();
    _orderRepository = OrderRepository(DioManager.instance);
  }

  // @override
  // Widget build(BuildContext context) {
  //   var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  //   return BlocProvider(
  //     create: (context) =>
  //         OrderBloc(orderRepository: _orderRepository)..add(FetchOrders()),
  //     child: Scaffold(
  //       body: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
  //         child: ListView(
  //           physics: const ClampingScrollPhysics(),
  //           children: <Widget>[
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 CircleActionButton(
  //                   isDark: isDark,
  //                   icon: Iconsax.arrow_left,
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 SectionText(
  //                     isDark: isDark, text: 'Orders', size: 32.0, bold: true),
  //               ],
  //             ),
  //             SectionHelperText(
  //                 isDark: isDark,
  //                 text:
  //                     'Manage your orders and keep track of your shopping experiances'),
  //             BlocBuilder<OrderBloc, OrderState>(
  //               builder: (context, state) {
  //                 switch (state) {
  //                   case OrderLoading():
  //                     return Center(child: LoadingAnimationWidget.waveDots(color: isDark ? CustomColors.primaryLight : CustomColors.textColorLight, size: 24));
  //                   case OrdersLoaded():
  //                     return Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 10),
  //                     child: Column(
  //                       children: [
  //                         ListView.builder(
  //                           shrinkWrap: true,
  //                           physics: const BouncingScrollPhysics(),
  //                           itemCount: 10,
  //                           itemBuilder: (context, index) {
  //                             return OrderCardComponent(
  //                               isDark: isDark,
  //                               type: 'Order: di23dh38',
  //                               name: 'Home',
  //                               onTap: () {},
  //                             );
  //                           }
  //                         )
  //                       ],
  //                     ),
  //                   );
  //                   case OrderError():
  //                     return const ErrorComponent();
  //                   default:
  //                     return Center(child: LoadingAnimationWidget.waveDots(color: isDark ? CustomColors.primaryLight : CustomColors.textColorLight, size: 24));
  //                 }
  //               },
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
      create: (context) =>
        OrderBloc(orderRepository: _orderRepository)..add(FetchOrders()),
        child: Padding(
          padding: EdgeInsets.only(top: displayHeight * 0.084, left: 20, right: 19),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleActionButton(
                    isDark: isDark,
                    icon: Iconsax.arrow_left,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SectionText(
                      isDark: isDark,
                      text: 'Orders',
                      size: 32.0,
                      bold: true),
                ],
              ),
              SectionHelperText(
                  isDark: isDark,
                  text:
                      'Manage your orders and keep track of your shopping experiances.'),
              Expanded(
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    switch (state) {
                      case OrderLoading():
                        return Center(
                          child: LoadingAnimationWidget.waveDots(
                              color: isDark
                                  ? CustomColors.primaryLight
                                  : CustomColors.textColorLight,
                              size: 24),
                        );
                      case OrdersLoaded():
                        return FadingEdgeScrollView.fromScrollView(
                          child: ListView.builder(
                              controller: ScrollController(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.orders?.length,
                              itemBuilder: (context, index) {
                                final order = state.orders?[index];
                                return OrderCardComponent(
                                  isDark: isDark,
                                  orderNum: index + 1,
                                  order: order!,
                                  onTap: () {
                                    // if (order.id != null){
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => OrderScreen(orderId: order.id),
                                    //     ),
                                    //   );
                                    // }
                                  },
                                ).animate().fade();
                              }),
                        );
                      case OrderError():
                        return const ErrorComponent();
                      default:
                        return Center(
                          child: LoadingAnimationWidget.waveDots(
                              color: isDark
                                  ? CustomColors.primaryLight
                                  : CustomColors.textColorLight,
                              size: 24),
                        );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({super.key});

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
            const Text(
                "We're unable to retrive your order history, report to us this issue or try again some time later.",
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
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