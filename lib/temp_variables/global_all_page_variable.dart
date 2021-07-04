import 'package:sqflite/sqflite.dart';

bool gapv_isDBInitialised = false;
Database? gapv_dbInstance;
int? gapv_subject_presently_id;
int? gapv_chapter_presently_id;
Map<String,dynamic>? gapv_dataReq_youtubePlayer;