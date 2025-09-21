import 'package:flutter/widgets.dart';
import 'package:note_sphere/helpers/snackbar.dart';

import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utills/router.dart';

import 'package:note_sphere/widgets/todo_card.dart';

class CompletedTab extends StatefulWidget {
  final List<ToDo> completedTodos;
  final List<ToDo> inCompletedTodos;
  const CompletedTab({
    super.key,
    required this.completedTodos,
    required this.inCompletedTodos,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  void _markTodoAsUnDone(ToDo todo) async {
    try {
      final ToDo updatedTodo = ToDo(
        id: todo.id,
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: false,
      );

      await TodoService().markAsDone(updatedTodo);

      setState(() {
        widget.completedTodos.remove(todo);
        widget.inCompletedTodos.add(todo);
      });
      AppHelpers.showSnackBar(context, "Mark is Not Done");
      AppRouter.router.go("/todo");
    } catch (e) {
      AppHelpers.showSnackBar(context, "Faild to Mark is Not Done");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.completedTodos.sort((a, b) => a.time.compareTo(b.time));
    });
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.completedTodos.length,
              itemBuilder: (context, index) {
                final ToDo todo = widget.completedTodos[index];
                return TodoCard(
                  todo: todo,
                  isCompleted: true,
                  onCheckBoxChanged: () => _markTodoAsUnDone(todo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
