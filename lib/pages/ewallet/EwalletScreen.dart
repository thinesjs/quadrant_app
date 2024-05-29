// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:quadrant_app/blocs/ewallet/bloc/ewallet_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/custom_textfield.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/ewallet/EwalletTransactionsScreen.dart';
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
            child: Stack(
              children: [
                Container(
                  height: displayHeight * 0.3 - 11,
                  padding: EdgeInsets.only(top: displayHeight / 14),
                  decoration: BoxDecoration(color: Colors.black87),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Your Balance",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.textColorDark),
                              ),
                              CircleActionButton(
                                isDark: isDark,
                                icon: Iconsax.notification,
                                onTap: () {},
                              )
                            ],
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
                                return Text(
                                  'RM',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.textColorDark),
                                );
                              case EwalletLoaded():
                                return Text(
                                  'RM ${state.wallet.balance?.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.textColorDark),
                                );
                              case EwalletError():
                                return const Text('Something went wrong!');
                              case EwalletInitial():
                                return const Center(child: Text("Loading"));
                              default:
                                return const Placeholder();
                            }
                          }),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context, EwalletTransactionsScreen.route()),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SideSectionText(
                                  isDark: isDark,
                                  text: "View Transactions",
                                  size: 16.0),
                              Icon(
                                Iconsax.arrow_right_3,
                                color: isDark
                                    ? CustomColors.primaryDark
                                    : CustomColors.primaryLight,
                                size: 16,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 70,
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: isDark
                            ? CustomColors.cardColorDark
                            : CustomColors.cardColorLight,
                        borderRadius: BorderRadius.all(
                            Radius.circular(CustomSizes.borderRadiusLg)),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.5)
                                : Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
