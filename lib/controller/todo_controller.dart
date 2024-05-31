import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:les_48/model/todo.dart';

class TodoController {
  final String baseUrl =
      'https://todoapp-b60e8-default-rtdb.europe-west1.firebasedatabase.app/Todo.json';

  Future<List<Todo>> fetchData() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      if (response.body == 'null') {
        return [];
      }
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<Todo> todos = [];
      data.forEach((key, value) {
        final todo = Todo.fromJson(value);
        todo.id = key; // Store the key as the id
        todos.add(todo);
      });
      return todos;
    } else {
      throw Exception("Failed loading data");
    }
  }

  Future<void> addTodoToFirebase(Todo todo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed adding todo");
    }
  }

  Future<void> updateTodoInFirebase(String id, Todo todo) async {
    final response = await http.patch(
      Uri.parse(
          'https://todoapp-b60e8-default-rtdb.europe-west1.firebasedatabase.app/Todo/$id.json'),
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed updating todo");
    }
  }

  Future<void> deleteTodoFromFirebase(String id) async {
    final response = await http.delete(
      Uri.parse(
          'https://todoapp-b60e8-default-rtdb.europe-west1.firebasedatabase.app/Todo/$id.json'),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed deleting todo");
    }
  }
}
