import 'dart:developer';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/ewallet/bloc/ewallet_bloc.dart';
import 'package:quadrant_app/blocs/profile/bloc/profile_bloc.dart';
import 'package:quadrant_app/pages/components/add_card.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/list_card.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Profile/AddAddressScreen.dart';
import 'package:quadrant_app/repositories/EwalletRepository/ewallet_repository.dart';
import 'package:quadrant_app/repositories/ProfileRepository/profile_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class EwalletTransactionsScreen extends StatefulWidget {
  const EwalletTransactionsScreen({super.key});

  static Route<void> route() {
    return CupertinoPageRoute<void>(
        builder: (_) => const EwalletTransactionsScreen());
  }

  @override
  State<EwalletTransactionsScreen> createState() => _EwalletTransactionsScreenState();
}

class _EwalletTransactionsScreenState extends State<EwalletTransactionsScreen> {
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
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
        create: (context) => EwalletBloc(ewalletRepository: _ewalletRepository)
          ..add(FetchWalletTransaction()),
        child: Padding(
          padding: EdgeInsets.only(top: displayHeight * 0.084, left: 20, right: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      text: 'Transactions',
                      size: 32.0,
                      bold: true),
                ],
              ),
              SectionHelperText(
                  isDark: isDark,
                  text:'View your e-wallet transaction history.'),
              Expanded(
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
                        if (state.transactions.transactions?.isNotEmpty ?? false) {
                          return FadingEdgeScrollView.fromScrollView(
                            child: ListView.builder(
                              itemCount: state.transactions.transactions!.length,
                              shrinkWrap: true,
                              controller: ScrollController(),
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final transaction = state.transactions.transactions?[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? CustomColors.backgroundDark
                                        : CustomColors.backgroundLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      transaction?.transactionType == 'CREDIT'
                                          ? Iconsax.money_recive
                                          : Iconsax.money_send,
                                      color: transaction?.transactionType == 'CREDIT'
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    title: Text(
                                      transaction?.description ?? '',
                                      style: TextStyle(
                                        color: isDark
                                            ? CustomColors.textColorDark
                                            : CustomColors.textColorLight,
                                      ),
                                    ),
                                    subtitle: Text(
                                      transaction?.createdAt != null ? formatDate(transaction!.createdAt!) : '',
                                      style: TextStyle(
                                        color: isDark
                                            ? CustomColors.textColorDark
                                            : CustomColors.textColorLight,
                                      ),
                                    ),
                                    trailing: Text(
                                      '${transaction?.transactionType == 'CREDIT' ? '+':'-' }RM ${transaction?.amount?.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: isDark
                                            ? CustomColors.textColorDark
                                            : CustomColors.textColorLight,
                                      ),
                                    ),
                                  )
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text('No transactions found');
                        }
                      case EwalletError():
                        return const Text('No transactions found');
                      default:
                        return Container();
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
