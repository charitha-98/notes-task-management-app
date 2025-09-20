// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/constents.dart';
import 'package:note_sphere/utills/text_styles.dart';

class SingleNote extends StatefulWidget {
  final Note note;
  const SingleNote({super.key, required this.note});

  @override
  State<SingleNote> createState() => _SingleNoteState();
}

class _SingleNoteState extends State<SingleNote> {
  @override
  Widget build(BuildContext context) {
    final formatedDate = DateFormat.yMMMd().format(widget.note.date);
    return Scaffold(
      appBar: AppBar(title: Text("Note")),
      body: Padding(
        padding: EdgeInsets.all(AppConstents.kDefaultPadding),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(widget.note.title, style: AppTextStyles.appTitle),
            SizedBox(height: 20),
            Text(
              widget.note.category,
              style: AppTextStyles.appButton.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.2),
              ),
            ),
            SizedBox(height: 20),
            Text(
              formatedDate,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kFabColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.note.content,
              style: AppTextStyles.appDescription.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
