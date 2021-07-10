import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lecture_progress/main.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/temp_variables_timer.dart';

Future showTimerCompleteNotification({required String message_to_show}) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'channel timerId',
    'channel timerName',
    'your channel timerDescription',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
      TV_notificationId, 'Timer', message_to_show, platformChannelSpecifics,
      payload: 'item x');
}

Future showOngoingTimerNotification({required String message_to_show}) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('channel timerId', 'channel timerName',
          'your channel timerDescription',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          ongoing: true,
          enableVibration: false,
          playSound: false,
          onlyAlertOnce: true,
          // usesChronometer: true,
          timeoutAfter: 2000,
          );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    TV_onGoingTimerNotificationID,
    'Timer Ongoing',
    message_to_show,
    platformChannelSpecifics,
    payload: 'item x',
  );
}
