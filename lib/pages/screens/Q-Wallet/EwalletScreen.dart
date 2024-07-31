// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/ewallet/bloc/ewallet_bloc.dart';
import 'package:quadrant_app/pages/components/floating_sheet.dart';
import 'package:quadrant_app/pages/components/material_sheet.dart';
import 'package:quadrant_app/pages/components/quick_actions_widget.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Checkout/GatewayWebviewScreen.dart';
import 'package:quadrant_app/pages/screens/Q-Wallet/EwalletScan.dart';
import 'package:quadrant_app/pages/screens/Q-Wallet/EwalletTransactionsScreen.dart';
import 'package:quadrant_app/pages/screens/Q-Wallet/PinRegisterModal/PinRegisterModal.dart';
import 'package:quadrant_app/pages/screens/Q-Wallet/ReloadModal/ReloadModal.dart';
import 'package:quadrant_app/pages/screens/Q-Wallet/TransferModal/TransferModal.dart';
import 'package:quadrant_app/repositories/EwalletRepository/ewallet_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:intl/intl.dart';

class EwalletScreen extends StatefulWidget {
  const EwalletScreen({super.key});

  @override
  State<EwalletScreen> createState() => _EwalletScreenState();
}

class _EwalletScreenState extends State<EwalletScreen> {
  late final EwalletRepository _ewalletRepository;

  @override
  void initState() {
    super.initState();
    _ewalletRepository = EwalletRepository(DioManager.instance);
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('MMM d, yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => EwalletBloc(ewalletRepository: _ewalletRepository)..add(FetchWallet()),
      child: BlocConsumer<EwalletBloc, EwalletState>(
        listener: (context, state) {
          if (state is EwalletLoaded){
            if(state.wallet.new_user == true){
              Navigator.of(context).push(
                FloatingSheetRoute(
                  builder: (BuildContext context) => const PinRegisterModal1(), barrierDismissible: false
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Material(
            child: Scaffold(
              body: CupertinoPageScaffold(
                child: Container(
                  padding: EdgeInsets.only(top: displayHeight / 14),
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
                              SvgPicture.asset("assets/logos/q-wallet-logo.svg",
                                  height: displayHeight / 20,
                                  colorFilter: ColorFilter.mode(
                                      isDark ? Colors.white : Colors.black,
                                      BlendMode.srcIn)),
                              // Icon(
                              //   Iconsax.setting_4,
                              //   color: isDark
                              //       ? CustomColors.textColorDark
                              //       : CustomColors.textColorLight,
                              //   size: 30,
                              // )
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
                                          color: isDark
                                              ? CustomColors.textColorDark
                                              : CustomColors.textColorLight),
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
                                  'RM ${state.wallet.data?.balance?.toStringAsFixed(2)}',
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
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 2.0),
                              child: SectionText(
                                  isDark: isDark,
                                  text: "Quick Actions",
                                  size: 20.0,
                                  bold: true),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                QuickActionsWidget(
                                  text: 'Reload',
                                  icon: Iconsax.wallet_add_1,
                                  onTap: () async {
                                    final redirectUrl =
                                        await Navigator.of(context).push(
                                      FloatingSheetRoute(
                                          builder: (BuildContext context) =>
                                              const ReloadModel1()),
                                    );
                                    if (!context.mounted) return;
                                    if (redirectUrl != null) {
                                      final status = await Navigator.of(context)
                                          .push(MaterialSheetRoute(
                                        builder: (context) =>
                                            PaymentWebViewScreen(
                                                url: redirectUrl!),
                                      ));
                                      if (!context.mounted) return;
                                      if (status != null) {
                                        if (status) {
                                          context
                                              .read<EwalletBloc>()
                                              .add(FetchWallet());
                                        }
                                      }
                                    }
                                  },
                                ).animate().fade(),
                                QuickActionsWidget(
                                  text: 'Scan',
                                  icon: Iconsax.scanner,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialSheetRoute<void>(
                                        builder: (BuildContext context) =>
                                            const EwalletScanner(),
                                      ),
                                    );
                                  },
                                ),
                                QuickActionsWidget(
                                  text: 'Transfer',
                                  icon: Iconsax.send_2,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      FloatingSheetRoute<void>(
                                        builder: (BuildContext context) =>
                                            const TransferModal1(),
                                      ),
                                    );
                                  },
                                ),
                              ]
                                  .animate(interval: .5.milliseconds)
                                  .fade()
                                  .slideY(begin: -0.2),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SectionText(
                                  isDark: isDark,
                                  text: "Transactions",
                                  size: 20.0,
                                  bold: true),
                              SideSectionText(
                                  isDark: isDark,
                                  text: "See all",
                                  size: 16.0,
                                  onTap: () => Navigator.push(context,
                                      EwalletTransactionsScreen.route())),
                            ],
                          ),
                        ),
                        BlocProvider(
                          create: (context) => EwalletBloc(
                              ewalletRepository:
                                  EwalletRepository(DioManager.instance))
                            ..add(FetchWalletTransaction()),
                          child: BlocBuilder<EwalletBloc, EwalletState>(
                            builder: (context, state) {
                              switch (state) {
                                case EwalletLoading():
                                  return Center(
                                    child: LoadingAnimationWidget.waveDots(
                                        color: isDark
                                            ? CustomColors.textColorDark
                                            : CustomColors.textColorLight,
                                        size: 24),
                                  );
                                case EwalletTransactionsLoaded():
                                  if (state.transactions.transactions
                                          ?.isNotEmpty ??
                                      false) {
                                    return Expanded(
                                      child:
                                          FadingEdgeScrollView.fromScrollView(
                                        child: ListView.builder(
                                          itemCount: (state.transactions
                                                      .transactions!.length >=
                                                  10)
                                              ? 5
                                              : state.transactions.transactions
                                                  ?.length,
                                          shrinkWrap: true,
                                          controller: ScrollController(),
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            final transaction = state
                                                .transactions
                                                .transactions?[index];
                                            return Container(
                                                decoration: BoxDecoration(
                                                  color: isDark
                                                      ? CustomColors
                                                          .backgroundDark
                                                      : CustomColors
                                                          .backgroundLight,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ListTile(
                                                  leading: Icon(
                                                    transaction?.transactionType ==
                                                            'CREDIT'
                                                        ? Iconsax.money_recive
                                                        : Iconsax.money_send,
                                                    color: transaction
                                                                ?.transactionType ==
                                                            'CREDIT'
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                  title: Text(
                                                    transaction?.description ??
                                                        '',
                                                    style: TextStyle(
                                                      color: isDark
                                                          ? CustomColors
                                                              .textColorDark
                                                          : CustomColors
                                                              .textColorLight,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    transaction?.createdAt !=
                                                            null
                                                        ? formatDate(
                                                            transaction!
                                                                .createdAt!)
                                                        : '',
                                                    style: TextStyle(
                                                      color: isDark
                                                          ? CustomColors
                                                              .textColorDark
                                                          : CustomColors
                                                              .textColorLight,
                                                    ),
                                                  ),
                                                  trailing: Text(
                                                    '${transaction?.transactionType == 'CREDIT' ? '+' : '-'}RM ${transaction?.amount?.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      color: isDark
                                                          ? CustomColors
                                                              .textColorDark
                                                          : CustomColors
                                                              .textColorLight,
                                                    ),
                                                  ),
                                                ));
                                          },
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const Text('No transactions found');
                                  }
                                case EwalletError():
                                  return const Text('Something went wrong!');
                                default:
                                  return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
