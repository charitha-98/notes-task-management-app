import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:note_sphere/utills/router.dart';
import 'package:note_sphere/utills/theme_data.dart';

void main() {
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
