import 'package:f24_notes_sphere/utils/router.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppRouter.router.go("/");
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 3,
          ),
        ),
        child: const Icon(
          Icons.add,
          size: 30,
          color: AppColors.kWhiteColor,
        ),
      ),
    );
  }
}
