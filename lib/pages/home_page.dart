// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/services/note_services.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utills/constents.dart';
import 'package:note_sphere/utills/router.dart';
import 'package:note_sphere/utills/text_styles.dart';
import 'package:note_sphere/widgets/Main_screen_todo_card.dart';
import 'package:note_sphere/widgets/notes_todo_cards.dart';
import 'package:note_sphere/widgets/progress_card.dart';

import 'package:note_sphere/widgets/todo_inherited_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> allNotes = [];
  List<ToDo> allTodos = [];

  @override
  void initState() {
    super.initState();
    _checkIfUserIsNew();
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser =
        await NoteServices().isNewUser() || await TodoService().isNewUser();

    if (isNewUser) {
      await NoteServices().createInitialNotes();
      await TodoService().createInitialTodos();
    }
    _loadNotes();
    _loadTodos();
  }

  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await NoteServices().loadNotes();
    setState(() {
      allNotes = loadedNotes;
    });
  }

  Future<void> _loadTodos() async {
    final List<ToDo> loadedTodos = await TodoService().loadTodos();
    setState(() {
      allTodos = loadedTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TodoData(
      todos: allTodos,
      onTodoChanged: (todos) {
        setState(() {
          allTodos = todos;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("NoteSphere", style: AppTextStyles.appTitle),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Column(
            children: [
              SizedBox(height: AppConstents.kDefaultPadding),
              ProgressCard(
                completedTask: allTodos.where((todo) => todo.isDone).length,
                totalTask: allTodos.length,
              ),
              SizedBox(height: AppConstents.kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppRouter.router.push("/notes");
                    },
                    child: NotesTodoCards(
                      title: "Notes",
                      description: "${allNotes.length.toString()} Notes",
                      icon: Icons.account_balance,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppRouter.router.push("/todo");
                    },
                    child: NotesTodoCards(
                      title: "Todo",
                      description: "${allTodos.length.toString()} Tasks",
                      icon: Icons.account_balance,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppConstents.kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Today's Progress", style: AppTextStyles.appSubtitle),
                  Text("See All", style: AppTextStyles.appButton),
                ],
              ),
              SizedBox(height: 20),

              allTodos.length == 0
                  ? Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "No tasks for today , Add some tasks to get started!",
                              style: AppTextStyles.appDescription.copyWith(
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                AppRouter.router.push("/todo");
                              },
                              child: const Text("Add Task"),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: allTodos.length,
                        itemBuilder: (context, index) {
                          final ToDo toDo = allTodos[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: MainScreenTodoCard(
                              title: toDo.title,
                              date: toDo.date.toString(),
                              time: toDo.time.toString(),
                              isDone: toDo.isDone,
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
