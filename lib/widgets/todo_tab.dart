import 'package:flutter/widgets.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utills/router.dart';

import 'package:note_sphere/widgets/todo_card.dart';
import 'package:note_sphere/widgets/todo_inherited_widget.dart';

class TodoTab extends StatefulWidget {
  final List<ToDo> inCompletedTodos;
  final List<ToDo> completedTodos;
  const TodoTab({
    super.key,
    required this.inCompletedTodos,
    required this.completedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  void _markTodoAsDone(ToDo todo) async {
    try {
      final ToDo updatedToDo = ToDo(
        id: todo.id,
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: true,
      );

      await TodoService().markAsDone(updatedToDo);

      AppHelpers.showSnackBar(context, "Marked as done!");

      setState(() {
        widget.inCompletedTodos.remove(todo);
        widget.completedTodos.add(updatedToDo);
      });
      AppRouter.router.go("/todo");
    } catch (e) {
      AppHelpers.showSnackBar(context, "Faild to Marked as done!");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.inCompletedTodos.sort((a, b) => a.time.compareTo(b.time));
    });

    return TodoData(
      todos: widget.inCompletedTodos,
      onTodoChanged: (todo) {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.inCompletedTodos.length,
                itemBuilder: (context, index) {
                  final ToDo todo = widget.inCompletedTodos[index];
                  return Dismissible(
                    key: Key(todo.id.toString()),
                    onDismissed: (direction) {
                      setState(() {
                        widget.inCompletedTodos.removeAt(index);
                        TodoService().deletdTodo(todo);
                      });

                      AppHelpers.showSnackBar(context, "Todo is scuccesfully!");
                    },
                    child: TodoCard(
                      todo: todo,
                      isCompleted: false,
                      onCheckBoxChanged: () => _markTodoAsDone(todo),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
