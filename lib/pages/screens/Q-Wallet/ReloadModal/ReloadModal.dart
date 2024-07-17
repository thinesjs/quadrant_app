import 'dart:ui';

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:quadrant_app/blocs/ewallet/bloc/ewallet_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Checkout/GatewayWebviewScreen.dart';
import 'package:quadrant_app/repositories/EwalletRepository/ewallet_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:sheet/sheet.dart';

class ReloadModel1 extends StatelessWidget {
  const ReloadModel1({super.key});

  void pushRoute(BuildContext context, BuildContext modalContext) {
    Navigator.of(context).push(
      ReloadModel2.route(modalContext),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: displayHeight / 1.6,
      child: Scaffold(
        body: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute<void>(
            builder: (BuildContext newContext) => SheetMediaQuery(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          height: displayHeight / 5,
                          color: Colors.black87,
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 25.0),
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Opacity(
                                        opacity: 0.3,
                                        child: Container(
                                          child: Lottie.asset(
                                              'assets/animations/wallet-transfer.json',
                                              repeat: true,
                                              fit: BoxFit.fill,
                                              renderCache: RenderCache.raster),
                                        ),
                                      )
                                          .animate(delay: 0.5.seconds)
                                          .fade()
                                          .slideY(begin: -0.2),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "Reload Wallet",
                                      style: TextStyle(
                                        color: CustomColors.textColorDark,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Understanding the Top-Up Process",
                                      style: TextStyle(
                                        color: CustomColors.subTextColorDark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ]
                                      .animate(
                                          interval: .5.milliseconds,
                                          delay: 0.5.seconds)
                                      .fade()
                                      .slideX(begin: -0.2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    CircleActionButton(
                                      isDark: isDark,
                                      icon: Icons.close,
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
                    SizedBox(
                      height: displayHeight / 3,
                      child: FadingEdgeScrollView.fromSingleChildScrollView(
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 25, 25, 12),
                                child:
                                    TitleTextWidget(text: "Enter the Amount"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Specify the amount you wish to add to your e-wallet. Ensure the amount is within your set limits."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: TitleTextWidget(
                                    text: "Choose a Payment Method"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Select your preferred payment method from the available options. You can use credit/debit cards, bank transfers, or other supported methods."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: TitleTextWidget(
                                    text: "Confirm Your Details"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Review the entered amount and selected payment method. Ensure all details are correct before proceeding."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: TitleTextWidget(
                                    text: "Complete the Transaction"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Once you confirm, the transaction will be processed, and your e-wallet will be topped up with the amount as soon as the transaction is verified."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Ready to top up? Tap “Got It” to continue."),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate(delay: 0.3.seconds).fade(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 12, 25, 12),
                      child: AppFilledButton(
                          isDark: isDark,
                          text: "Got It",
                          borderRadius: 50,
                          onTap: () {
                            pushRoute(newContext, context);
                          }),
                    ).animate(delay: 1.seconds).fade().slideY(begin: 0.2)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReloadModel2 extends StatefulWidget {
  final BuildContext modalContext;
  const ReloadModel2({super.key, required this.modalContext});

  static Route<void> route(BuildContext modalContext) {
    return MaterialPageRoute<void>(builder: (_) => ReloadModel2(modalContext: modalContext));
  }

  @override
  State<ReloadModel2> createState() => _ReloadModel2State();
}

class _ReloadModel2State extends State<ReloadModel2> {
  bool isLoading = false;
  TextEditingController walletIdTxt = TextEditingController();

  void pushRoute(BuildContext context, BuildContext modalContext, String amount) {

    // link to reloadmodal3
    Navigator.of(context).push(
      ReloadModal3.route(modalContext, amount),
      // (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: displayHeight / 1.6,
        child: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute<void>(
            builder: (BuildContext newContext) => SheetMediaQuery(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          height: displayHeight / 5,
                          color: Colors.black87,
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 25.0),
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Opacity(
                                        opacity: 0.3,
                                        child: Container(
                                          child: Lottie.asset(
                                              'assets/animations/wallet-transfer.json',
                                              repeat: false,
                                              fit: BoxFit.fill,
                                              renderCache: RenderCache.raster),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "Amount",
                                      style: TextStyle(
                                        color: CustomColors.textColorDark,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "How much funds you'd like to add into your wallet?",
                                      style: TextStyle(
                                        color: CustomColors.subTextColorDark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ]
                                      .animate(
                                          interval: .5.milliseconds,
                                          delay: 0.5.seconds)
                                      .fade()
                                      .slideX(begin: -0.2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleActionButton(
                                      isDark: isDark,
                                      icon: Iconsax.arrow_left_2,
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
                    SizedBox(
                      height: displayHeight / 3,
                      child: FadingEdgeScrollView.fromSingleChildScrollView(
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 25, 25, 12),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: BackdropFilter(
                                    filter: isDark
                                        ? ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10)
                                        : ImageFilter.blur(
                                            sigmaX: 0, sigmaY: 0),
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? CustomColors.secondaryDark
                                            : CustomColors.secondaryLight,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: TextField(
                                        controller: walletIdTxt,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        // onChanged: onChange,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "100",
                                          hintStyle: TextStyle(
                                              color: isDark
                                                  ? const Color.fromARGB(
                                                      255, 147, 147, 147)
                                                  : Colors.black54,
                                              fontSize: 15),
                                          prefixIcon: Align(
                                            widthFactor: 1.0,
                                            heightFactor: 1.0,
                                            child: Text("RM",
                                                style: TextStyle(
                                                    color: isDark
                                                        ? const Color(
                                                            0xFFFEFDFE)
                                                        : Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17)),
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () async {
                                              final clipboardData =
                                                  await Clipboard.getData(
                                                      Clipboard.kTextPlain);
                                              String? clipboardText =
                                                  clipboardData?.text;

                                              setState(() {
                                                walletIdTxt.text =
                                                    clipboardText ?? "";
                                              });
                                            },
                                            child: Align(
                                                widthFactor: 1.0,
                                                heightFactor: 1.0,
                                                child: !isLoading
                                                    ? Icon(
                                                        Iconsax
                                                            .clipboard_import,
                                                        color:
                                                            isDark
                                                                ? const Color(
                                                                    0xFFFEFDFE)
                                                                : Colors
                                                                    .black87)
                                                    : LoadingAnimationWidget
                                                        .inkDrop(
                                                        color: isDark
                                                            ? const Color(
                                                                0xFFFEFDFE)
                                                            : Colors.black87,
                                                        size: 24,
                                                      )),
                                          ),
                                        ),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                child: TitleTextWidget(text: "Quick Amounts"),
                              ),
                              FadingEdgeScrollView.fromSingleChildScrollView(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  controller: ScrollController(),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 0, 5, 12),
                                        child: AppOutlinedButton(
                                            text: "RM 10",
                                            onTap: () {
                                              setState(() {
                                                walletIdTxt.text = "10";
                                              });
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 12),
                                        child: AppOutlinedButton(
                                            text: "RM 20",
                                            onTap: () {
                                              setState(() {
                                                walletIdTxt.text = "20";
                                              });
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 12),
                                        child: AppOutlinedButton(
                                            text: "RM 30",
                                            onTap: () {
                                              setState(() {
                                                walletIdTxt.text = "30";
                                              });
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 12),
                                        child: AppOutlinedButton(
                                            text: "RM 50",
                                            onTap: () {
                                              setState(() {
                                                walletIdTxt.text = "50";
                                              });
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 12),
                                        child: AppOutlinedButton(
                                            text: "RM 100",
                                            onTap: () {
                                              setState(() {
                                                walletIdTxt.text = "100";
                                              });
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 25, 12),
                                        child: AppOutlinedButton(
                                            text: "RM 200",
                                            onTap: () {
                                              setState(() {
                                                walletIdTxt.text = "200";
                                              });
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                                child: TitleTextWidget(text: "Payment Method"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 0, 25, 10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 12, 0),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                            'assets/icons/online1.svg',
                                            height: 30,
                                            colorFilter: ColorFilter.mode(
                                                isDark
                                                    ? CustomColors.textColorDark
                                                    : CustomColors
                                                        .textColorLight,
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SideSectionText(
                                        isDark: isDark,
                                        text: "Online Banking",
                                        bold: false,
                                        color: isDark
                                            ? CustomColors.textColorDark
                                            : CustomColors.textColorLight)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ).animate(delay: 0.5.seconds).fade(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 12, 25, 12),
                      child: AppFilledButton(
                          isDark: isDark,
                          text: "Next",
                          borderRadius: 50,
                          onTap: () {
                            pushRoute(newContext, widget.modalContext, walletIdTxt.text);
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReloadModal3 extends StatefulWidget {
  final BuildContext modalContext;
  final String walletId;
  const ReloadModal3({super.key, required this.walletId, required this.modalContext});

  static Route<void> route(BuildContext modalContext, String walletId) {
    return MaterialPageRoute<void>(
        builder: (_) => ReloadModal3(modalContext: modalContext, walletId: walletId));
  }

  @override
  State<ReloadModal3> createState() => _ReloadModal3State();
}

class _ReloadModal3State extends State<ReloadModal3> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // double displayWidth = MediaQuery.of(context).size.width;
    // double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocProvider(
            create: (context) => EwalletBloc(
                        ewalletRepository:
                            EwalletRepository(DioManager.instance))
                      ..add(ReloadWallet(widget.walletId)),
            child: BlocBuilder<EwalletBloc, EwalletState>(
              builder: (context, state) {
                if (state is EwalletLoading) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Center(
                      child: LoadingAnimationWidget.waveDots(
                        color: isDark
                            ? CustomColors.primaryLight
                            : CustomColors.textColorLight,
                        size: 24,
                      ),
                    ),
                  );
                } else if (state is EwalletReloadCallbackLoaded) {
                  Future.microtask(() {
                    Navigator.pop(widget.modalContext, state.data.redirectUrl!);
                  });
                  return Center(child: Text(state.data.orderId ?? "null"));
                } else if (state is EwalletError) {
                  return const Center(child: Text('We have encountered an error trying to process your request. Please try again later.'));
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}

class SubtitleTextWidget extends StatelessWidget {
  const SubtitleTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Text(
      text,
      style: TextStyle(
          letterSpacing: 0.5,
          color: isDark
              ? CustomColors.subTextColorDark.withOpacity(0.8)
              : CustomColors.subTextColorLight.withOpacity(0.8),
          fontWeight: FontWeight.normal),
    );
  }
}

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Text(
      text,
      style: TextStyle(
          letterSpacing: 0.5,
          color:
              isDark ? CustomColors.textColorDark : CustomColors.textColorLight,
          fontWeight: FontWeight.bold),
    );
  }
}
