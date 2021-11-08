import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:unicorn_app_scheduler/my_image_asset.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job_repetition.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job_storage.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task_manager.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/button_icon_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text_field.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/radio_box_widget.dart';
import 'package:unicorn_app_scheduler/utils/my_date_utils.dart';
import 'package:unicorn_app_scheduler/utils/my_snack_bar_util.dart';

enum JobFormDialogMode { create, edit, delete }

class JobFormDialog extends StatefulWidget {
  final JobFormDialogMode mode;
  final Job? initJob;
  final Function(Job)? onJobCreated;
  final Function(Job)? onJobUpdated;
  final Function(Job)? onJobDeleted;

  const JobFormDialog(
      {Key? key,
      required this.mode,
      this.initJob,
      this.onJobCreated,
      this.onJobUpdated,
      this.onJobDeleted})
      : super(key: key);

  static show(BuildContext context,
      {required JobFormDialogMode mode,
      Job? initJob,
      Function(Job)? onJobCreated,
      Function(Job)? onJobUpdated,
      Function(Job)? onJobDeleted}) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: true,
        barrierColor: Colors.grey[700]!.withOpacity(0.5),
        builder: (context) => JobFormDialog(
            mode: mode,
            initJob: initJob,
            onJobCreated: onJobCreated,
            onJobUpdated: onJobUpdated,
            onJobDeleted: onJobDeleted));
  }

  @override
  _JobFormDialogState createState() => _JobFormDialogState();
}

class _JobFormDialogState extends State<JobFormDialog> {
  late TimeOfDay timeRepetition;
  late DateTime dateTimeRepetition;
  late JobRepetition jobRepetitionSelected;
  bool readOnly = false;
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _executableController = TextEditingController();
  final TextEditingController _argumentsTitleController =
      TextEditingController();
  GlobalKey<ScaffoldState> keyScaffold = GlobalKey();

  @override
  void initState() {
    if (widget.mode == JobFormDialogMode.delete) {
      readOnly = true;
    }

    if (widget.initJob != null) {
      _jobTitleController.text = widget.initJob!.title;
      _executableController.text = widget.initJob!.executable;
      _argumentsTitleController.text = widget.initJob!.arguments;
      jobRepetitionSelected =
          JobRepetitionUtil.get(widget.initJob!.repetition) ??
              JobRepetition.single;
      timeRepetition = TimeOfDay(
          hour: widget.initJob!.dateTime.hour,
          minute: widget.initJob!.dateTime.minute);
      dateTimeRepetition = widget.initJob!.dateTime;
    } else {
      DateTime dt = DateTime.now().add(const Duration(hours: 1));
      timeRepetition = TimeOfDay.fromDateTime(dt);
      dateTimeRepetition = DateTime.now();
      jobRepetitionSelected = JobRepetition.single;
    }

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
        Navigator.pop(context);
      },
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: GestureDetector(
            onTap: () {
              //
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                    color: MyTheme.BACKGROUND_PRIMARY,
                    borderRadius: BorderRadius.circular(22)),
                child: ScaffoldMessenger(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            Expanded(child: buildContent(context)),
                            Container(
                              height: 2,
                              color: Colors.grey[200],
                            ),
                            buildButtonSubmit(context)
                          ],
                        );
                      },
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32),
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16)),
                child: Image.asset(
                  MyImageAsset.unicorn,
                  width: 60,
                )),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.build("Job title", fontSize: 18),
                  const SizedBox(
                    height: 4,
                  ),
                  MyTextFieldBuilder.buildTextCollapse(
                      controller: _jobTitleController,
                      readOnly: readOnly,
                      fontSize: 16,
                      textColor: Colors.purple[600]),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                MyText.build("Repetition",
                    fontSize: 18, color: MyTheme.TEXT_PRIMARY),
                const SizedBox(
                  height: 2,
                ),
                MyText.build("How do you want the loop to work?",
                    fontSize: 14, color: MyTheme.TEXT_SUBTITLE),
                const SizedBox(
                  height: 8,
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    for (JobRepetition job in JobRepetition.values)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioBoxWidget(
                            checked: jobRepetitionSelected == job,
                            readOnly: readOnly,
                            onCheck: (v) {
                              setState(() {
                                jobRepetitionSelected = job;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          MyText.build(job.title, fontSize: 16),
                        ],
                      ),
                  ],
                ),
              ],
            )),
        const SizedBox(
          height: 8,
        ),
        Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                if (jobRepetitionSelected == JobRepetition.single)
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        MyText.build("Date", fontSize: 18),
                        const SizedBox(
                          height: 4,
                        ),
                        ButtonIconWidget(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          title: MyDateUtil.display(dateTimeRepetition),
                          color: Colors.white,
                          background: MyTheme.ACCENT,
                          backgroundHover: MyTheme.ACCENT.withOpacity(0.9),
                          fontSize: 14,
                          iconTrail: Icons.edit,
                          readOnly: readOnly,
                          onTap: () async {
                            DateTime? t = await showRoundedDatePicker(
                              context: context,
                              theme:
                                  ThemeData(primarySwatch: Colors.deepPurple),
                              initialDate: dateTimeRepetition,
                            );
                            if (t != null) {
                              setState(() {
                                dateTimeRepetition = t;
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      MyText.build("Time", fontSize: 18),
                      const SizedBox(
                        height: 4,
                      ),
                      ButtonIconWidget(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        title: timeRepetition.format(context),
                        color: Colors.white,
                        background: MyTheme.ACCENT,
                        backgroundHover: MyTheme.ACCENT.withOpacity(0.9),
                        fontSize: 14,
                        iconTrail: Icons.edit,
                        readOnly: readOnly,
                        onTap: () async {
                          TimeOfDay? t = await showRoundedTimePicker(
                            context: context,
                            theme: ThemeData(primarySwatch: Colors.deepPurple),
                            initialTime: timeRepetition,
                          );
                          if (t != null) {
                            setState(() {
                              timeRepetition = t;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.build("Executable", fontSize: 18),
                      const SizedBox(
                        height: 2,
                      ),
                      MyText.build("The full path .exe file.",
                          fontSize: 14, color: MyTheme.TEXT_SUBTITLE),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                if (!readOnly)
                  ButtonIconWidget(
                    iconFront: Icons.folder,
                    title: "Browse",
                    fontSize: 14,
                    color: MyTheme.PRIMARY,
                    background: MyTheme.PRIMARY.withOpacity(0.2),
                    backgroundHover: MyTheme.PRIMARY.withOpacity(0.3),
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                        dialogTitle: "Choose executable file",
                              allowedExtensions: ["exe"],
                              type: FileType.custom);

                      if (result != null) {
                        File file = File(result.files.single.path!);
                        setState(() {
                          _executableController.text = file.path;
                        });
                      }
                    },
                  )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            MyTextFieldBuilder.buildTextCollapse(
                controller: _executableController,
                fontSize: 14,
                textColor: Colors.purple[600],
                readOnly: readOnly,
                minLine: 3),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.build("Arguments", fontSize: 18),
            const SizedBox(
              height: 2,
            ),
            MyText.build("This field is optional, Example -auto",
                fontSize: 14, color: MyTheme.TEXT_SUBTITLE),
            const SizedBox(
              height: 4,
            ),
            MyTextFieldBuilder.buildTextCollapse(
                controller: _argumentsTitleController,
                fontSize: 14,
                textColor: Colors.purple[600],
                readOnly: readOnly,
                minLine: 3),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  buildButtonSubmit(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonIconWidget(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            iconFront: Icons.close,
            title: "Cancel",
            color: Colors.grey[600]!,
            background: Colors.grey[100],
            backgroundHover: Colors.grey[200],
            onTap: () {
              Navigator.pop(context);
            },
          ),
          if (widget.mode == JobFormDialogMode.delete)
            ButtonIconWidget(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              iconFront: Icons.delete,
              title: "Delete",
              color: MyTheme.DANGER,
              background: Colors.red[50],
              backgroundHover: Colors.red[100],
              onTap: () {
                delete(context);
              },
            ),
          if (widget.mode == JobFormDialogMode.create ||
              widget.mode == JobFormDialogMode.edit)
            ButtonIconWidget(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              iconFront: Icons.check,
              title: "Save",
              color: MyTheme.SUCCESS,
              background: Colors.green[50],
              backgroundHover: Colors.green[100],
              onTap: () {
                save(context);
              },
            ),
        ],
      ),
    );
  }

  Future<void> save(BuildContext context) async {
    String jobTitle = _jobTitleController.text.trim();
    String executable = _executableController.text.trim();
    String arguments = _argumentsTitleController.text.trim();

    if (jobTitle.isEmpty) {
      MySnackBarUtil.showDanger(
        context,
        message: "Job title is invalid.",
      );
      return;
    }
    if (executable.isEmpty) {
      MySnackBarUtil.showDanger(
        context,
        message: "Executable path is invalid.",
      );
      return;
    }

    Job job = widget.initJob ?? Job();
    job.title = jobTitle;
    job.executable = executable;
    job.arguments = arguments;
    job.repetition = jobRepetitionSelected.id;

    if (jobRepetitionSelected == JobRepetition.single) {
      job.dateTime = DateTime(dateTimeRepetition.year, dateTimeRepetition.month,
          dateTimeRepetition.day, timeRepetition.hour, timeRepetition.minute);
    } else if (jobRepetitionSelected == JobRepetition.daily) {
      job.dateTime = DateTime(
        0,
        0,
        0,
        timeRepetition.hour,
        timeRepetition.minute,
      );
    }

    if (widget.mode == JobFormDialogMode.create) {
      await JobStorage.add(job);
      await TaskManager.createTask(job);
      Navigator.pop(context);
      widget.onJobCreated?.call(job);
    } else if (widget.mode == JobFormDialogMode.edit) {
      await job.save();

      if (jobRepetitionSelected == JobRepetition.daily ||
          (jobRepetitionSelected == JobRepetition.single &&
              dateTimeRepetition.isAfter(DateTime.now()))) {
        await TaskManager.delete(job);
        await TaskManager.createTask(job);
      }

      Navigator.pop(context);
      widget.onJobUpdated?.call(job);
    }
  }

  Future<void> delete(BuildContext context) async {
    await widget.initJob!.delete();
    await TaskManager.delete(widget.initJob!);
    Navigator.pop(context);
    widget.onJobDeleted?.call(widget.initJob!);
  }
}
