import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/ui/dialogs/job_form_dialog.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/card_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';
import 'package:unicorn_app_scheduler/ui/widgets/job_item_widget.dart';

class JobPage extends StatefulWidget {
  const JobPage({Key? key}) : super(key: key);

  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          centerTitle: true,
          title:
          MyText.build("JOB", fontSize: 24, fontFamily: "Rubik-Bold"),
          actions: [
            GestureDetector(
              onTap: (){
                JobFormDialog.show(context);
              },
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                    color: MyTheme.PRIMARY,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                    MyText.build("Add",
                        fontSize: 16,
                        fontFamily: "Rubik",
                        color: Colors.white,
                        selectable: false),
                  ],
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(32),
            children: [
              JobItemWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
