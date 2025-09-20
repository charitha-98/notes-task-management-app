import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/models/todo_model.dart';

import 'package:note_sphere/utills/router.dart';
import 'package:note_sphere/utills/theme_data.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(ToDoAdapter());

  await Hive.openBox('notes');
  await Hive.openBox('todos');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "NoteSphere",
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.dartTheme.copyWith(
        textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
