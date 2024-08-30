import 'dart:convert';
import 'package:crudbloc/Model/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final String apiUrl = "https://66b4556a9f9169621ea27eef.mockapi.io/m";

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> addUser(User user) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add user');
    }
  }

  Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String userId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$userId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
