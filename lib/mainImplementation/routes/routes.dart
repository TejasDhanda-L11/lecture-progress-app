import 'package:custom_youtube_player_page/CustomYoutubePlayerTemp.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/mainImplementation/pages/ChaptersPage.dart';
import 'package:lecture_progress/mainImplementation/pages/SubjectPage.dart';
import 'package:lecture_progress/mainImplementation/pages/allVideosSpecificChapter.dart';
import 'package:lecture_progress/mainImplementation/pages/calender_page.dart';
import 'package:lecture_progress/mainImplementation/pages/chooseChapterForIntentYotubePlaylist_Page.dart';
import 'package:lecture_progress/mainImplementation/pages/timer_page.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/resources/packageConnection/CONNECTION_timer_running_top_of_page_widget.dart';
import 'package:lecture_progress/resources/packageConnection/YoutubePlayer/CHANGER_STATE_YoutubeVideoPlaying.dart';
import 'package:lecture_progress/resources/packageConnection/YoutubePlayer/CHANGER_gapv_isVideoDone.dart';
import 'package:lecture_progress/resources/packageConnection/YoutubePlayer/CHANGER_gapv_presentlyLast_Top_Before_opening_Timer_Context.dart';
import 'package:lecture_progress/resources/packageConnection/YoutubePlayer/CHANGER_gapv_presentlyTopContext.dart';

class RouteManager {
  static const String subjectPage = '/';
  static const String chaptersPage = '/chaptersPage';
  static const String allVideosSpecificChapterPage =
      '/allVideosSpecificChapterPage';
  static const String singleVideoCustomPlayer = '/singleVideoCustomPlayer';
  static const String timerPage = '/timerPage';
  static const String calenderPage = '/calenderPage';
  // static const String intentFromYoutubePlaylist = '/intentFromYoutubePlaylist';
  static const String chooseSubjectForYoutubePlaylist =
      '/chooseSubjectForYoutubePlaylist';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Map<dynamic, dynamic>? valuePassed;

    // if (settings.arguments != null) {
    //   valuePassed = settings.arguments as Map<dynamic, dynamic>;
    // }

    switch (settings.name) {
      // case intentFromYoutubePlaylist:
      //   return MaterialPageRoute(builder: (context) => gotYoutubePlaylistIntentPage());
      case chooseSubjectForYoutubePlaylist:
        return MaterialPageRoute(
            builder: (context) => ChooseChapterForIntentYotubePlaylistPage());
      case subjectPage:
        return MaterialPageRoute(builder: (context) => SubjectPage());

      case chaptersPage:
        return MaterialPageRoute(
            builder: (context) => ChaptersPage(
                  subject_id: gapv_subject_presently_id!,
                  db: gapv_dbInstance!,
                ));

      case allVideosSpecificChapterPage:
        return MaterialPageRoute(
            builder: (context) => AllVideoSpecificChapter(
                  dbInstance: gapv_dbInstance!,
                  subject_id: gapv_subject_presently_id!,
                  chapter_id: gapv_chapter_presently_id!,
                ));

      case singleVideoCustomPlayer:
        return MaterialPageRoute(
            builder: (context) => CustomYoutubePlayer_Temp(
                  dataReq_youtubePlayer: gapv_dataReq_youtubePlayer!,
                  dbInstance: gapv_dbInstance!,
                  loadingScreen: gapv_loadingScreen,
                  CHANGER_STATE_YoutubeVideoPlaying:
                      CHANGER_STATE_YoutubeVideoPlaying,
                  NAVIGATION_onBackButtonYoutubeVideoPlaying:
                      NAVIGATION_onBackButtonYoutubeVideoPlaying,
                  NAVIGATION_popTopContext: NAVIGATION_popTopContext,
                  NAVIGATION_openTimerPageOnTheTopOfTheStack:
                      NAVIGATION_openTimerPageOnTheTopOfTheStack,
                  CHANGER_gapv_presentlyTopContext:
                      CHANGER_gapv_presentlyTopContext,
                  CHANGER_gapv_presentlyLast_Top_Before_opening_Timer_Context:
                      CHANGER_gapv_presentlyLast_Top_Before_opening_Timer_Context,
                  Changer_gapv_isVideoDone: CHANGER_gapv_isVideoDone,
                  TimerStatusOnTopOfPage: TimerStatusOnTopOfPage(),
                ));

      case timerPage:
        return MaterialPageRoute(builder: (context) => TimerPage());

      case calenderPage:
        return MaterialPageRoute(builder: (context) => CalenderPage());

      default:
        throw FormatException('Wrong route, route doesn\'t exist');
    }
  }
}
