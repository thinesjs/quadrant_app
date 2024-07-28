import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/fcm/bloc/fcm_bloc.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/repositories/AuthRepository/auth_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:text_scroll/text_scroll.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static Route<void> route() {
    return CupertinoPageRoute<void>(builder: (_) => const NotificationScreen());
  }

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
      child: ListView(
        physics: const ClampingScrollPhysics(),
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
                  isDark: isDark, text: 'Notification', size: 32.0, bold: true),
            ],
          ),
          SectionHelperText(
              isDark: isDark,
              text:
                  'Customize your notification preferences and stay updated your way.'),
          BlocProvider(
            create: (context) => FcmBloc(
                authenticationRepository:
                    AuthenticationRepository(DioManager.instance))..add(const FetchFcmStatus()),
            child: BlocBuilder<FcmBloc, FcmState>(
              builder: (context, state) {
                if (state is FcmTokenStatusLoaded){
                  return NotificationSetting(
                    title: 'Push Notifications',
                    helperText:
                        'Receive push notifications for new messages, updates, and more.',
                    value: state.status,
                    onChanged: (value) {
                      context.read<FcmBloc>().add(UpdateFcmTokenStatus(currentStatus: state.status));
                    },
                  );
                }else if (state is FcmLoading){
                  return Center(
                    child: LoadingAnimationWidget.waveDots(
                        color: isDark
                            ? CustomColors.primaryLight
                            : CustomColors.textColorLight,
                        size: 24),
                  );
                }else{
                  return const Text("An error occurred. Please try again later.");
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class NotificationSetting extends StatelessWidget {
  final String title;
  final String helperText;
  final bool value;
  final ValueChanged<bool> onChanged;

  NotificationSetting({
    required this.title,
    required this.helperText,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                TextScroll(
                  helperText,
                  pauseBetween: const Duration(milliseconds: 3000),
                  delayBefore: const Duration(milliseconds: 1500),
                  style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
