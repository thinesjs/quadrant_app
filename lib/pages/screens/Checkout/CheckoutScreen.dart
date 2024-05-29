// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CheckoutScreen());
  }

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _slideToActKey = GlobalKey<SlideActionState>();

  List<PaymentMethod> paymentMethods = [
    PaymentMethod('Google Pay', 'assets/icons/gpay.svg'),
    PaymentMethod('Apple Pay', 'assets/icons/applepay.svg'),
    PaymentMethod('Online Banking', 'assets/icons/online1.svg'),
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
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                  child: Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0))),
                  ),
                ),
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

  void _checkout() {
    Future.delayed(
      Duration(seconds: 10),
      () => {_slideToActKey.currentState!.reset()},
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: const Center(
        child: Text('Checkout Screen'),
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
                                (selectedPaymentMethod == paymentMethods[2])
                                    ? ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn)
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
              SlideAction(
                key: _slideToActKey,
                borderRadius: 50,
                elevation: 0,
                innerColor: CustomColors.secondaryLight,
                outerColor: isDark
                    ? CustomColors.primaryDark
                    : CustomColors.primaryDark,
                sliderButtonIcon: Icon(Iconsax.arrow_right_3),
                text: 'Slide to Pay',
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                submittedIcon: LoadingAnimationWidget.threeArchedCircle(
                  color: CustomColors.secondaryLight,
                  size: 21,
                ),
                trigger: 0.99,
                animationDuration: Duration(milliseconds: 450),
                onSubmit: () {
                  _checkout();
                },
              )
            ],
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
