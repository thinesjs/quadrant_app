import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:sheet/sheet.dart';

class ReloadModal1 extends StatelessWidget {
  const ReloadModal1({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.transparent,
      child: SheetMediaQuery(
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
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
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
                                      renderCache: RenderCache.raster
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Transfer",
                                style: TextStyle(
                                  color: !isDark ? CustomColors.textColorDark : CustomColors.textColorLight,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Understanding the Money Transfer Process",
                                style: TextStyle(
                                  color: !isDark ? CustomColors.subTextColorDark : CustomColors.subTextColorLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
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
                height: displayHeight / 2,
                child: FadingEdgeScrollView.fromSingleChildScrollView(
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 25 , 25, 12),
                          child: TitleTextWidget(text: "Entering Recipient Details"),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 0 , 25, 12),
                          child: SubtitleTextWidget(text: "Provide the recipient's information, such as their name and account details. Make sure the details are accurate."),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 12 , 25, 12),
                          child: TitleTextWidget(text: "Specify the Amount"),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 0 , 25, 12),
                          child: SubtitleTextWidget(text: "Enter the amount you wish to transfer. Ensure it is within your transfer limits."),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 12 , 25, 12),
                          child: TitleTextWidget(text: "Choose a Transfer Method"),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 0 , 25, 12),
                          child: SubtitleTextWidget(text: "Select your preferred transfer method. Options may include bank transfer, mobile number, or email."),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 12 , 25, 12),
                          child: TitleTextWidget(text: "Review and Confirm"),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 0 , 25, 12),
                          child: SubtitleTextWidget(text: "Check all the entered details and the transfer amount. Make sure everything is correct before proceeding."),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 12 , 25, 12),
                          child: TitleTextWidget(text: "Complete the Transfer"),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 0 , 25, 12),
                          child: SubtitleTextWidget(text: "Confirm the transfer to complete the transaction."),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 12 , 25, 12),
                          child: SubtitleTextWidget(text: "Ready to transfer money? Tap “Got It” to continue."),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 12 , 25, 12),
                child: AppFilledButton(isDark: isDark, text: "Got It", borderRadius: 50, onTap: () {}),
              )
            ],
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
        color: isDark ? CustomColors.subTextColorDark.withOpacity(0.8) : CustomColors.subTextColorLight.withOpacity(0.8),
        fontWeight: FontWeight.normal
      ),
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
        color: isDark ? CustomColors.textColorDark : CustomColors.textColorLight,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
