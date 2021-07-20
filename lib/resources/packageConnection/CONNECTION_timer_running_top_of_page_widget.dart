import 'package:custom_highly_reusable_functions/HighlyReusableFunctions.dart';
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
    super.initState();
    STATE_TopTimerWidget = setState;
    // customPrint('created new top timer');
  }

  @override
  void dispose() {
    super.dispose();
    if (STATE_TopTimerWidget == setState) {
      STATE_TopTimerWidget = null;
      // customPrint('disposed new top timer');
    }
  }

  @override
  Widget build(BuildContext context) {
    // customPrint('Setstate CONNECTION');
    return CustomTopTimerWidget(
      TV_howLong: TV_howLong,
      TV_timeSpent: TV_timeSpent,
      TV_studiedTime: TV_studiedTime,
      TV_isTakingBreakAtPresent: TV_isTakingBreakAtPresent,
      TV_isStudyingAtPresent: TV_isStudyingAtPresent,
    );
  }
}
