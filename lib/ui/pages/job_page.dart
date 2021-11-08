import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job_storage.dart';
import 'package:unicorn_app_scheduler/ui/dialogs/job_form_dialog.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/button_icon_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/card_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';
import 'package:unicorn_app_scheduler/ui/widgets/job_item_widget.dart';
import 'package:unicorn_app_scheduler/utils/my_snack_bar_util.dart';

class JobPage extends StatefulWidget {
  const JobPage({Key? key}) : super(key: key);

  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          centerTitle: true,
          title: MyText.build("JOB", fontSize: 24, fontFamily: "Rubik-Bold"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonIconWidget(
                iconFront: Icons.add,
                title: "Add",
                color: MyTheme.ACCENT,
                background: MyTheme.ACCENT.withOpacity(0.1),
                backgroundHover: MyTheme.ACCENT.withOpacity(0.2),
                onTap: () {
                  JobFormDialog.show(context, mode: JobFormDialogMode.create,
                      onJobCreated: (job) {
                    MySnackBarUtil.showSuccess(context,
                        message: "Job \"${job.title}\" is created.");
                  });
                },
              ),
            )
          ],
        ),
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: Hive.box(JobStorage.key).listenable(),
              builder: (context, box, widget) {
                List<Job> listJobs = JobStorage.get();

                if (listJobs.isEmpty) {
                  return buildNoData();
                }

                return ListView.builder(
                  itemCount: listJobs.length,
                  padding: const EdgeInsets.all(32),
                  itemBuilder: (context, index) {
                    return JobItemWidget(
                      job: listJobs[index],
                      onJobUpdated: (job) {
                        MySnackBarUtil.showSuccess(context,
                            message: "Job \"${job.title}\" is updated.");
                      },
                      onJobDeleted: (job) {
                        MySnackBarUtil.showSuccess(context,
                            message: "Job \"${job.title}\" is deleted.");
                      },
                    );
                  },
                );
              }),
        ),
      ],
    );
  }


  Widget buildNoData() {
    return Center(
      child: CardWidget(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/ic_playlist.png",
                width: 80,
              ),
              MyText.build(
                "Empty job!",
                fontSize: 20,
              ),
              const SizedBox(height: 2,),
              MyText.build("There is no job here yet.",
                  fontSize: 16, color: MyTheme.TEXT_SUBTITLE),
            ],
          )),
    );
  }
}
