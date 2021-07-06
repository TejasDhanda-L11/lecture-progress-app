import 'package:flutter/material.dart';
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/temp_variables/temp_variables_timer.dart' as temp_t_v;

class TimerStatusOnTopOfPage extends StatefulWidget {

  @override
  _TimerStatusOnTopOfPageState createState() => _TimerStatusOnTopOfPageState();
}

class _TimerStatusOnTopOfPageState extends State<TimerStatusOnTopOfPage> {

  @override
  void initState() {
    super.initState();
    temp_t_v.setState_TOP_TIMER_WIDGET_func = setState;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          SizedBox(width: 10,),
          Text(
            'Timer'
          ),
          SizedBox(width: 10,),
          Text(durationToStringTime(duration: temp_t_v.howLong - temp_t_v.timeSpent )),
          SizedBox(width: 10,),
          Text('focus')
        ],
      ),
    );
  }
}