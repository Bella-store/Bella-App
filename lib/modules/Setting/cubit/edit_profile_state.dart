part of 'edit_profile_cubit.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final UserModel user;

  EditProfileLoaded(this.user);
}

class EditProfileError extends EditProfileState {
  final String message;

  EditProfileError(this.message);
}
