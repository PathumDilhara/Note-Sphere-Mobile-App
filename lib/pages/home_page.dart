import 'package:f24_notes_sphere/utils/constants.dart';
import 'package:f24_notes_sphere/utils/router.dart';
import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:f24_notes_sphere/widgets/notes_todo_card.dart';
import 'package:flutter/material.dart';

import '../widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NoteSphere",
          style: AppTextStyles.appTitleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultFontSize,
            ),
            const ProgressCard(
              noOfCompletedTasks: 3,
              noOfTotalTasks: 5,
            ),
            SizedBox(
              height: AppConstants.kDefaultPadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/notes");
                  },
                  child: const NotesTodoCard(
                    icon: Icons.bookmark_add_outlined,
                    title: "Notes",
                    description: "3 Notes",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/todo");
                  },
                  child: const NotesTodoCard(
                    icon: Icons.bookmark_add_outlined,
                    title: "To-Do List",
                    description: "3 Tasks",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppConstants.kDefaultPadding*1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Progress",
                  style: AppTextStyles.appSubTitleStyle,
                ),
                Text(
                  "See All",
                  style: AppTextStyles.appButton,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
