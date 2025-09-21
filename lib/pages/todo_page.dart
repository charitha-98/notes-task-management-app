// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/router.dart';
import 'package:note_sphere/utills/text_styles.dart';
import 'package:note_sphere/widgets/completed_tab.dart';
import 'package:note_sphere/widgets/todo_inherited_widget.dart';
import 'package:note_sphere/widgets/todo_tab.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<ToDo> allTodos = [];
  late List<ToDo> incompletedTodos = [];
  late List<ToDo> completedTodos = [];
  TextEditingController _taskController = TextEditingController();

  TodoService todoService = TodoService();

  @override
  void dispose() {
    _tabController.dispose();
    _taskController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkIfUserIsNew();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser = await todoService.isNewUser();
    if (isNewUser) {
      await todoService.createInitialTodos();
    }
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final List<ToDo> loadedTodos = await todoService.loadTodos();
    setState(() {
      allTodos = loadedTodos;
      incompletedTodos = allTodos.where((todo) => !todo.isDone).toList();

      completedTodos = allTodos.where((todo) => todo.isDone).toList();
    });
  }

  void _addTask() async {
    try {
      if (_taskController.text.isNotEmpty) {
        final ToDo newTodo = ToDo(
          title: _taskController.text,
          date: DateTime.now(),
          time: DateTime.now(),
          isDone: false,
        );

        await todoService.addTodo(newTodo);
        _loadTodos();

        if (TodoData.of(context) != null) {
          TodoData.of(context)!.onTodoChanged(allTodos);
        }

        setState(() {
          allTodos.add(newTodo);
          incompletedTodos.add(newTodo);
        });

        AppHelpers.showSnackBar(context, "Task added!");
        Navigator.pop(context);
      }
    } catch (e) {
      AppHelpers.showSnackBar(context, "Faild to add task!");
    }
  }

  void openMassageModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          title: Text(
            "Add Task",
            style: AppTextStyles.appDescription.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: _taskController,
            style: TextStyle(color: AppColors.kWhiteColor),
            decoration: InputDecoration(
              hintText: "Enter Your Task",
              hintStyle: AppTextStyles.appDescription,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addTask();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColors.kFabColor),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              child: Text("Add Task", style: AppTextStyles.appButton),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColors.kCardColor),
              ),
              child: Text("Calncel", style: AppTextStyles.appButton),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TodoData(
      todos: allTodos,
      onTodoChanged: (todo) {},
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              AppRouter.router.push("/");
            },
            icon: const Icon(Icons.arrow_back),
          ),
          bottom: TabBar(
            dividerColor: Colors.transparent,
            controller: _tabController,
            tabs: [
              Tab(child: Text("ToDo", style: AppTextStyles.appDescription)),
              Tab(
                child: Text("Completed", style: AppTextStyles.appDescription),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openMassageModel(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            side: BorderSide(color: AppColors.kWhiteColor, width: 2),
          ),
          child: Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
        ),
        body: TabBarView(
          controller: _tabController,

          children: [
            TodoTab(
              inCompletedTodos: incompletedTodos,
              completedTodos: completedTodos,
            ),
            CompletedTab(
              completedTodos: completedTodos,
              inCompletedTodos: incompletedTodos,
            ),
          ],
        ),
      ),
    );
  }
}
