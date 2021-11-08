import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicorn_app_scheduler/my_application.dart';
import 'package:unicorn_app_scheduler/my_image_asset.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job_storage.dart';
import 'package:unicorn_app_scheduler/ui/dialogs/job_form_dialog.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/button_icon_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/card_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';
import 'package:unicorn_app_scheduler/ui/widgets/job_item_widget.dart';
import 'package:unicorn_app_scheduler/utils/my_snack_bar_util.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
          title: MyText.build("ABOUT", fontSize: 24, fontFamily: "Rubik-Bold"),
        ),
        Expanded(
          child: buildPage(),
        ),
      ],
    );
  }

  Widget buildPage() {
    return Center(
      child: CardWidget(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                MyImageAsset.unicorn,
                width: 80,
              ),
              const SizedBox(
                height: 6,
              ),
              MyText.build("UNICORN-JOB",
                  fontSize: 20, fontFamily: "Rubik-Bold"),
              const SizedBox(
                height: 4,
              ),
              MyText.build("Simple Task Scheduler App",
                  fontSize: 14, color: MyTheme.TEXT_SUBTITLE),
              const SizedBox(
                height: 8,
              ),
              if (MyApplication.packageInfo != null)
                MyText.build(MyApplication.packageInfo!.version,
                    fontSize: 28, color: MyTheme.ACCENT),
              const SizedBox(
                height: 12,
              ),
              Container(width: 200,height: 2,color: Colors.grey[200],),
              const SizedBox(
                height: 12,
              ),
              MyText.build("Panuwat Jantawee",
                  fontSize: 14, color: MyTheme.TEXT_SUBTITLE),
            ],
          )),
    );
  }
}
