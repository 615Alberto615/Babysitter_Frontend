import 'dart:convert';
import 'package:front/models/modelo_token.dart';
import 'package:http/http.dart' as http;

import '../models/modelo_child.dart';

class ChildService {
  String? token = ModeloToken.token;
  Future<http.Response> createChild(
      String apiUrl, Map<String, dynamic> requestBody) async {
    var body = json.encode(requestBody);
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    return response;
  }

  Future<List<Child>> fetchChildren(String apiUrl, String parentId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl$parentId'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Si el servidor devuelve una respuesta OK, entonces parseamos el JSON.
        var data = json.decode(response.body);
        List<dynamic> jsonResponse =
            data['data']; // 'data' es la clave de la lista en la respuesta
        if (jsonResponse != null) {
          return jsonResponse.map((item) => Child.fromJson(item)).toList();
        } else {
          // manejar la situación cuando 'data' es null
          print('Error: el campo "data" es null');
          return [];
        }
      } else {
        // Si la respuesta no es OK, lanzamos un error.
        print(
            'Error: la respuesta del servidor no es 200 OK, es ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // manejar cualquier excepción lanzada durante la solicitud de red
      print('Error: se produjo una excepción durante la solicitud de red: $e');
      return [];
    }
  }

  Future<http.Response> deleteChild(String apiUrl, String childId) async {
    var response = await http.delete(
      Uri.parse('$apiUrl$childId'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  Future<http.Response> updateChild(
      String apiUrl, String childId, Map<String, dynamic> requestBody) async {
    var body = json.encode(requestBody);
    var response = await http.put(
      Uri.parse('$apiUrl$childId'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    return response;
  }
}
