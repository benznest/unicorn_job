import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/ui/pages/job_page.dart';
import 'package:unicorn_app_scheduler/ui/pages/scheule_page.dart';
import 'package:unicorn_app_scheduler/ui/widgets/menu_item_widget.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/ui/widgets/menu_widget.dart';

enum HomePageMenu { SCHEDULE, JOBS, SETTING, ABOUT }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomePageMenu menuSelected;

  @override
  void initState() {
    menuSelected = HomePageMenu.SCHEDULE;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.BACKGROUND_MAIN,
      body: Row(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: MenuWidget(
                initMenu: menuSelected,
                onMenuSelected: (m) {
                  setState(() {
                    menuSelected = m;
                  });
                },
              )),
          Container(width: 1,
          color: Colors.grey[100],),
          Expanded(
              child: buildPage()),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  buildPage() {
    if (menuSelected == HomePageMenu.SCHEDULE) {
      return SchedulePage();
    }
    if (menuSelected == HomePageMenu.JOBS) {
      return JobPage();
    }
    return Container(
    );
  }
}
