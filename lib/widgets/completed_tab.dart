import 'package:f24_notes_sphere/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CompletedTab extends StatefulWidget {
  const CompletedTab({super.key});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("completed", style: AppTextStyles.appBody,),
    );
  }
}
