import 'dart:async';

import 'package:lecture_progress/resources/database/DatabaseQueries/DatabaseQueries.dart';


//////// Timer_Page Variables
Duration howLong = Duration.zero;
Duration timeSpent = Duration.zero;

// ignore: non_constant_identifier_names
late Function setState_c_func;

bool isMainTimerWorking = false;
bool isTimerCheckerRunning = false;
bool isTimerPaused = false;

bool isLastPageStillActive = false;

Timer? checkerTimer;

bool showPomondoroPicker = true;

// Pomondoro Stuff
bool isStudyingAtPresent = false;
bool isTakingBreakAtPresent = false;

bool studied_last_time = false;
int currentPomondoroTimer_id = 1;



// notification
int notificationId = 1;
int onGoingTimerNotificationID = 2;




// top timer on pages
late Function setState_TOP_TIMER_WIDGET_func;

late Duration TVT_studiedTime;

