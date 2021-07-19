import 'package:custom_AWSApi_lecture_progress_app/awsApiToDB.dart';
import 'package:sqflite/sqflite.dart';

void AddSubject_Function_OnSubmitted(
    {required String text,
    required Database database,
    required Function? State_SubjectsPage}) async {

  await database
      .rawQuery('INSERT INTO subjects(subject_name) VALUES ("$text")');
  State_SubjectsPage!(() {});
}
