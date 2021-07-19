import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';

import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart';
import 'package:custom_top_timer_widget/top_timer_widget.dart';


class TimerStatusOnTopOfPage extends StatefulWidget {
  const TimerStatusOnTopOfPage({Key? key}) : super(key: key);

  @override
  _TimerStatusOnTopOfPageState createState() => _TimerStatusOnTopOfPageState();
}

class _TimerStatusOnTopOfPageState extends State<TimerStatusOnTopOfPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    STATE_TopTimerWidget = setState;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTopTimerWidget(
      TV_howLong: TV_howLong,
      TV_timeSpent: TV_timeSpent,
      TV_studiedTime: TV_studiedTime,
      TV_isTakingBreakAtPresent: TV_isTakingBreakAtPresent,
      TV_isStudyingAtPresent: TV_isStudyingAtPresent,
    );
  }
}
