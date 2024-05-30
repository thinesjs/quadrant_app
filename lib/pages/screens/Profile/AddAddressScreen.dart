import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/textfields.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddAddressScreen());
  }

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late GoogleMapController _controller;
  late PanelController _panelController;
  TextEditingController _searchController = TextEditingController();
  LocationAddress? _locationAddress;
  LatLng? _currentPosition;
  Marker? _marker;
  bool _loading = true;

  Future<void> _getUserLocation() async {
    // Request location permissions
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Get current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _loading = false;
      });
      _getAddressFromLatLng(_currentPosition!);
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _locationAddress = LocationAddress(
            line1: place.name ?? "Unknown",
            line2: place.locality ?? "Unknown",
            line3: '${place.administrativeArea}, ${place.country}',
          );
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng newPosition = LatLng(location.latitude, location.longitude);
        _controller.animateCamera(CameraUpdate.newLatLng(newPosition));
        setState(() {
          _currentPosition = newPosition;
        });
        _getAddressFromLatLng(newPosition);
      }
    } catch (e) {
      print(e);
    }
  }

  void _confirmLocation() {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    showBarModalBottomSheet(
      context: context,
      backgroundColor: isDark
          ? CustomColors.cardColorDark
          : CustomColors.cardColorLight,
      builder: (BuildContext context) {
        return Container(
          height: displayHeight * 0.65,
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionText(
                                  isDark: isDark,
                                  bold: true,
                                  size: 20,
                                  text: "Address Details"),
                              SideSectionText(
                                  isDark: isDark,
                                  text:
                                      "Complete address would assist better us in serving you"),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark
                                    ? CustomColors.borderDark
                                    : CustomColors.borderLight,
                                width: 1,
                              ),
                            ),
                            child: Icon(Icons.close,
                                color: isDark
                                    ? CustomColors.textColorDark
                                    : CustomColors.textColorLight),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: isDark
                        ? CustomColors.borderDark
                        : CustomColors.borderLight,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SideSectionText(
                            isDark: isDark, text: "Select Address Type", color: isDark ? CustomColors.textColorDark : CustomColors.textColorLight),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            AppOutlinedButton(isDark: isDark, text: "Home", onTap: () {}),
                            SizedBox(width: 10),
                            AppOutlinedButton(isDark: isDark, text: "Office", onTap: () {}),
                          ],
                        ),
                        AppTextField(
                            label: "Receiver's Name",
                            placeholder: "John Doe",
                            controller: TextEditingController(),
                            isDark: isDark),
                        AppTextField(
                            label: "Receiver's Phone",
                            placeholder: "+6 012 345 6789",
                            controller: TextEditingController(),
                            isDark: isDark),
                        SizedBox(height: 20),
                        AppFilledButton(
                            isDark: isDark, text: "Save Address", onTap: () {})
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: _loading
          ? Center(
              child: LoadingAnimationWidget.waveDots(
                  color: isDark
                      ? CustomColors.primaryLight
                      : CustomColors.textColorLight,
                  size: 24))
          : _currentPosition == null
              ? const Center(
                  child: ErrorComponent(
                      errorText:
                          "We're unable to retrieve your location, report to us this issue or try again some time later."),
                )
              : SlidingUpPanel(
                  controller: _panelController,
                  color: isDark
                      ? CustomColors.cardColorDark
                      : CustomColors.cardColorLight,
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? CustomColors.primaryLight.withOpacity(0.3)
                          : CustomColors.textColorLight.withOpacity(0.3),
                      blurRadius: 100,
                      spreadRadius: 10,
                    ),
                  ],
                  panel: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Center(
                            child: SideSectionText(
                                isDark: isDark,
                                color: isDark
                                    ? CustomColors.textColorDark
                                    : CustomColors.textColorLight,
                                text: "Drag & Drop The Pin To Your Location",
                                size: 16.0),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? CustomColors.primaryDark.withOpacity(0.8)
                                    : CustomColors.primaryDark.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(Iconsax.location,
                                  size: 20,
                                  color: isDark
                                      ? CustomColors.textColorDark
                                      : CustomColors.textColorLight),
                            ),
                            const SizedBox(width: 40),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SideSectionText(
                                    isDark: isDark,
                                    color: isDark
                                        ? CustomColors.textColorDark
                                        : CustomColors.textColorLight,
                                    bold: true,
                                    text: _locationAddress?.line1 ?? "",
                                    size: 16.0),
                                Text(_locationAddress?.line2 ?? ""),
                                Text(_locationAddress?.line3 ?? ""),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        AppFilledButton(
                            isDark: isDark,
                            text: "Confirm & Add Details",
                            onTap: () {
                              _confirmLocation();
                            })
                      ],
                    ),
                  ),
                  body: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _currentPosition!,
                          zoom: 17.0,
                        ),
                        myLocationEnabled: true,
                        markers: {
                          Marker(
                            markerId: const MarkerId('selected-location'),
                            position: _currentPosition!,
                            draggable: true,
                            icon: BitmapDescriptor.defaultMarker,
                            onDragStart: (LatLng newPosition) {
                              _panelController.close();
                            },
                            onDragEnd: (LatLng newPosition) {
                              setState(() {
                                _currentPosition = newPosition;
                              });
                              _getAddressFromLatLng(newPosition);
                              _panelController.open();
                            },
                          )
                        },
                        onMapCreated: (GoogleMapController controller) {
                          _controller = controller;
                        },
                      ),
                      Positioned(
                        top: 0.0, // Adjust the position as needed
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: isDark
                                ? CustomColors.navBarBackgroundDark
                                : CustomColors.navBarBackgroundLight,
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "Search Location",
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: isDark
                                    ? CustomColors.textColorDark
                                        .withOpacity(0.5)
                                    : CustomColors.textColorLight
                                        .withOpacity(0.5),
                              ),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(Iconsax.search_normal,
                                    color: isDark
                                        ? CustomColors.textColorDark
                                            .withOpacity(0.5)
                                        : CustomColors.textColorLight
                                            .withOpacity(0.5)),
                                onPressed: () {
                                  _searchLocation(_searchController.text);
                                  _panelController.open();
                                },
                              ),
                            ),
                            onSubmitted: (query) {
                              _searchLocation(query);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class ErrorComponent extends StatelessWidget {
  final String errorText;
  const ErrorComponent({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorText, textAlign: TextAlign.center),
            SizedBox(height: 20),
            CircleActionButton(
              isDark: isDark,
              icon: Iconsax.arrow_left,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ));
  }
}

class LocationAddress {
  final String line1;
  final String line2;
  final String line3;

  LocationAddress({
    required this.line1,
    required this.line2,
    required this.line3,
  });
}
