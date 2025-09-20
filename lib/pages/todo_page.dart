import 'package:flutter/material.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/text_styles.dart';
import 'package:note_sphere/widgets/completed_tab.dart';
import 'package:note_sphere/widgets/todo_tab.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
          tabs: [
            Tab(child: Text("ToDo", style: AppTextStyles.appDescription)),
            Tab(child: Text("Completed", style: AppTextStyles.appDescription)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          side: BorderSide(color: AppColors.kWhiteColor, width: 2),
        ),
        child: Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
      ),
      body: TabBarView(
        controller: _tabController,

        children: [TodoTab(), CompletedTab()],
      ),
    );
  }
}
