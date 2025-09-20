import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/pages/create_new_note.dart';
import 'package:note_sphere/pages/home_page.dart';
import 'package:note_sphere/pages/notes_by_category.dart';
import 'package:note_sphere/pages/notes_page.dart';
import 'package:note_sphere/pages/single_note.dart';
import 'package:note_sphere/pages/todo_page.dart';
import 'package:note_sphere/pages/update_note_page.dart';

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
      GoRoute(
        name: "category",
        path: "/category",
        builder: (context, state) {
          final String category = state.extra as String;
          return NotesByCategory(category: category);
        },
      ),

      GoRoute(
        name: "create-note",
        path: "/create-note",
        builder: (context, state) {
          final isNewCategoryPage = state.extra as bool;
          return CreateNewNote(isNewCategory: isNewCategoryPage);
        },
      ),
      GoRoute(
        name: "edit-note",
        path: "/edit-note",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return UpdateNotePage(note: note);
        },
      ),
      GoRoute(
        name: "single-note",
        path: "/single-note",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return SingleNote(note: note);
        },
      ),
    ],
  );
}
