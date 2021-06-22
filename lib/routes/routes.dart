import 'package:flutter/material.dart';
import 'package:lecture_progress/extra/youtubePlayer.dart';
import 'package:lecture_progress/modal_classes/databaseUnit.dart';
import 'package:lecture_progress/pages/ChaptersPage.dart';
import 'package:lecture_progress/pages/HomePage.dart';
import 'package:lecture_progress/pages/allVideosSpecificChapter.dart';

class RouteManager {
  static const String homePage = '/';
  static const String chaptersPage = '/chaptersPage';
  static const String allVideosSpecificChapterPage =
      '/allVideosSpecificChapterPage';
  static const String singleVideoCustomPlayer = '/singleVideoCustomPlayer'; 

  


  static Route<dynamic> generateRoute(RouteSettings settings) {

    Map<dynamic, dynamic>? valuePassed;

    if (settings.arguments != null){
      valuePassed = settings.arguments as Map<dynamic, dynamic>;
    }

    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (context) => HomePage());

      case chaptersPage:
        return MaterialPageRoute(builder: (context) => ChaptersPage(listOfChapters: valuePassed?['listOfInstances_H2C'] ?? <DatabaseUnit>[],));

      case allVideosSpecificChapterPage:
        return MaterialPageRoute(builder: (context) => AllVideoSpecificChapter(listOfLecture: valuePassed?['listOfInstances_C2AVSC'] ?? <DatabaseUnit>[],));

      case singleVideoCustomPlayer:
        return MaterialPageRoute(builder: (context) => CustomYoutubePlayer(urlToVideoServer: valuePassed?['videoSpecificInstance'] ?? <DatabaseUnit>[],));

      default:
        throw FormatException('Wrong route, route doesn\'t exist');
    }
  }
}
