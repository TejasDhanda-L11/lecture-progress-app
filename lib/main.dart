import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/intentRelated/YotubePlaylistIntentRelated.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:lecture_progress/mainImplementation/routes/routes.dart';
import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'mainImplementation/temp_variables/intentRelated/YotubePlaylistIntentRelated.dart';
//link to server =
// http://13.127.186.252:8080/pl?l=https://www.youtube.com/playlist?list=PLF_7kfnwLFCEQgs5WwjX45bLGex2bLLwY

// var loggerNoStack = Logger(
//   printer: PrettyPrinter(methodCount: 0),
// );

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  // notification
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('lecture_progress_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
//

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String? _sharedText;

  @override
  void initState() {
    super.initState();

    StreamSubscription? _intentDataStreamSubscription;
    List<SharedMediaFile>? _sharedFiles;

    customPrint('yoyoyoyoyoyoyoyoyoyoyoyoyoyoyoyoyoyoyoyoyoyoyo');

// // For sharing images coming from outside the app while the app is in the memory
    // _intentDataStreamSubscription =
    //     ReceiveSharingIntent.getMediaStream().listen((List<SharedMediaFile> value) {
    //   setState(() {
    //     customPrint("Shared:" + (_sharedFiles?.map((f)=> f.path).join(",") ?? ""));
    //     _sharedFiles = value;
    //   });
    // }, onError: (err) {
    //   customPrint("getIntentDataStream error: $err");
    // });

    // // For sharing images coming from outside the app while the app is closed
    // ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
    //   setState(() {
    //     _sharedFiles = value;
    //   });
    // });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        // ReceiveSharingIntent.getTextStreamAsUri().listen((String value) {
        ReceiveSharingIntent.getTextStream().listen((String value) {
      customPrint(value);
      YPIR_youtubePlaylistLink = value;
      NAVIGATION_openSubjectSelectionForYoutubePlaylistIntentOnTopOfStack();

      // setState(() {
      //   _sharedText = value;
      // });
    }, onError: (err) {
      customPrint("getLinkStream error: $err");
    });
    // _intentDataStreamSubscription =
    //     ReceiveSharingIntent.getTextStreamAsUri().listen(( value) {
    //     print(value);
    // }, onError: (err) {
    //   customPrint("getLinkStream error: $err",object2: 'eroor1');
    // });
    // _intentDataStreamSubscription =
    //     ReceiveSharingIntent.getMediaStream().listen(( value) {
    //       customPrint(value);
    // }, onError: (err) {
    //   customPrint("getLinkStream error: $err");
    // });
    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((value) {
      if (value != null) {
        customPrint(value);
        YPIR_youtubePlaylistLink = value;
        NAVIGATION_openSubjectSelectionForYoutubePlaylistIntentOnTopOfStack();
      } else {
        customPrint('got nothing as intent');
      }
    });

    // customPrint(ReceiveSharingIntent.getInitialMedia(),object2: 'ReceiveSharingIntent.getInitialMedia');
    // customPrint(ReceiveSharingIntent.getInitialText(),object2: 'ReceiveSharingIntent.getInitialMedia');
    // customPrint(ReceiveSharingIntent.getInitialTextAsUri(),object2: 'ReceiveSharingIntent.getInitialMedia');
    // customPrint(ReceiveSharingIntent.getMediaStream(),object2: 'ReceiveSharingIntent.getInitialMedia');
    // customPrint(ReceiveSharingIntent.getTextStream(),object2: 'ReceiveSharingIntent.getInitialMedia');
    // customPrint(ReceiveSharingIntent.getTextStreamAsUri(),object2: 'ReceiveSharingIntent.getInitialMedia');
    // customPrint(ReceiveSharingIntent.(),object2: 'ReceiveSharingIntent.getInitialMedia');

    customPrint('initialised recieve intent');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteManager.homePage,
      onGenerateRoute: RouteManager.generateRoute,
      debugShowCheckedModeBanner: false,
      // home: TimerPage()
    );
  }
}
