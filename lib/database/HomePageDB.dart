// import 'package:sqflite/sqflite.dart';

// final String _databaseName = 'HomePageDB.db';
// final int _databaseVersion = 1;
// final String _databaseTableName = 'HomePageDB';
// final String subject = 'subject';
// final String columnId = 'id';






// class AlarmHelper {

//   static Database? _database;
//   static AlarmHelper? _alarmHelper;

//   AlarmHelper._createInstance();
//   factory AlarmHelper(){
//     return _alarmHelper ?? AlarmHelper._createInstance();
//   }


//   Future<Database> get database async {
//     return _database ?? await initialiseDatabase();

//   }

//   Future<Database> initialiseDatabase() async{
//     String initialPrefixPath = await getDatabasesPath();
//     String pathToDatabase = '${initialPrefixPath}/${_databaseName}';
//     print('pathToDatabase = $pathToDatabase');
//     return await openDatabase(pathToDatabase, version: _databaseVersion, onCreate: (db, version) {
//       db.execute(
//         '''
//         CREATE TABLE $_databaseTableName (
//           $columnId integer primary key autoincrement,
//           $subject text not null,)

//         '''
//       );
//     },);
//   } // initialise database










//   // CRUD functions
//   // C
//   void insertAlarm(String subject) async {
//     var db = await this.database;
//     var result = await db.insert(_databaseTableName, alarmInfo.toMap());
//     print('result : $result');
//   }
//   // R
//   Future<List<AlarmInfo>> getAlarms() async {
//     List<AlarmInfo> _alarms = [];

//     var db = await this.database;
//     var result = await db.query(_databaseTableName);
//     result.forEach((element) {
//       print('RAW_ELEMENTS_FROM_DATABASE = $element');
      
//       var alarmInfoToMapDB = AlarmInfo.fromMap(element);
//       print('alarmInfoToMapDB = ${alarmInfoToMapDB.isActive}');
//       _alarms.add(alarmInfoToMapDB);

//     });

//     return _alarms;
//   }
//   // U
//   Future<int> updateDB({required Map<String,dynamic> new_values, required int id}) async {
//     var db = await this.database;
//     print('COMPLETE_MAP = $new_values');
//     print('id_of_change = $id');
//     return await db.update( _databaseTableName, new_values, where: '$columnId = ?', whereArgs: [id] );//(_databaseTableName, where: '$columnId = ?', whereArgs: [id]);
//   }
//   // D
//   Future<int> delete(int id) async {
//     var db = await this.database;
//     return await db.delete(_databaseTableName, where: '$columnId = ?', whereArgs: [id]);
//   }









// }





















// // import 'package:clockapp/modalclasses/alarm_info.dart';
// // import 'package:sqflite/sqflite.dart';
// // import 'package:sqflite/sqlite_api.dart';

// // final String tableAlarm = 'alarm';
// // final String columnId = 'id';
// // final String columnDescription = 'Description';
// // final String columnalarmDateTime = 'alarmDateTime';
// // final String columnisActive = 'isActive';
// // final String columngradientgradientColorIndex = 'gradientColorIndex';

// // class AlarmHelper {
// //   static Database? _database;
// //   static AlarmHelper? _alarmHelper;

// //   AlarmHelper._createInstance();
// //   factory AlarmHelper() {
// //     return _alarmHelper ?? AlarmHelper._createInstance();
// //   }

// //   Future<Database> get database async {
// //     return _database ?? await initializeDatabase();
// //   }

// //   Future<Database> initializeDatabase() async {
// //     var dir = await getDatabasesPath();
// //     var path = dir + "alarm.db";

// //     var database = await openDatabase(
// //       path,
// //       version: 1,
// //       onCreate: (db, version) {
// //         db.execute('''
// //           create table $tableAlarm ( 
// //           $columnId integer primary key autoincrement, 
// //           $columnDescription text not null,
// //           $columnalarmDateTime text not null,
// //           $columnisActive integer,
// //           $columngradientColorIndex integer)
// //         ''');
// //       },
// //     );
// //     return database;
// //   }

// //   void insertAlarm(AlarmInfo alarmInfo) async {
// //     var db = await this.database;
// //     var result = await db.insert(tableAlarm, alarmInfo.toMap());
// //     print('result : $result');
// //   }

// //   Future<List<AlarmInfo>> getAlarms() async {
// //     List<AlarmInfo> _alarms = [];

// //     var db = await this.database;
// //     var result = await db.query(tableAlarm);
// //     result.forEach((element) {
// //       var alarmInfo = AlarmInfo.fromMap(element);
// //       _alarms.add(alarmInfo);
// //     });

// //     return _alarms;
// //   }

// //   Future<int> delete(int id) async {
// //     var db = await this.database;
// //     return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
// //   }
// // }