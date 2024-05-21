import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/blocs/profile/bloc/profile_bloc.dart';
import 'package:quadrant_app/pages/components/add_card.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/list_card.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/repositories/ProfileRepository/profile_repository.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
        child: ListView(
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
                    isDark: isDark, text: 'Addresses', size: 32.0, bold: true),
              ],
            ),
            SectionHelperText(
                isDark: isDark,
                text: 'Update and manage your shipping and billing addresses.'),
            AddCardComponent(
                isDark: isDark, text: "Add New Address", onTap: () {}),
            BlocProvider(
                create: (context) =>
                    ProfileBloc(profileRepository: _profileRepository)
                      ..add(FetchProfiles()),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    switch (state) {
                      case ProfileLoading():
                        return const Center(child: CircularProgressIndicator());
                      case ProfileLoaded():
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: state.profiles!.length,
                            itemBuilder: (context, index) {
                              final profile = state.profiles![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ListCardComponent(
                                  isDark: isDark,
                                  onTap: (val) {
                                    if(val) BlocProvider.of<ProfileBloc>(context).add(SetDefaultProfile(profile.id ?? ''));
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
                            });
                      case ProfileError():
                        return const Text('Something went wrong!');
                      case ProfileInitial():
                        return const Center(child: Text("Loading"));
                      default:
                        return const Placeholder();
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
