part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

class IsLoggedInAuthSuccess extends AuthState {
  final UserLoggedIn userLoggedIn;
  IsLoggedInAuthSuccess(this.userLoggedIn);
}

class SendOtpAuthSuccess extends AuthState {
  final OtpResponse otpResponse;
  SendOtpAuthSuccess(this.otpResponse);
}

class OtpValidateAuthSuccess extends AuthState {
  final OtpValidate otpValidate;
  OtpValidateAuthSuccess(this.otpValidate);
}

class UserUpdatedAuthSuccess extends AuthState {
  final String message;
  UserUpdatedAuthSuccess(this.message);
}

class LogoutAuthSuccess extends AuthState {}
