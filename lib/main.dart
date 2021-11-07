import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_application.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task_manager.dart';
import 'package:unicorn_app_scheduler/ui/pages/home_page.dart';

Future<void> main() async {
  await MyApplication.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatefulWidgetState();
  }
}

class StatefulWidgetState extends State<StatefulWidget> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkTask();
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  checkTask(){
    TaskManager.check();
    setState(() {
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Unicorn Job',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
