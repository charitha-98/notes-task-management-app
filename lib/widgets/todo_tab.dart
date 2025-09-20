import 'package:flutter/widgets.dart';
import 'package:note_sphere/utills/colors.dart';

class TodoTab extends StatefulWidget {
  const TodoTab({super.key});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Todo Tab", style: TextStyle(color: AppColors.kWhiteColor)),
    );
  }
}
