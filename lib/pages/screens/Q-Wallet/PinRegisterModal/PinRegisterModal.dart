import 'dart:ui';

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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

class PinRegisterModal1 extends StatelessWidget {
  const PinRegisterModal1({super.key});

  void pushRoute(BuildContext context, BuildContext modalContext) {
    Navigator.of(context).push(
      PinRegisterModal2.route(modalContext),
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
                                      "Create a PIN",
                                      style: TextStyle(
                                        color: CustomColors.textColorDark,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Understanding the pin creation process",
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
                                child: TitleTextWidget(
                                    text: "Enter a secure 6 digit pin"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Type in a unique 6-digit personal identification number (PIN) to protect your e-wallet."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: TitleTextWidget(text: "Before that.."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Ensure your PIN is easy for you to remember but difficult for others to guess."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: TitleTextWidget(text: "But, remember!"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Avoid using easily guessable sequences like “123456” or “000000.”"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child:
                                    TitleTextWidget(text: "Most importantly,"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text: "Do not share your PIN with anyone."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Thought of a six digit pin? Tap “Got It” to continue."),
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

class PinRegisterModal2 extends StatefulWidget {
  final BuildContext modalContext;
  const PinRegisterModal2({super.key, required this.modalContext});

  static Route<void> route(BuildContext modalContext) {
    return CupertinoPageRoute<void>(
        builder: (_) => PinRegisterModal2(modalContext: modalContext));
  }

  @override
  State<PinRegisterModal2> createState() => _ReloadModel2State();
}

class _ReloadModel2State extends State<PinRegisterModal2> {
  bool isLoading = true;
  String pin_code = "";
  TextEditingController walletIdTxt = TextEditingController();

  void pushRoute(
      BuildContext context, BuildContext modalContext, String amount) {
    // link to reloadmodal3
    Navigator.of(context).push(
      PinRegisterModal3.route(modalContext, amount),
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
                                      "Enter your PIN",
                                      style: TextStyle(
                                        color: CustomColors.textColorDark,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Type in your 6-digit PIN to continue",
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
                              const Padding(
                                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                                child: TitleTextWidget(
                                    text: "Enter your 6-digit PIN"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 25, 0, 12),
                                child: OtpTextField(
                                  numberOfFields: 6,
                                  borderColor: isDark
                                      ? CustomColors.textColorDark
                                      : CustomColors.textColorLight,
                                  showFieldAsBox: true,
                                  obscureText: true,
                                  onCodeChanged: (String code) {},
                                  onSubmit: (String verificationCode) {
                                    setState(() {
                                      isLoading = false;
                                      pin_code = verificationCode;
                                    });
                                  }, // end onSubmit
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate(delay: 0.5.seconds).fade(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 12, 25, 12),
                      child: AppFilledButton(
                          isDark: isDark,
                          text: "Register PIN",
                          borderRadius: 50,
                          isLoading: isLoading,
                          onTap: () {
                            pushRoute(
                                newContext, widget.modalContext, pin_code);
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

class PinRegisterModal3 extends StatefulWidget {
  final BuildContext modalContext;
  final String pin_code;
  const PinRegisterModal3(
      {super.key, required this.pin_code, required this.modalContext});

  static Route<void> route(BuildContext modalContext, String pin_code) {
    return CupertinoPageRoute<void>(
        builder: (_) =>
            PinRegisterModal3(modalContext: modalContext, pin_code: pin_code));
  }

  @override
  State<PinRegisterModal3> createState() => _ReloadModal3State();
}

class _ReloadModal3State extends State<PinRegisterModal3> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocProvider(
            create: (context) => EwalletBloc(
                ewalletRepository: EwalletRepository(DioManager.instance))
              ..add(RegisterPin(widget.pin_code)),
            child: BlocBuilder<EwalletBloc, EwalletState>(
              builder: (context, state) {
                if (state is EwalletLoading) {
                  return Center(
                    child: LoadingAnimationWidget.waveDots(
                      color: isDark
                          ? CustomColors.primaryLight
                          : CustomColors.textColorLight,
                      size: 24,
                    ),
                  );
                } else if (state is EwalletLoaded) {
                  return SizedBox(
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
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 40, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Opacity(
                                                    opacity: 0.3,
                                                    child: Container(
                                                      child: Lottie.asset(
                                                          'assets/animations/wallet-transfer.json',
                                                          repeat: false,
                                                          fit: BoxFit.fill,
                                                          renderCache:
                                                              RenderCache
                                                                  .raster),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Text(
                                                  "You're all set!",
                                                  style: TextStyle(
                                                    color: CustomColors
                                                        .textColorDark,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "Your PIN has been successfully created",
                                                  style: TextStyle(
                                                    color: CustomColors
                                                        .subTextColorDark,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                  child: FadingEdgeScrollView
                                      .fromSingleChildScrollView(
                                    child: SingleChildScrollView(
                                      controller: ScrollController(),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                25, 25, 25, 12),
                                            child: TitleTextWidget(
                                                text: "Remember!"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                25, 0, 25, 12),
                                            child: SubtitleTextWidget(
                                                text:
                                                    "Do not share your PIN with anyone."),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                25, 12, 25, 12),
                                            child: SubtitleTextWidget(
                                                text:
                                                    "Tap “Got It” to continue."),
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
                                        Navigator.pop(widget.modalContext);
                                      }),
                                ).animate(delay: 1.seconds).fade().slideY(begin: 0.2)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is EwalletError) {
                  return const Center(
                      child: Text(
                          'We have encountered an error trying to process your request. Please try again later.'));
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
