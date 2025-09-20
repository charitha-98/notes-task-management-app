import 'package:flutter/widgets.dart';
import 'package:note_sphere/models/todo_model.dart';

import 'package:note_sphere/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<ToDo> inCompletedTodos;
  const TodoTab({super.key, required this.inCompletedTodos});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.inCompletedTodos.length,
              itemBuilder: (context, index) {
                final ToDo todo = widget.inCompletedTodos[index];
                return TodoCard(todo: todo, isCompleted: false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
