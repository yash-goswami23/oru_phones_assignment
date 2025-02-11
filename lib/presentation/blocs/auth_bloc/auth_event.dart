part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class IsLoggedInEvent extends AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String number;
  final String countryCode;
  SendOtpEvent(this.countryCode, this.number);
}

class OtpValidateEvent extends AuthEvent {
  final String countryCode;
  final String number;
  final String otp;
  OtpValidateEvent(this.countryCode, this.number, this.otp);
}

class UpdatedUserDataEvent extends AuthEvent {
  final String name;
  UpdatedUserDataEvent(this.name);
}

class LogoutEvent extends AuthEvent {}
