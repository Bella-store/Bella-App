part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LogingLoadingState extends AuthState {}

class LogingSuccessState extends AuthState {
  final UserModel userModel;
  LogingSuccessState(this.userModel);
}

class LogingErrorState extends AuthState {
  final String error;
  LogingErrorState(this.error);
}

class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {
  final UserModel userModel;
  SignUpSuccessState(this.userModel);
}

class SignUpErrorState extends AuthState {
  final String error;
  SignUpErrorState(this.error);
}
