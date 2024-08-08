import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

class TodoTab extends StatefulWidget {
  const TodoTab({super.key});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Todo", style: AppTextStyles.appBody,),
    );
  }
}
