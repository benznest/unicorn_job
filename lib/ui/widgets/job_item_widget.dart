import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job_repetition.dart';
import 'package:unicorn_app_scheduler/ui/dialogs/job_form_dialog.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/button_icon_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/card_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';
import 'package:unicorn_app_scheduler/utils/my_date_utils.dart';

class JobItemWidget extends StatefulWidget {
  final Job job;
  final Function(Job)? onJobUpdated;
  final Function(Job)? onJobDeleted;

  const JobItemWidget(
      {Key? key, required this.job, this.onJobUpdated, this.onJobDeleted})
      : super(key: key);

  @override
  _JobItemWidgetState createState() => _JobItemWidgetState();
}

class _JobItemWidgetState extends State<JobItemWidget> {
  late bool isHover;

  @override
  void initState() {
    isHover = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // widget.onTap?.call(widget.job);
        },
        child: MouseRegion(
            // cursor: SystemMouseCursors.click,
            // onEnter: (e) {
            //   setState(() {
            //     isHover = true;
            //   });
            // },
            // onExit: (e) {
            //   setState(() {
            //     isHover = false;
            //   });
            // },
            child: CardWidget(
          borderRadius: BorderRadius.circular(16),
          background: isHover ? Colors.grey[50] : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Image.asset(
                        "assets/images/ic_unicorn.png",
                        width: 40,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.build(
                          widget.job.title,
                          fontSize: 16,
                          selectable: false,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        if (widget.job.repetition == JobRepetition.single.id)
                          MyText.build(
                              MyDateUtil.displayDateTime(widget.job.dateTime),
                              fontSize: 14,
                              selectable: false,
                              color: Colors.grey),
                        if (widget.job.repetition == JobRepetition.daily.id)
                          MyText.build(
                              "everyday at ${TimeOfDay.fromDateTime(widget.job.dateTime).format(context)}",
                              fontSize: 14,
                              selectable: false,
                              color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ButtonIconWidget(
                    iconFront: Icons.edit,
                    color: MyTheme.PRIMARY,
                    background: MyTheme.PRIMARY.withOpacity(0.1),
                    backgroundHover: MyTheme.PRIMARY.withOpacity(0.2),
                    spaceBetweenIconTextFront: 0,
                    onTap: () {
                      JobFormDialog.show(context,
                          mode: JobFormDialogMode.edit,
                          initJob: widget.job,
                          onJobUpdated: widget.onJobUpdated);
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ButtonIconWidget(
                      iconFront: Icons.delete,
                      color: MyTheme.DANGER,
                      background: MyTheme.DANGER.withOpacity(0.1),
                      backgroundHover: MyTheme.DANGER.withOpacity(0.2),
                      spaceBetweenIconTextFront: 0,onTap: (){

                    JobFormDialog.show(context,
                        mode: JobFormDialogMode.delete,
                        initJob: widget.job,
                        onJobDeleted: widget.onJobDeleted);
                  },)
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.build(
                        "Executable",
                        fontSize: 12,
                        color: Colors.purple[200],
                        selectable: false,
                      ),
                      MyText.build(
                        widget.job.executable,
                        fontSize: 16,
                        color: Colors.purple[600],
                        selectable: false,
                      )
                    ],
                  )),
              const SizedBox(
                height: 4,
              ),
              Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.build(
                        "Arguments",
                        fontSize: 12,
                        color: Colors.blueGrey[200],
                        selectable: false,
                      ),
                      MyText.build(
                        widget.job.arguments,
                        fontSize: 16,
                        color: Colors.blueGrey[700],
                        selectable: false,
                      )
                    ],
                  )),
            ],
          ),
        )));
  }
}
