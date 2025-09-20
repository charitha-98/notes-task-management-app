import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/text_styles.dart';

class AppHelpers {
  static void showSnackBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kFabColor,
        content: Text(massage, style: AppTextStyles.appButton),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
