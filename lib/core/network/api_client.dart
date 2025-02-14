import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final Duration timeoutDuration = Duration(seconds: 10); // Request timeout

  ApiClient(this.baseUrl);

  Future<http.Response> post(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl$endpoint'),
            headers: headers ?? {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(timeoutDuration);
      print('response api client : ${response.statusCode}, ${response.body}');
      return response;
      // return _handleResponse(response);
    } on SocketException {
      return _customErrorResponse("No internet connection.");
    } on TimeoutException {
      return _customErrorResponse("Request to $endpoint timed out.");
    } on http.ClientException catch (e) {
      return _customErrorResponse("Client Exception: ${e.toString()}");
    } catch (e) {
      return _customErrorResponse("Unexpected error: ${e.toString()}");
    }
  }

  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl$endpoint'),
            headers: headers ?? {'Content-Type': 'application/json'},
          )
          .timeout(timeoutDuration);
      print('response api client : ${response.statusCode}, ${response.body}');
      return response;
    } on SocketException {
      return _customErrorResponse("No internet connection.");
    } on TimeoutException {
      return _customErrorResponse("Request to $endpoint timed out.");
    } on http.ClientException catch (e) {
      return _customErrorResponse("Client Exception: ${e.toString()}");
    } catch (e) {
      return _customErrorResponse("Unexpected error: ${e.toString()}");
    }
  }

//   // Custom response handler
//   Map<String, dynamic> _handleResponse(http.Response response) {
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       print('response api client : ${response.statusCode}, ${response.body}');
//       String? rawCookie = response.headers['set-cookie'];
//       String? sessionCookie;
//       if (rawCookie != null) {
//         sessionCookie = rawCookie.split(';')[0]; // Extract session ID
//         // // print("value Session Cookie: $sessionCookie");
//       }print('response api client session cookie $sessionCookie');

//       if (sessionCookie != null) {
//  print('response api client session cookie ${jsonDecode(response.body)}');
//       return jsonDecode(response.body);
//       }else{
//          print('response api client session cookie ${jsonDecode(response.body)}');
//       return jsonDecode(response.body);
//       }

//     } else {
//       return {
//         "status": 'FAILURE',
//         "msg":
//             "Server error: ${response.statusCode} - ${response.reasonPhrase}",
//         "statusCode": response.statusCode,
//       };
//     }
//   }

//   // Custom error response when an exception occurs
  http.Response _customErrorResponse(String message) {
    String body = {"status": 'FAILURE', "msg": message}.toString();
    return http.Response(body, 500);
  }
}
