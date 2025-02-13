import 'package:http/http.dart';
import 'package:oru_phones_assignment/core/network/api_client.dart';
import 'package:oru_phones_assignment/core/network/api_endpoints.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<Response> checkLoggedIn(String session) async {
    return await _apiClient
        .get(APIEndpoints.isLoggedIn, headers: {"Cookie": session});
  }

  Future<Response> sendOtp(String countryCode, String mobileNumber) async {
    try {
      return await _apiClient.post(APIEndpoints.otpCreate, {
        "countryCode": int.parse(countryCode),
        "mobileNumber": int.parse(mobileNumber)
      });
    } catch (e) {
      return Response(
          {"success": 'FAILURE', "msg": "Invalid mobile number format."}
              .toString(),
          500);
    }
  }

  Future<Response> validateOtp(
      String countryCode, String mobileNumber, String otp) async {
    try {
      return await _apiClient.post(APIEndpoints.otpValidate, {
        "countryCode": int.parse(countryCode),
        "mobileNumber": int.parse(mobileNumber),
        "otp": int.parse(otp)
      });
    } catch (e) {
      return Response(
          {"success": 'FAILURE', "msg": "Invalid OTP format."}.toString(), 500);
    }
  }

  Future<Response> updateUserData(
      String name, String token, String session) async {
    return await _apiClient.post(
      APIEndpoints.updateUser,
      {"countryCode": 91, "userName": name},
      headers: {'X-Csrf-Token': token, "Cookie": session},
    );
  }

  Future<Response> logout(String token, String session) async {
    return await _apiClient.get(APIEndpoints.logout,
        headers: {'X-Csrf-Token': token, "Cookie": session});
  }
}
