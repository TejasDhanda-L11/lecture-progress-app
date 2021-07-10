import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart'
    ;
import 'package:lecture_progress/resources/widgets/timerPage_widgets/choose_pomondoro_ways_class.dart';

// timer complete dialog
void timerCompleteDailog() {
  BuildContext context = gapv_presentlyTopContext!;

  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return cutomDiaglog(context: context);
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}

Widget cutomDiaglog({required BuildContext context}) {
  int nextTimeRangeToCover_inSeconds = TV_studied_last_time
      ? pomondoroList[TV_currentPomondoroTimer_id -1]['time_of_break']
      : pomondoroList[TV_currentPomondoroTimer_id - 1]['time_of_study'];

  return CupertinoAlertDialog(
    title: Text('Timer Complete'),
    content: Column(
      children: [
        Text(
            '${TV_studied_last_time ? 'Focus' : 'Break'} time has completed.'),
        Text(
            'Should we commence ${TV_studied_last_time ? 'Break' : 'Focus'} time of ${Duration(seconds: nextTimeRangeToCover_inSeconds).inMinutes} mins')
      ],
    ),
    actions: [
      CupertinoDialogAction(
        child: Text('No'),
        onPressed: () {
          customPrint('NO');

          Navigator.pop(context);
        },
      ),
      CupertinoDialogAction(
        child: Text('YES'),
        onPressed: () {
          customPrint('YES');

          TV_howLong = Duration(
              seconds: nextTimeRangeToCover_inSeconds);
          TV_studied_last_time = !TV_studied_last_time;
          if (!TV_isMainTimerWorking) {
            TV_isMainTimerWorking = true;
          }
          NAVIGATION_openTimerPageOnTheTopOfTheStack();
          STATE_timerClockRunningPage!(() {});

          Navigator.pop(context);
        },
      )
    ],
  );
}

// timer running on each page

// void custom_showDialog({required BuildContext context}) {

//   showGeneralDialog(

//     barrierLabel: "Barrier",
//     barrierDismissible: false,
//     barrierColor: Colors.black.withOpacity(0.5),
//     transitionDuration: Duration(milliseconds: 700),
//     context: context,
//     pageBuilder: (_, __, ___) {
//       return cutomDiaglog(context:context);
//     },
//     transitionBuilder: (_, anim, __, child) {
//       return SlideTransition(
//         position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
//         child: child,
//       );
//     },
//   );

// }

// Widget cutomDiaglog ({required BuildContext context}){
//   return CupertinoAlertDialog(

//     title: Text('Title'),
//     content: Container(
//         height: 100,
//         width: 100,
//         color: Colors.black,
//       ),
//     actions: [
//       CupertinoDialogAction(child: Text('no'),onPressed: (){customPrint('NO');},),
//             CupertinoDialogAction(child: Text('YES'),onPressed: (){customPrint('YES'); Navigator.pop(context);},)

//     ],
//   );

// }
