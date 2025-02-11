import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient(this.baseUrl);

  Future<http.Response> post(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    // try {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers ??
          {
            'Content-Type': 'application/json',
          },
      body: jsonEncode(data),
    );
    return response;
    //   return _handleResponse(response);
    // } catch (e) {
    //   return {'error': 'Network error: ${e.toString()}'};
    // }
  }

  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    // try {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers ?? {'Content-Type': 'application/json'},
    );

    return response;
    // } catch (e) {
    //   return {'error': 'Network error: ${e.toString()}'};
    // }
  }

  // Map<String, dynamic> _handleResponse(http.Response response) {
  //   final responseData = jsonDecode(response.body);
  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return responseData;
  //   } else {
  //     return {'error': responseData['message'] ?? 'Unknown error'};
  //   }
  // }
}
