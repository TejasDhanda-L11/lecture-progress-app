import 'package:flutter/material.dart';
import 'package:lecture_progress/extra/youtubePlayer.dart';
import 'package:lecture_progress/routes/routes.dart';

import 'pages/ChaptersPage.dart';
import 'pages/HomePage.dart';
import 'pages/allVideosSpecificChapter.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   '/home' : (context) => HomePage(),
      //   '/chapters' : (context) => ChaptersPage(),
      //   '/specificChapterVideos': (context) => AllVideoSpecificChapter(linkToPlaylist: ,)
      // },
      initialRoute: RouteManager.homePage,
      onGenerateRoute: RouteManager.generateRoute,
      debugShowCheckedModeBanner: false,

    );
  }
}
