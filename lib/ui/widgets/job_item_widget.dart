import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/card_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';

class JobItemWidget extends StatefulWidget {
  const JobItemWidget({Key? key}) : super(key: key);

  @override
  _JobItemWidgetState createState() => _JobItemWidgetState();
}

class _JobItemWidgetState extends State<JobItemWidget> {
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(
                    "assets/images/ic_unicorn.png",
                    width: 40,
                  )),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.build("Mapping VMS-integration", fontSize: 16),
                    SizedBox(
                      height: 4,
                    ),
                    MyText.build("everyday at 00:00:00",
                        fontSize: 14, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(12)),
              child: MyText.build("D://vms_integration_app",
                  fontSize: 14, color: Colors.purple[600])),
          SizedBox(
            height: 4,
          ),
          Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(12)),
              child: MyText.build("pea_vms_integration_app.exe -auto",
                  fontSize: 14, color: Colors.blueGrey[900])),
        ],
      ),
    );
  }
}
