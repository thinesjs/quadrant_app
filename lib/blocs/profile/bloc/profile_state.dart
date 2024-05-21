part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<Message>? profiles;

  const ProfileLoaded({required this.profiles});

  @override
  List<Object> get props => [profiles!];
}

class ProfileError extends ProfileState {}

