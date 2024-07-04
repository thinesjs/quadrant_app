// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:quadrant_app/blocs/ewallet/bloc/ewallet_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/custom_textfield.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Q-Wallet/EwalletTransactionsScreen.dart';
import 'package:quadrant_app/repositories/EwalletRepository/ewallet_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class EwalletScreen extends StatefulWidget {
  const EwalletScreen({super.key});

  @override
  State<EwalletScreen> createState() => _EwalletScreenState();
}

class _EwalletScreenState extends State<EwalletScreen> {
  late final EwalletRepository _ewalletRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ewalletRepository = EwalletRepository(DioManager.instance);
  }

  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: displayHeight * 0.32,
            child: Container(
              padding: EdgeInsets.only(top: displayHeight / 14),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            "assets/logos/q-wallet-logo.svg", 
                            height: displayHeight / 20,
                            colorFilter: ColorFilter.mode(isDark ? Colors.white : Colors.black, BlendMode.srcIn)
                          ),
                          CircleActionButton(
                            isDark: isDark,
                            icon: Iconsax.setting,
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Total Balance",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ),
                    BlocProvider(
                      create: (context) =>
                          EwalletBloc(ewalletRepository: _ewalletRepository)
                            ..add(FetchWallet()),
                      child: BlocBuilder<EwalletBloc, EwalletState>(
                          builder: (ctx, state) {
                        switch (state) {
                          case EwalletLoading():
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'RM',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.textColorDark),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                LoadingAnimationWidget.waveDots(
                                    color: isDark
                                        ? CustomColors.textColorDark
                                        : CustomColors.textColorLight,
                                    size: 24)
                              ],
                            );
                          case EwalletLoaded():
                            return Text(
                              'RM ${state.wallet.balance?.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ).animate().fade().slide();
                          case EwalletError():
                            return const Text('Something went wrong!');
                          case EwalletInitial():
                            return const Center(child: Text("Loading"));
                          default:
                            return const Placeholder();
                        }
                      }),
                    ),
                    Row(
                      children: [
                        Container()

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SectionText(isDark: isDark, text: "Transactions", size: 20.0, bold: true),
                          SideSectionText(isDark: isDark, text: "See all", size: 16.0, onTap: () => Navigator.push(context, EwalletTransactionsScreen.route())),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
