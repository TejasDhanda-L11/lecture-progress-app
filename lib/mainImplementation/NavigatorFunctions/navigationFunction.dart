import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/routes/routes.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';

// Timer Page Navigation
void NAVIGATION_openTimerPageOnTheTopOfTheStack() {
  Navigator.pushNamed(gapv_presentlyTopContext!, RouteManager.timerPage);
}
// Intent Recieving Pages Navigation
void NAVIGATION_openSubjectSelectionForYoutubePlaylistIntentOnTopOfStack() {
  Navigator.pushNamed(
      gapv_presentlyTopContext!, RouteManager.chooseSubjectForYoutubePlaylist);
}

// On Back Button
void NAVIGATION_onBackButtonChaptersPage() {
  NAVIGATION_popAndPushToSubjectPage();
}
void NAVIGATION_onBackButtonYoutubeVideoPlaying() {
  NAVIGATION_popAndPushToAllSpecificChapterVideos();
}
void NAVIGATION_onBackButtonAllChapterSpecificVideos() {
  NAVIGATION_popAndPushToChaptersPage();
}

// Pop and Push
void NAVIGATION_popAndPushToChaptersPage() {
  NAVIGATION_popAndGoToPage(routeName: RouteManager.chaptersPage);
}
void NAVIGATION_popAndPushToYoutubeVideoPlaying() {
  NAVIGATION_popAndGoToPage(routeName: RouteManager.singleVideoCustomPlayer);
}
void NAVIGATION_popAndPushToSubjectPage() {
  NAVIGATION_popAndGoToPage(routeName: RouteManager.homePage);
}
void NAVIGATION_popAndPushToAllSpecificChapterVideos() {
  NAVIGATION_popAndGoToPage(
      routeName: RouteManager.allVideosSpecificChapterPage);
}

// General Navigation
void NAVIGATION_popTopContext() {
  Navigator.pop(gapv_presentlyTopContext!);
}

void NAVIGATION_popAndGoToPage({required String routeName}) {
  Navigator.popAndPushNamed(gapv_presentlyTopContext!, routeName);
}
