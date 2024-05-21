// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class ListCardComponent extends StatefulWidget {
  const ListCardComponent(
      {super.key,
      required this.isDark,
      required this.onTap,
      this.isDefault = false,
      required this.type, 
      required this.name, 
      required this.phone,
      required this.address1,
      required this.address2,
      this.address3,
      required this.zipcode,
      required this.city,
      required this.state,
      required this.country});

  final bool isDark;
  final String type;
  final String name;
  final String phone;
  final String address1;
  final String address2;
  final String? address3;
  final String zipcode;
  final String city;
  final String state;
  final String country;

  final void Function(bool) onTap;
  final bool isDefault;

  @override
  State<ListCardComponent> createState() => _ListCardComponentState();
}

class _ListCardComponentState extends State<ListCardComponent> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    // if (!widget.isLoading) widget.onTap();
    // widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        // onTapDown: _onTapDown,
        // onTapUp: _onTapUp,
        // onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          height: 220,
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: widget.isDark
                ? CustomColors.cardColorDark
                : CustomColors.cardColorLight,
            border: Border.all(
              color: widget.isDefault
                  ? CustomColors.primaryDark
                  : widget.isDark
                      ? CustomColors.outlinedButtonColorDark
                      : CustomColors.outlinedButtonColorLight,
              width: 1,
            ),
            boxShadow: widget.isDefault
                ? [
                    BoxShadow(
                      color: CustomColors.primaryDark.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0,
                          0), // changes position of shadowchanges position of shadow
                    ),
                  ]
                : [],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Iconsax.location,
                          color: widget.isDark ? Colors.white : Colors.black87,
                          size: 20),
                      SizedBox(width: 10),
                      Text(
                        widget.type,
                        style: TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                        side: BorderSide(
                          color: widget.isDark ? Colors.white : Colors.black87,
                        ),
                        checkColor: Colors.white,
                        value: widget.isDefault,
                        onChanged: (val)=>widget.onTap(val!)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.name, style: TextStyle(fontSize: 13)),
              Text(widget.address1, style: TextStyle(fontSize: 13)),
              Text(widget.address2, style: TextStyle(fontSize: 13)),
              if (widget.address3 != null)
                Text(widget.address3 ?? "", style: TextStyle(fontSize: 13)),
              Text("${widget.city}, ${widget.state}" ?? "", style: TextStyle(fontSize: 13)),
              Text(widget.country, style: TextStyle(fontSize: 13)),
              SizedBox(height: 10),
              Text(widget.phone, style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
