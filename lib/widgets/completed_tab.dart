import 'package:flutter/widgets.dart';
import 'package:note_sphere/models/todo_model.dart';

class CompletedTab extends StatefulWidget {
  final List<ToDo> completedTodos;
  const CompletedTab({super.key, required this.completedTodos});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Completed Tab"));
  }
}
