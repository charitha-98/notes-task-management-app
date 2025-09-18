// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/text_styles.dart';

class NotesTodoCards extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  const NotesTodoCards({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  State<NotesTodoCards> createState() => _NotesTodoCardsState();
}

class _NotesTodoCardsState extends State<NotesTodoCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            Icon(widget.icon, size: 40),
            SizedBox(height: 10),
            Text(widget.title, style: AppTextStyles.appDescription),
            SizedBox(height: 2),
            Text(
              widget.title,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
