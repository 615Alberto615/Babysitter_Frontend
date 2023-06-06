import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final String apiUrl = "http://10.0.2.2:8080/api/v1/user";

  Future<Map<String, dynamic>> registerUser(
      Map<String, dynamic> userData, bool isBabysitter) async {
    final response = await http.post(
      Uri.parse(apiUrl + (isBabysitter ? "/babysitter/" : "/tutor/")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
  }
}
