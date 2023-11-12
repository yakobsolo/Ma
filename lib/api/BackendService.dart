import 'package:http/http.dart' as http;

class BackendService {
  final String baseUrl = "https://maleda-backend.onrender.com";

  Future<http.Response> fetchData() async {
    final response = await http.get(Uri.parse("$baseUrl/products"));
    return response;
  }
}
