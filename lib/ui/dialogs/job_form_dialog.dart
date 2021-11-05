import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/button_icon_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text_field.dart';
import 'package:unicorn_app_scheduler/ui/widgets/recurring_job_segmented_control_widget.dart';

class JobFormDialog extends StatefulWidget {
  JobFormDialog();

  static show(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: true,
        barrierColor: Colors.grey[700]!.withOpacity(0.5),
        builder: (context) => JobFormDialog());
  }

  @override
  _JobFormDialogState createState() => _JobFormDialogState();
}

class _JobFormDialogState extends State<JobFormDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (widget.initResult != null) {
        Navigator.pop(context);
        // }
      },
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: GestureDetector(
            onTap: () {
              //
            },
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: EdgeInsets.all(32),
                padding: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                    color: MyTheme.BACKGROUND_PRIMARY,
                    borderRadius: BorderRadius.circular(22)),
                child: buildContent(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 32,
        ),
        Row(
          children: [
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16)),
                child: Image.asset(
                  "assets/images/ic_unicorn.png",
                  width: 60,
                )),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.build("Job title", fontSize: 18),
                  SizedBox(
                    height: 4,
                  ),
                  MyTextFieldBuilder.buildTextCollapse(
                      fontSize: 20),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        MyText.build("Recurring", fontSize: 18),
        SizedBox(
          height: 4,
        ),
        RecurringJobSegmentedControlWidget(),
        SizedBox(
          height: 16,
        ),
        MyText.build("Date & Time", fontSize: 18),
        SizedBox(
          height: 4,
        ),
        MyTextFieldBuilder.buildTextCollapse(
            fontSize: 20, textAlign: TextAlign.center),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonIconWidget(
              icon: Icons.close,
              title: "Close",
              textColor: MyTheme.DANGER,
              background: Colors.red[50],
              backgroundHover: Colors.red[100],
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 8,
            ),
            ButtonIconWidget(
              icon: Icons.check,
              title: "Save",
              textColor: MyTheme.SUCCESS,
              background: Colors.green[50],
              backgroundHover: Colors.green[100],
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
