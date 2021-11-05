import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';

enum RecurringJob{
  SINGLE , DAILY
}

extension RecurringJobExtension on RecurringJob{
  String get title{
    if(this == RecurringJob.SINGLE){
      return "Single task";
    }
    if(this == RecurringJob.DAILY){
      return "Daily";
    }
    return "";
  }
}

class RecurringJobSegmentedControlWidget extends StatefulWidget {
  const RecurringJobSegmentedControlWidget({Key? key}) : super(key: key);

  @override
  _RecurringJobSegmentedControlWidgetState createState() =>
      _RecurringJobSegmentedControlWidgetState();
}

class _RecurringJobSegmentedControlWidgetState
    extends State<RecurringJobSegmentedControlWidget> {

  late RecurringJob segmentSelected;

  @override
  void initState() {
    segmentSelected = RecurringJob.SINGLE;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          for(RecurringJob s in RecurringJob.values)
          Expanded(child: buildSegment(s.title,selected: s == segmentSelected)),
        ],
      ),
    );
  }

  buildSegment(String title,{bool selected =false}) {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: selected ? Colors.blue[100] : null, borderRadius: BorderRadius.circular(12)),
        child: MyText.build(title,
            fontSize: 16, textAlign: TextAlign.center,selectable: false));
  }
}
