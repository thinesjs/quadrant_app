import 'dart:developer';

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/profile/bloc/profile_bloc.dart';
import 'package:quadrant_app/pages/components/add_card.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/list_card.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Profile/AddAddressScreen.dart';
import 'package:quadrant_app/repositories/ProfileRepository/profile_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddressesScreen());
  }

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  late final ProfileRepository _profileRepository;

  @override
  void initState() {
    super.initState();
    _profileRepository = ProfileRepository(DioManager.instance);
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProfileBloc(profileRepository: _profileRepository)
          ..add(FetchProfiles()),
        child: Padding(
          padding: EdgeInsets.only(top: displayHeight * 0.084, left: 20, right: 19),
          child: Column(
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
                      text: 'Addresses',
                      size: 32.0,
                      bold: true),
                ],
              ),
              SectionHelperText(
                  isDark: isDark,
                  text:
                      'Update and manage your shipping and billing addresses.'),
              AddCardComponent(
                        isDark: isDark,
                        text: "Add New Address",
                        onTap: () {
                          Navigator.push(
                                  context, AddAddressScreen.route())
                              .then((returnedData) {
                            context
                                .read<ProfileBloc>()
                                .add(FetchProfiles());
                          });
                        }),
              Expanded(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    switch (state) {
                      case ProfileLoading():
                        return Center(
                          child: LoadingAnimationWidget.waveDots(
                              color: isDark
                                  ? CustomColors.primaryLight
                                  : CustomColors.textColorLight,
                              size: 24),
                        );
                      case ProfileLoaded():
                        return FadingEdgeScrollView.fromScrollView(
                          child: ListView.builder(
                              controller: ScrollController(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.profiles!.length,
                              itemBuilder: (context, index) {
                                final profile = state.profiles![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: ListCardComponent(
                                    isDark: isDark,
                                    onTap: (val) {
                                      if (val) {
                                        context.read<ProfileBloc>().add(
                                            SetDefaultProfile(profile.id!));
                                      }
                                    },
                                    type: profile.type ?? '',
                                    name: profile.name ?? '',
                                    phone: profile.phone ?? '',
                                    address1: profile.address1 ?? '',
                                    address2: profile.address2 ?? '',
                                    address3: profile.address3,
                                    zipcode: profile.zipcode ?? '',
                                    city: profile.city ?? '',
                                    state: profile.state ?? '',
                                    country: profile.country ?? '',
                                    isDefault: profile.isDefault ?? false,
                                  ),
                                );
                              }),
                        );
                      case ProfileError():
                        return const Text('Something went wrong!');
                      case ProfileInitial():
                        return const Center(child: Text("Loading"));
                      default:
                        return const Placeholder();
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
