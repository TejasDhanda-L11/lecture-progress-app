// update timeStudied to DB
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:sqflite/sqflite.dart';

// Future<void> updateTimeStudiedDayLogger(
//     {required Database dbInstance,
//     required String newTimeValue,
//     required int ID_ofTheDayLogger}) async {
//   await dbInstance.rawQuery('''
//       UPDATE day_logger
//         SET hours_studied = "${newTimeValue}"
//         WHERE id = ${ID_ofTheDayLogger}
//     ''');
// }

// get id based on the date
Future<Duration> getHoursStudiedFromDayLoggerDB(
    {required Database database, required String date}) async {
  List<Map<String, dynamic>> responseOfDB = (await database.rawQuery('''
      SELECT hours_studied from day_logger
      WHERE date = '$date'
    '''));
    if (responseOfDB.length == 0){
      return Duration.zero ;
    } else {
      return stringToDurationDB(duration: responseOfDB[0]['hours_studied']);
    }
    
}

Future<void> updateTimeStudiedInDB(
    {required Database database,
    required String date,
    required Duration studyTimeToBeAdded}) async {
  String hoursStudiedToBeAdded_String =
      durationToStringTimeDB(duration: studyTimeToBeAdded);

  List<Map<String, dynamic>> dataFromThatSpecificDayLog =
      await database.rawQuery('''
    SELECT * FROM day_logger
    WHERE date = '${date}'
  ''');
  customPrint(dataFromThatSpecificDayLog,object2: 'database stuff 1');
  if (dataFromThatSpecificDayLog.length == 0) {
    await database.rawQuery('''
        INSERT INTO day_logger(date, hours_studied)
        VALUES ('${date}','${hoursStudiedToBeAdded_String}');
      ''');
  } else {
    Duration previousStudiedHours = stringToDurationDB(
        duration: dataFromThatSpecificDayLog[0]['hours_studied']);
    String timeToUpdatedInDB_string = durationToStringTimeDB(
        duration: previousStudiedHours + studyTimeToBeAdded);
    await database.rawQuery('''
        UPDATE day_logger
        SET hours_studied = '${timeToUpdatedInDB_string}'
        where date = '${date}';
      ''');
  }
  customPrint(await database.rawQuery('SELECT * FROM day_logger'),
      object2: 'DATABASE DAYLOGGER');
}
