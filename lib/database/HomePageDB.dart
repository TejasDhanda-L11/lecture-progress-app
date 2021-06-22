import 'package:sqflite/sqflite.dart';

final String _databaseName = 'lectureProgress.db';
final int _databaseVersion = 1;
final String databaseTableName = 'allData';

final String columnId = 'id';
final String columnSubject = 'subjectTitle';
final String columnChapterTitle = 'chapterTitle';
final String columnChapterPlaylistUrl = 'chapterPlaylistUrl';
final String columngLectureTitle = 'lectureTitle';
final String columngLectureUrl = 'lectureUrl';





class LectureProgressHelper {


  static Database? _database;
  static LectureProgressHelper?  lectureProgressHelper;

  LectureProgressHelper._createInstance();
  factory LectureProgressHelper(){
    return lectureProgressHelper ?? LectureProgressHelper._createInstance();
  }


  Future<Database> get database async {
    return _database ?? await initialiseDatabase();

  }

  Future<Database> initialiseDatabase() async{
    String initialPrefixPath = await getDatabasesPath();
    String pathToDatabase = '${initialPrefixPath}/${_databaseName}';
    print('pathToDatabase = $pathToDatabase');
    return await openDatabase(pathToDatabase, version: _databaseVersion, onCreate: (db, version) {
      db.execute(
        '''
        CREATE TABLE $databaseTableName (
          $columnId integer primary key autoincrement,
          $columnSubject text not null,
          $columnChapterTitle text not null,
          $columnChapterPlaylistUrl text not null,
          $columngLectureTitle text not null,
          $columngLectureUrl text not null
          )
        '''
      );

      
    },);
  } // initialise database










  // // CRUD functions
  // // C
  // void insertAlarm(AlarmInfo alarmInfo) async {
  //   var db = await this.database;
  //   var result = await db.insert(databaseTableName, alarmInfo.toMap());
  //   print('result : $result');
  // }















  // // R
  // Future<List<AlarmInfo>> getAlarms() async {
  //   List<AlarmInfo> _alarms = [];

  //   var db = await this.database;
  //   var result = await db.query(databaseTableName);
  //   result.forEach((element) {
  //     print('RAW_ELEMENTS_FROM_DATABASE = $element');
      
  //     var alarmInfoToMapDB = AlarmInfo.fromMap(element);
  //     print('alarmInfoToMapDB = ${alarmInfoToMapDB.isActive}');
  //     _alarms.add(alarmInfoToMapDB);

  //   });

  //   return _alarms;
  // }












  // // U
  // Future<int> updateDB({required Map<String,dynamic> new_values, required int id}) async {
  //   var db = await this.database;
  //   print('COMPLETE_MAP = $new_values');
  //   print('id_of_change = $id');
  //   return await db.update( databaseTableName, new_values, where: '$columnId = ?', whereArgs: [id] );//(databaseTableName, where: '$columnId = ?', whereArgs: [id]);
  // }










  // // D
  // Future<int> delete(int id) async {
  //   var db = await this.database;
  //   return await db.delete(databaseTableName, where: '$columnId = ?', whereArgs: [id]);
  // }









}
