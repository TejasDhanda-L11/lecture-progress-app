import 'dart:async';


// Timer_Page Variables
Duration howLong = Duration(seconds: 1);
Duration timeSpent = Duration.zero;

// ignore: non_constant_identifier_names
late Function setState_c_func;

bool isMainTimerWorking = false;
bool isTimerCheckerRunning = false;
bool isTimerPaused = false;

bool isLastPageStillActive = false;

Timer? checkerTimer;

int notificationId = 1;
int onGoingTimerNotificationID = 2;

// top timer on pages
late Function setState_TOP_TIMER_WIDGET_func;
