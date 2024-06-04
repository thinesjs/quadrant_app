import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/pages/screens/Profile/AddAddressScreen.dart';
import 'package:quadrant_app/repositories/ProfileRepository/models/response.dart';
import 'package:quadrant_app/repositories/ProfileRepository/profile_repository.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileRepository profileRepository,
  })  : _profileRepository = profileRepository,
        super(ProfileLoading()) {
    on<FetchProfiles>(_onGetProfiles);
    on<SetDefaultProfile>(_onSetDefaultProfiles);
    on<AddProfile>(_onAddProfile);
  }

  final ProfileRepository _profileRepository;

  Future<void> _onGetProfiles(
    FetchProfiles event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final response = await _profileRepository.fetchProfiles();
      emit(ProfileLoaded(profiles: response));
    } catch (_) {
      emit(ProfileError());
    }
  }

  Future<void> _onSetDefaultProfiles(
    SetDefaultProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final success = await _profileRepository.setDefaultProfile(event.profileId);

      if(success){
        final response = await _profileRepository.fetchProfiles();
        emit(ProfileLoaded(profiles: response));
      }

     
    } catch (_) {
      emit(ProfileError());
    }
  }

  Future<void> _onAddProfile(
    AddProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final success = await _profileRepository.addProfile(event.profileType, event.name, event.phone, event.address);
      if(success){
        add(FetchProfiles());
      }
    } catch (_) {
      emit(ProfileError());
    }
  }
}
