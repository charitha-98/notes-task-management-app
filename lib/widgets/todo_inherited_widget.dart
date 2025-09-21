import 'package:flutter/widgets.dart';
import 'package:note_sphere/models/todo_model.dart';

class TodoData extends InheritedWidget {
  final List<ToDo> todos;
  final Function(List<ToDo>) onTodoChanged;

  const TodoData({
    super.key,
    required super.child,
    required this.todos,
    required this.onTodoChanged,
  });

  static TodoData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoData>();
  }

  @override
  bool updateShouldNotify(covariant TodoData oldWidget) {
    return todos != oldWidget.todos;
  }
}
