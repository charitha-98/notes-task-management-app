// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/constents.dart';
import 'package:note_sphere/utills/text_styles.dart';

class NotesCard extends StatelessWidget {
  final String noteCategory;
  final int numOfNotes;
  const NotesCard({
    super.key,
    required this.noteCategory,
    required this.numOfNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstents.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(noteCategory, style: AppTextStyles.appSubtitle),
          Text(
            "$numOfNotes notes",
            style: AppTextStyles.appSubtitle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: AppColors.kWhiteColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
