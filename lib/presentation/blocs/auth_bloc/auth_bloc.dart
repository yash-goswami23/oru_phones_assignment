import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/data/models/opt_validate.dart';
import 'package:oru_phones_assignment/data/models/otp_response.dart';
import 'package:oru_phones_assignment/data/models/user_logged_in_model.dart';
import 'package:oru_phones_assignment/data/repositories/auth_repository.dart';
import 'package:oru_phones_assignment/data/repositories/shared_prefs.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_screen.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepo;
  final SharedPrefs _sharedPrefs;

  AuthBloc(
    this._sharedPrefs,
    this._authRepo,
  ) : super(AuthInitial()) {
    on<IsLoggedInEvent>(_isLoggedInEvent);
    on<SendOtpEvent>(_sendOtpEvent);
    on<OtpValidateEvent>(_otpValidateEvent);
    on<UpdatedUserDataEvent>(_updatedUserData);
    on<LogoutEvent>(_logoutEvent);
  }
  OtpResponse? sendOtpResponse;
  UserLoggedIn? userLoggedIn;

  Future<void> _isLoggedInEvent(
      IsLoggedInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final session = await _sharedPrefs.fatch('session');
      final response = await _authRepo.checkLoggedIn(session!);

      final value = jsonDecode(response.body);
      print(
          'value : $value, session :${session} response is body: ${response.body} status code ${response.statusCode}');
      if (response.statusCode == 200) {
        userLoggedIn = UserLoggedIn.fromJson(value);
        if (userLoggedIn!.isLoggedIn) {
          await _sharedPrefs.save('token', userLoggedIn!.csrfToken!);
          emit(IsLoggedInAuthSuccess(userLoggedIn!));
        } else {
          emit(AuthFailure('user not Logged In'));
        }
      } else {
        emit(AuthFailure(value['error']));
      }
    } catch (e) {
      emit(AuthFailure("Login check failed: ${e.toString()}"));
    }
  }

  Future<void> _sendOtpEvent(
      SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _authRepo.sendOtp(event.countryCode, event.number);
      final value = jsonDecode(response.body);
      print(
          'value : $value, response is body: ${response.body} status code ${response.statusCode}');
      if (response.statusCode == 200) {
        sendOtpResponse = OtpResponse.fromJson(value);
        emit(SendOtpAuthSuccess(sendOtpResponse!));
      } else {
        final otpResponse = OtpResponse.fromJson(value);
        emit(AuthFailure(otpResponse.errors!.first.message));
      }
    } catch (e) {
      emit(AuthFailure("OTP sending failed: ${e.toString()}"));
    }
  }

  Future<void> _otpValidateEvent(
      OtpValidateEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _authRepo.validateOtp(
          event.countryCode, event.number, event.otp);
      final value = jsonDecode(response.body);
      print(
          'value : $value, response is body: ${response.body} status code ${response.statusCode}');
      if (response.statusCode == 200) {
        // Extract cookies from response headers
        String? rawCookie = response.headers['set-cookie'];
        String? sessionCookie;
        if (rawCookie != null) {
          sessionCookie = rawCookie.split(';')[0]; // Extract session ID
          print("value Session Cookie: $sessionCookie");
        }
        final saveDone =
            await _sharedPrefs.save('session', sessionCookie.toString());
        print("value Session save: $saveDone, value: $sessionCookie");
        final otpValidate = OtpValidate.fromJson(value);
        emit(OtpValidateAuthSuccess(otpValidate));
      } else {
        emit(AuthFailure(value['error']));
      }
    } catch (e) {
      emit(AuthFailure("OTP validation failed: ${e.toString()}"));
    }
  }

  Future<void> _updatedUserData(
      UpdatedUserDataEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await _sharedPrefs.fatch('token');
      final session = await _sharedPrefs.fatch('session');
      print('value starttoken : $token, session: $session}');

      final response =
          await _authRepo.updateUserData(event.name, token!, session!);
      final value = jsonDecode(response.body);
      print(
          'value start : $value, token : $token, session: $session, response is body: ${response.body} status code ${response.statusCode}');
      if (response.statusCode == 200) {
        emit(UserUpdatedAuthSuccess(
            value['reason'] ?? "User updated successfully"));
      } else {
        print(
            'value : else failure $value, token : $token, session: $session, response is body: ${response.body} status code ${response.statusCode}');

        emit(AuthFailure(value['message']));
      }
    } catch (e) {
      print('value : catch  $e,');

      emit(AuthFailure("User update failed: ${e.toString()}"));
    }
  }

  Future<void> _logoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await _sharedPrefs.fatch('token');
      final session = await _sharedPrefs.fatch('session');
      final response = await _authRepo.logout(token!, session!);
      final value = jsonDecode(response.body);
      print(
          'value : $value, token : $token, session: $session, response is body: ${response.body} status code ${response.statusCode}');
      if (response.statusCode == 200) {
        await _sharedPrefs.delete('token');
        await _sharedPrefs.delete('session');

        emit(LogoutAuthSuccess());
      } else {
        emit(AuthFailure(value['message']));
      }
    } catch (e) {
      emit(AuthFailure("User Logout failed: ${e.toString()}"));
    }
  }
}
