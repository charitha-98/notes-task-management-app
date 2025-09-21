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

  Future<void> markAsDone(ToDo todo) async {
    try {
      //get all todos from the box
      final dynamic allTodos = await _myBox.get("todos");
      final int index = allTodos.indexWhere((element) => element.id == todo.id);
      allTodos[index] = todo;
      await _myBox.put("todos", allTodos);
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

  Future<void> addTodo(ToDo todo) async {
    try {
      final dynamic allTodos = await _myBox.get("todos");
      allTodos.add(todo);

      await _myBox.put("todos", allTodos);
    } catch (e) {
      print(e.toString());
    }
  }
}
