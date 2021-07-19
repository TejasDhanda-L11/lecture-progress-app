import 'dart:async';

import 'package:lecture_progress/mainImplementation/allStates/statesOfAllPages.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart';
import 'package:custom_database_lecture_progress/DatabaseQueries/DatabaseQueries.dart';
import 'package:lecture_progress/resources/functions/global_functions/timerCompleteDialog_func.dart';
import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/resources/notification_functionality/timer_notifications.dart';

void onTimerStart() {
  TV_checkerTimer = Timer.periodic(Duration(seconds: 1), (timer) {
    TV_timerInstance = timer;
    if (TV_howLong > TV_timeSpent) {
      onTimerRunning();
    } else {
      onTimerComplete();
    }
  });
  TV_isTimerCheckerRunning = true;
}

void onTimerRunning() {
  TV_timeSpent += Duration(seconds: 1);
  // customPrint(
  // '${TV_timeSpent.inSeconds} // ${TV_howLong.inSeconds}');
  showOngoingTimerNotification(
      message_to_show:
          '${durationToStringTime(duration: (TV_howLong - TV_timeSpent))} timer has completed');
  // top of the page timer

  STATE_TopTimerWidget!(() {});

  if (STATE_timerClockRunningPage.toString() != 'Closure: () => Null') {
    try {
      STATE_timerClockRunningPage!(() {});
    } catch (e) {
      customPrint(e,
          object2: 'ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ');
    }
  }
}

void onTimerComplete() {
// debugPrint('done with timer ------------------------');
  if (TV_isStudyingAtPresent) {
    TV_studied_last_time = true;
  } else if (TV_isTakingBreakAtPresent) {
    TV_studied_last_time = false;
  }
  TV_isStudyingAtPresent = false;
  TV_isTakingBreakAtPresent = false;
  TV_isTimerCheckerRunning = false;
  TV_isMainTimerWorking = false;
  TV_timeSpent = Duration.zero;

  if (TV_studied_last_time) {
    updateTimeStudiedInDB(
            database: gapv_dbInstance!,
            date: dateTimeIn_dd_mm_yyyy_formatNow(),
            studyTimeToBeAdded: TV_howLong)
        .then((value) => () async {
              customPrint('alpha 1');
              TV_studiedTime = await getHoursStudiedFromDayLoggerDB(
                  date: dateTimeIn_dd_mm_yyyy_formatNow(),
                  database: gapv_dbInstance!);
              customPrint('alpha 2');
              customPrint(TV_studiedTime);

              STATE_TopTimerWidget!(() {});
              customPrint('alpha 3');
            }.call());
  }

  timerCompleteDailog();

  showTimerCompleteNotification(
      message_to_show:
          '${durationToStringTime(duration: TV_howLong)} timer has completed');
  TV_timerInstance.cancel();
  TV_howLong = Duration.zero;
  STATE_TopTimerWidget!(() {});
  if (STATE_timerClockRunningPage!.toString() != 'Closure: () => Null') {
    try {
      STATE_timerClockRunningPage!(() {});
    } catch (e) {
      customPrint(e,
          object2: 'ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ERROR  ');
    }
  }
}
