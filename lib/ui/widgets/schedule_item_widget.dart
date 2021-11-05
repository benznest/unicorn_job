import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/card_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';

class ScheduleItemWidget extends StatefulWidget {
  const ScheduleItemWidget({Key? key}) : super(key: key);

  @override
  _ScheduleItemWidgetState createState() => _ScheduleItemWidgetState();
}

class _ScheduleItemWidgetState extends State<ScheduleItemWidget> {
  @override
  Widget build(BuildContext context) {

    return CardWidget(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              buildStatusIcon(),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.build("Mapping VMS-integration",
                        fontSize: 16),
                    SizedBox(
                      height: 4,
                    ),
                    MyText.build("on 3 Nov 2021 17:30:00",
                        fontSize: 14, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildStatusIcon() {
    bool launch = false;
    return  Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: Colors.lightBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)),
        child: Image.asset(
          "assets/images/ic_timer.png",
          width: 40,
        ));
  }
}
