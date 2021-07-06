import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lecture_progress/main.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;















Future show_notification_now() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false);

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
      0, 'plain title', 'plain body', platformChannelSpecifics,
      payload: 'item x');
}








































Future show_notification_after_specified_time({required Duration after_how_much_time}) async {

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(after_how_much_time),
        const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime
    
    );
}






























Future show_notification_at({
  required DateTime atThisDateTime, 
  int id = 0, 
  String scheduledTitle = 'scheduled title',
  String scheduledBody = 'scheduled body',
  }) 
  async {

    await flutterLocalNotificationsPlugin.schedule(
        id,
        scheduledTitle,
        scheduledBody,
        atThisDateTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name', 
            'your channel description',
            color: Colors.black,
            fullScreenIntent: true,
            playSound: true,
            )),
        androidAllowWhileIdle: true,
        
    
    );
}

































Future periodically_show_notification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('repeating channel id',
          'repeating channel name', 'repeating description');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
      'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics,
      androidAllowWhileIdle: true);
}