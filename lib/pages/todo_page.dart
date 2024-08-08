import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:f24_notes_sphere/widgets/completed_tab.dart';
import 'package:f24_notes_sphere/widgets/todo_tab.dart';
import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

// to activate tab bar use "with SingleTickerProviderStateMixin"
class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  // tab bar controller for store the which tab i in (knowledge)
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // length = no of tabs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                "ToDo",
                style: AppTextStyles.appDescriptionLargeStyle
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Tab(
              child: Text(
                "Completed",
                style: AppTextStyles.appDescriptionLargeStyle
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          side: BorderSide(color: AppColors.kWhiteColor, width: 2),
        ),
        child: const Icon(
          Icons.add,
          size: 30,
          color: AppColors.kWhiteColor,
        ),
      ),
      body: TabBarView(
        controller: _tabController, // For identifying tab switching
        children: const [
          // show in order
          TodoTab(),
          CompletedTab()
        ],
      ),
    );
  }
}
