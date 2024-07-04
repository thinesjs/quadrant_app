// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quadrant_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/custom_textfield.dart';
import 'package:quadrant_app/pages/main_page.dart';
import 'package:quadrant_app/pages/screens/Orders/OrdersScreen.dart';
import 'package:quadrant_app/pages/screens/Profile/AddressesScreen.dart';
import 'package:quadrant_app/pages/screens/Profile/EditProfileScreen.dart';
import 'package:quadrant_app/pages/screens/Profile/NotificationScreen.dart';
import 'package:quadrant_app/pages/screens/Profile/SecurityScreen.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/QEntrySettings.dart';
import 'package:quadrant_app/pages/screens/Support/SupportScreen.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayHeight = MediaQuery.of(context).size.height;
    User user =
        context.select<AuthenticationBloc, User>((bloc) => bloc.state.user);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: displayHeight / 5.673,
            backgroundColor: isDark
                ? CustomColors.backgroundDark
                : CustomColors.backgroundLight,
            flexibleSpace: FlexibleSpaceBar(
              title: InvisibleExpandedHeader(
                  child: Text(
                "${context.select<AuthenticationBloc, String?>((bloc) => bloc.state.user.name)}",
                style: TextStyle(
                    color: isDark
                        ? CustomColors.textColorDark
                        : CustomColors.textColorLight),
              )),
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: displayHeight / 14),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://live.staticflickr.com/4475/37095348433_626859af3c_b.jpg'),
                            fit: BoxFit.fill,
                            opacity: .5),
                        color: Colors.black87),
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
                                InkWell(
                                  onTap: () => mainPageKey.currentState
                                      ?.switchToScreen(4),
                                  child: CircleAvatar(
                                    backgroundImage: (user.avatar != "")
                                        ? NetworkImage(user.avatar)
                                        : AssetImage(
                                                'assets/placeholders/placeholder-user.jpg')
                                            as ImageProvider<Object>,
                                  ),
                                ),
                                CircleActionButton(
                                  isDark: isDark,
                                  icon: Iconsax.notification,
                                  onTap: () {},
                                )
                              ],
                            ),
                          ),
                          Text(
                            "Hey, ${context.select<AuthenticationBloc, String?>((bloc) => bloc.state.user.name)} 👋🏽",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.textColorDark),
                          ),
                          Text(
                            "Keep your profile updated for the best experience!",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: CustomColors.textColorDark),
                          ),
                          SizedBox(
                            height: 24.7,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  color: isDark
                      ? CustomColors.backgroundDark
                      : CustomColors.backgroundLight),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                            color: isDark
                                ? CustomColors.cardColorDark
                                : CustomColors.cardColorLight,
                            borderRadius: BorderRadius.circular(
                                CustomPadding.tRoundEdgePadding)),
                        child: Column(
                          children: [
                            ProfileButton(
                                title: "Account",
                                caption: "Make changes to your account",
                                icon: Iconsax.user_edit,
                                onTap: () => {
                                      Navigator.push(
                                          context, EditProfileScreen.route())
                                    },
                                isDark: isDark),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: isDark
                                ? CustomColors.cardColorDark
                                : CustomColors.cardColorLight,
                            borderRadius: BorderRadius.circular(
                                CustomPadding.tRoundEdgePadding)),
                        child: Column(
                          children: [
                            ProfileButton(
                                title: "Orders",
                                caption: "Manage your orders and payments.",
                                icon: Iconsax.box,
                                onTap: () => {
                                      Navigator.push(
                                          context, OrdersScreen.route())
                                    },
                                isDark: isDark),
                            ProfileButton(
                                title: "Addresses",
                                caption: "Manage your profiles and addresses",
                                icon: Iconsax.location,
                                onTap: () => {
                                      Navigator.push(
                                          context, AddressesScreen.route())
                                    },
                                isDark: isDark),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                            color: isDark
                                ? CustomColors.cardColorDark
                                : CustomColors.cardColorLight,
                            borderRadius: BorderRadius.circular(
                                CustomPadding.tRoundEdgePadding)),
                        child: Column(
                          children: [
                            ProfileButton(
                                title: "Q-Entry",
                                caption: "Setup Quadrant's smart entrance",
                                icon: Iconsax.security_card,
                                onTap: () => {
                                      Navigator.push(
                                          context, QEntrySettingsScreen.route())
                                    },
                                isDark: isDark),
                            ProfileButton(
                                title: "Security",
                                caption: "Change your password and setup 2FA",
                                icon: Iconsax.security,
                                onTap: () => {
                                      Navigator.push(
                                          context, SecurityScreen.route())
                                    },
                                isDark: isDark),
                            ProfileButton(
                                title: "Notification",
                                caption: "Setup notification preferance",
                                icon: Iconsax.notification,
                                onTap: () => {
                                      Navigator.push(
                                          context, NotificationScreen.route())
                                    },
                                isDark: isDark),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                            color: isDark
                                ? CustomColors.cardColorDark
                                : CustomColors.cardColorLight,
                            borderRadius: BorderRadius.circular(
                                CustomPadding.tRoundEdgePadding)),
                        child: Column(
                          children: [
                            ProfileButton(
                                title: "Help & Support",
                                caption: "Talk to us for additional support",
                                icon: Iconsax.user_edit,
                                onTap: () => {
                                      Navigator.push(
                                          context, SupportScreen.route())
                                    },
                                isDark: isDark),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequested())
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade800),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (BuildContext context,
                          AsyncSnapshot<PackageInfo> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            '${snapshot.data!.appName} Version ${snapshot.data!.version} '
                            'Build: ${snapshot.data!.buildNumber}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color:
                                    isDark ? Colors.grey[700] : Colors.black26),
                          );
                        }
                        return Text('');
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.title,
    required this.caption,
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  final String title;
  final String caption;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(42)),
                  color: Colors.black.withOpacity(.3),
                ),
                child: Icon(icon,
                    color: isDark
                        ? CustomColors.componentColorDark
                        : CustomColors.componentColorLight),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                Text(
                  caption,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: isDark ? Colors.grey[200] : Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InvisibleExpandedHeader extends StatefulWidget {
  final Widget child;
  const InvisibleExpandedHeader({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  _InvisibleExpandedHeaderState createState() {
    return _InvisibleExpandedHeaderState();
  }
}

class _InvisibleExpandedHeaderState extends State<InvisibleExpandedHeader> {
  ScrollPosition? _position;
  bool? _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible ?? false,
      child: widget.child,
    );
  }
}
