// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/constents.dart';
import 'package:note_sphere/utills/text_styles.dart';

class ProgressCard extends StatefulWidget {
  final int completedTask;
  final int totalTask;
  const ProgressCard({
    super.key,
    required this.completedTask,
    required this.totalTask,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    double completeionPrecentage = widget.totalTask != 0
        ? (widget.completedTask / widget.totalTask) * 100
        : 0;
    return Container(
      padding: EdgeInsets.all(AppConstents.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's Progress", style: AppTextStyles.appSubtitle),
              SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  "You have completed ${widget.completedTask} out of ${widget.totalTask} task, keep up the progress!",
                  style: AppTextStyles.appDescriptionSmall.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.22,
                height: MediaQuery.of(context).size.width * 0.22,
                decoration: BoxDecoration(
                  gradient: AppColors().kPrimaryGradient,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    "$completeionPrecentage %",
                    style: AppTextStyles.appSubtitle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
