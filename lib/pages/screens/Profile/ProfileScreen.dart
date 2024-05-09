// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/controllers/AuthController.dart';
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

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: 200,
            backgroundColor: isDark ? CustomColors.backgroundDark : CustomColors.backgroundLight,
            flexibleSpace: FlexibleSpaceBar(
              title: InvisibleExpandedHeader(child: Text("Kavilan Upadhya", style: TextStyle(color: isDark ? CustomColors.textColorDark : CustomColors.textColorLight),)),
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                          maxRadius: 50
                        ),
                  ),
                  const Text("Kavilan Upadhya",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  const Text("Tier 1 - 1080 points",
                    style: TextStyle(
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              decoration: BoxDecoration(color: isDark ? CustomColors.backgroundDark : CustomColors.backgroundLight),
              child: Center(
                  child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? CustomColors.cardColorDark:CustomColors.cardColorLight,
                          borderRadius: BorderRadius.circular(CustomPadding.tRoundEdgePadding)
                        ),
                        child: Column(
                          children: [
                            ProfileButton(
                              title: "Edit Profile", 
                              caption: "Make changes to your profile", 
                              icon: Iconsax.user_edit,
                              onTap: () => {}, 
                              isDark: isDark
                            ),
                            ProfileButton(
                              title: "Security", 
                              caption: "Change your password and setup 2FA", 
                              icon: Iconsax.security,
                              onTap: () => {}, 
                              isDark: isDark
                            ),
                            ProfileButton(
                              title: "Notification", 
                              caption: "Setup notification preferance", 
                              icon: Iconsax.notification,
                              onTap: () => {}, 
                              isDark: isDark
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? CustomColors.cardColorDark:CustomColors.cardColorLight,
                          borderRadius: BorderRadius.circular(CustomPadding.tRoundEdgePadding)
                        ),
                        child: Column(
                          children: [
                            ProfileButton(
                              title: "Help & Support", 
                              caption: "Talk to us for additional support", 
                              icon: Iconsax.user_edit,
                              onTap: () => {}, 
                              isDark: isDark
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {},
                      child: Text("Logout",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade800
                        ),
                      ),
                    ),
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
                child: Icon(icon, color: isDark ? CustomColors.componentColorDark : CustomColors.componentColorLight),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900
                      ),),
                  ],
                ),
                Text(caption,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: isDark ? Colors.grey[200] : Colors.black
                  ),
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
    bool visible = settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible?? false,
      child: widget.child,
    );
  }
}