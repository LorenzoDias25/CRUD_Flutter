import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

// ⬇️ Substitua este endpoint pelo seu link do CRUDCRUD aqui
const String baseUrl = 'https://crudcrud.com/api/8d98e026462546e692311d6f080739bf/users';

class UserService {
  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar usuários');
    }
  }

  static Future<void> createUser(User user) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
  }

  static Future<void> updateUser(User user) async {
    await http.put(
      Uri.parse('$baseUrl/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
  }

  static Future<void> deleteUser(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
