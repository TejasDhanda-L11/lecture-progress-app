import 'dart:async';



//////// Timer_Page Variables
Duration TV_howLong = Duration.zero;
Duration TV_timeSpent = Duration.zero;

late Timer TV_timerInstance;


bool TV_isMainTimerWorking = false;
bool TV_isTimerCheckerRunning = false;
bool TV_isTimerPaused = false;

bool TV_isLastPageStillActive = false;

Timer? TV_checkerTimer;

bool TV_showPomondoroPicker = true;

// Pomondoro Stuff
bool TV_isStudyingAtPresent = false;
bool TV_isTakingBreakAtPresent = false;

bool TV_studied_last_time = false;
int TV_currentPomondoroTimer_id = 1;



// notification
int TV_notificationId = 1;
int TV_onGoingTimerNotificationID = 2;




// top timer on pages

late Duration TV_studiedTime;

