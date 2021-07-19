// import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:sqflite/sqflite.dart';

import '../HomePageDB.dart';

Future<List> databaseInitializer() async {
  LectureProgressHelper _lectureProgressHelper = LectureProgressHelper();
  return await _lectureProgressHelper.database.then((value) {
    print('database__________________initialised__________________________');
    // gapv_dbInstance = value;
    // gapv_isDBInitialised = true;
    return [value,true];
  });
}
