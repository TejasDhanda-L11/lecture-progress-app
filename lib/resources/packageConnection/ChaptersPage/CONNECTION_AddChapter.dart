import 'package:custom_AWSApi_lecture_progress_app/awsApiToDB.dart';
import 'package:sqflite/sqflite.dart';

void AddChapter_Function_OnSubmitted(
    {required String text,
    required Database database,
    required int subject_id,
    required Function? STATE_ChaptersPage}) async {
  await AWSApiToDB(playlistUrl: text)
      .AWSApiToDB_func(dbInstance: database, subject_id: subject_id);
  STATE_ChaptersPage!(() {});
}
