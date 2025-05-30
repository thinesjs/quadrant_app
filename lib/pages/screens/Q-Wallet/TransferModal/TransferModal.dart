import 'dart:ui';

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:sheet/sheet.dart';

class TransferModal1 extends StatelessWidget {
  const TransferModal1({super.key});

  void pushRoute(BuildContext context, BuildContext modalContext) {
    Navigator.of(context).push(
      TransferModal2.route(),
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
                                      "Transfer",
                                      style: TextStyle(
                                        color: CustomColors.textColorDark,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Understanding the Money Transfer Process",
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
                                child: TitleTextWidget(
                                    text: "Entering Recipient Details"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Provide the recipient's information, such as their name and account details. Make sure the details are accurate."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child:
                                    TitleTextWidget(text: "Specify the Amount"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Enter the amount you wish to transfer. Ensure it is within your transfer limits."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: TitleTextWidget(
                                    text: "Choose a Transfer Method"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Select your preferred transfer method. Options may include bank transfer, mobile number, or email."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child:
                                    TitleTextWidget(text: "Review and Confirm"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Check all the entered details and the transfer amount. Make sure everything is correct before proceeding."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: TitleTextWidget(
                                    text: "Complete the Transfer"),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Confirm the transfer to complete the transaction."),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Ready to transfer money? Tap “Got It” to continue."),
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

class TransferModal2 extends StatefulWidget {
  const TransferModal2({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const TransferModal2());
  }

  @override
  State<TransferModal2> createState() => _TransferModal2State();
}

class _TransferModal2State extends State<TransferModal2> {
  bool isLoading = false;
  TextEditingController walletIdTxt = TextEditingController();

  void pushRoute(BuildContext context, BuildContext modalContext) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext newContext) => Scaffold(
          appBar: AppBar(
            title: Text('New Page'),
          ),
          body: ListView(
            shrinkWrap: true,
            children: [Text("data")],
          ),
        ),
      ),
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
                                      "Recipient",
                                      style: TextStyle(
                                        color: CustomColors.textColorDark,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Who will be receiving the money?",
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
                                          hintText:
                                              "Wallet ID, Email, or Phone",
                                          hintStyle: TextStyle(
                                            color: isDark
                                                ? const Color.fromARGB(
                                                    255, 147, 147, 147)
                                                : Colors.black54,
                                                fontSize: 15
                                          ),
                                          prefixIcon: Align(
                                            widthFactor: 1.0,
                                            heightFactor: 1.0,
                                            child: Text("To",
                                                style: TextStyle(
                                                    color: isDark
                                                        ? const Color(
                                                            0xFFFEFDFE)
                                                        : Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 17)
                                                        ),
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () async {
                                              final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                                              String? clipboardText = clipboardData?.text;

                                              setState(() {
                                                walletIdTxt.text = clipboardText ?? "";
                                              });
                                            },
                                            child: Align(
                                                widthFactor: 1.0,
                                                heightFactor: 1.0,
                                                child: !isLoading
                                                    ? Icon(
                                                        Iconsax.clipboard_import,
                                                        color: isDark
                                                            ? const Color(
                                                                0xFFFEFDFE)
                                                            : Colors.black87)
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
                                padding: EdgeInsets.fromLTRB(25, 25, 25, 12),
                                child: TitleTextWidget(
                                    text: "Previous Recipients"),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
                                child: SubtitleTextWidget(
                                    text:
                                        "Provide the recipient's information, such as their name and account details. Make sure the details are accurate."),
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
                          text: "Next",
                          borderRadius: 50,
                          onTap: () {
                            pushRoute(newContext, context);
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
