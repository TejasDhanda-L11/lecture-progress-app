import 'package:flutter/material.dart';
import 'package:lecture_progress/extra/youtubePlayer.dart';
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
        return MaterialPageRoute(builder: (context) => ChaptersPage(subject_id: valuePassed?['subject'] ?? 1, db: valuePassed?['dbInstance'] ?? 'none is subject',));
      
      case allVideosSpecificChapterPage:
        return MaterialPageRoute(builder: (context) => AllVideoSpecificChapter(dataRequiredEL : valuePassed?['dataRequiredEL'] ?? 1));
      
      case singleVideoCustomPlayer:
        return MaterialPageRoute(builder: (context) => CustomYoutubePlayer(dataReq_youtubePlayer: valuePassed?['dataReq_youtubePlayer'] ?? 1,));

      

      default:
        throw FormatException('Wrong route, route doesn\'t exist');
    }
  }
}
