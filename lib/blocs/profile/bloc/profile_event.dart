part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class FetchProfiles extends ProfileEvent {
  @override
  List<Object> get props => [];
}

final class SetDefaultProfile extends ProfileEvent {
  final String profileId;

  const SetDefaultProfile(this.profileId);

  @override
  List<Object> get props => [profileId];
}

final class AddProfile extends ProfileEvent {
  final String profileType;
  final String name;
  final String phone;
  final LocationAddress address;

  const AddProfile(this.profileType, this.name, this.phone, this.address);

  @override
  List<Object> get props => [profileType, name, phone, address];
}
