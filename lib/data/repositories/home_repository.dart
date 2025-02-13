import 'package:http/http.dart';
import 'package:oru_phones_assignment/core/network/api_client.dart';
import 'package:oru_phones_assignment/core/network/api_endpoints.dart';

class HomeRepository {
  final ApiClient _apiClient;
  HomeRepository(this._apiClient);

  Future<Response> fetchBrands() async {
    return await _apiClient.get(APIEndpoints.brandsImgs);
  }

  Future<Response> fetchProducts(String session) async {
    return await _apiClient.post(
      APIEndpoints.products,
      {"filter": {}},
      headers: {
        "Cookie": session,
        'Content-Type': 'application/json',
      },
    );
  }

  Future<Response> fetchFAQ() async {
    return await _apiClient.get(APIEndpoints.faq);
  }
}
