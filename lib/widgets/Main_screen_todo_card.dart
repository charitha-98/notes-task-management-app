// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/constents.dart';
import 'package:note_sphere/utills/text_styles.dart';

class MainScreenTodoCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final bool isDone;
  const MainScreenTodoCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(AppConstents.kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.appDescription),
                SizedBox(height: 8),
                Text(
                  "${DateFormat.yMMMd().format(DateTime.parse(date))} ${DateFormat.Hm().format(DateTime.parse(time))}",
                  style: AppTextStyles.appDescriptionSmall.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isDone ? Icons.done_all_outlined : Icons.done_outline,
            color: isDone ? Colors.greenAccent : Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
