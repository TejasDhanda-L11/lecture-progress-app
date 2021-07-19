import '../DatabaseHelper.dart';

Future<List> databaseInitializer() async {
  LectureProgressHelper _lectureProgressHelper = LectureProgressHelper();
  return await _lectureProgressHelper.database.then((value) {
    print('database__________________initialised__________________________');
    // gapv_dbInstance = value;
    // gapv_isDBInitialised = true;
    return [value,true];
  });
}
