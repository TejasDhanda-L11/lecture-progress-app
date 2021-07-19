import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';
import 'package:lecture_progress/resources/database/HomePageDB.dart';

Future<void> databaseInitializer() async {
  LectureProgressHelper _lectureProgressHelper = LectureProgressHelper();
  await _lectureProgressHelper.database.then((value) async {
    print('database__________________initialised__________________________');
    gapv_dbInstance = value;
    gapv_isDBInitialised = true;
  });
}
