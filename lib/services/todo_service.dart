import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_sphere/models/todo_model.dart';

class TodoService {
  List<ToDo> todos = [
    ToDo(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    ToDo(
      title: "Go for a Walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    ToDo(
      title: "Complete Assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];

  final _myBox = Hive.box("todos");

  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  Future<void> createInitialTodos() async {
    if (_myBox.isEmpty) {
      await _myBox.put("todos", todos);
    }
  }

  Future<List<ToDo>> loadTodos() async {
    final dynamic todos = await _myBox.get("todos");

    if (todos != null || todos is List<dynamic>) {
      return todos.cast<ToDo>().toList();
    }
    return [];
  }
}
