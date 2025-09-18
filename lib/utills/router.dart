import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/pages/home_page.dart';
import 'package:note_sphere/pages/notes_page.dart';
import 'package:note_sphere/pages/todo_page.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return HomePage();
        },
      ),
      GoRoute(
        name: "notes",
        path: "/notes",
        builder: (context, state) {
          return NotesPage();
        },
      ),
      GoRoute(
        name: "todo",
        path: "/todo",
        builder: (context, state) {
          return TodoPage();
        },
      ),
    ],
  );
}
