import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

bool gapv_isDBInitialised = false;
Database? gapv_dbInstance;
int? gapv_subject_presently_id;
int? gapv_chapter_presently_id;

// Youtube Player Specific
Map<String,dynamic>? gapv_dataReq_youtubePlayer;
bool? gapv_isVideoDone;
Duration gapv_psotionToSeekTo = Duration.zero;


// Alert Dialog Box Related
BuildContext? gapv_presentlyTopContext;
BuildContext? gapv_presentlyLast_Top_Before_opening_Timer_Context;

// If Chapters Page is ON or Not 
bool gapv_isChaptersPageOn = false;
