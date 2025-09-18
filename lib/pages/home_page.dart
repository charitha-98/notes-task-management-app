import 'package:flutter/material.dart';
import 'package:note_sphere/utills/constents.dart';
import 'package:note_sphere/utills/router.dart';
import 'package:note_sphere/utills/text_styles.dart';
import 'package:note_sphere/widgets/notes_todo_cards.dart';
import 'package:note_sphere/widgets/progress_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NoteSphere", style: AppTextStyles.appTitle)),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Column(
          children: [
            SizedBox(height: AppConstents.kDefaultPadding),
            ProgressCard(completedTask: 1, totalTask: 5),
            SizedBox(height: AppConstents.kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/notes");
                  },
                  child: NotesTodoCards(
                    title: "Notes",
                    description: "Sinhala notes",
                    icon: Icons.account_balance,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/todo");
                  },
                  child: NotesTodoCards(
                    title: "Todo",
                    description: "Sinhala notes",
                    icon: Icons.account_balance,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConstents.kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Progress", style: AppTextStyles.appSubtitle),
                Text("See All", style: AppTextStyles.appButton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
