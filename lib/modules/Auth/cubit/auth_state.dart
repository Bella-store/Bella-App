part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LogingLoadingState extends AuthState {}

class LogingSuccessState extends AuthState {}

class LogingErrorState extends AuthState {
  final String error;
  LogingErrorState(this.error);
}

class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpErrorState extends AuthState {
  final String error;
  SignUpErrorState(this.error);
}
