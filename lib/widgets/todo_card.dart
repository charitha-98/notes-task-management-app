// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:note_sphere/models/todo_model.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/text_styles.dart';

class TodoCard extends StatefulWidget {
  final ToDo todo;
  final bool isCompleted;
  const TodoCard({super.key, required this.todo, required this.isCompleted});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(widget.todo.title, style: AppTextStyles.appDescription),
        subtitle: Row(
          children: [
            Text(
              "${widget.todo.date.day}/${widget.todo.date.month}/${widget.todo.date.year}",
              style: AppTextStyles.appDescription.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "${widget.todo.time.hour}:${widget.todo.time.minute} ",
              style: AppTextStyles.appDescription.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
          ],
        ),
        trailing: Checkbox(value: widget.isCompleted, onChanged: (value) {}),
      ),
    );
  }
}
