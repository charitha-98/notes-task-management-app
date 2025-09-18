import 'package:flutter/material.dart';

import 'package:note_sphere/utills/router.dart';

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
      routerConfig: AppRouter.router,
    );
  }
}
