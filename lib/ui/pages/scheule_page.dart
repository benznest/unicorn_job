import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/card_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';
import 'package:unicorn_app_scheduler/ui/widgets/schedule_item_widget.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          centerTitle: true,
          title:
              MyText.build("SCHEDULE", fontSize: 24, fontFamily: "Rubik-Bold"),
          actions: [

          ],
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(32),
            children: [
              ScheduleItemWidget()
            ],
          ),
        ),
      ],
    );
  }
}
