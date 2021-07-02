import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

final String _databaseName = 'lectureProgress.db';
final int _databaseVersion = 7;
// checking if a new database is created on increasing the number


class LectureProgressHelper {

  bool deletePreviousDB = true;
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
    // print('pathToDatabase = $pathToDatabase');
    if (deletePreviousDB) {
      await deleteDatabase(pathToDatabase);
      debugPrint('delete previous database completely ---------------------------------------------------');
    }
    
    return await openDatabase(pathToDatabase, version: _databaseVersion, onCreate: (db, version) async {
      debugPrint('creating a completely new database ---------------------------------------------------');

      await db.execute(
        '''
        CREATE TABLE "subjects" (
          "id"	INTEGER,
          "subject_name"	VARCHAR(50) NOT NULL UNIQUE,
          PRIMARY KEY("id")
        );
        '''
      );
      await db.execute(
        '''
        CREATE TABLE "chapters" (
          "id"	INTEGER PRIMARY KEY AUTOINCREMENT,
          "subject_id"	INTEGER NOT NULL,
          "chapter_name"	VARCHAR(50) NOT NULL UNIQUE,
          "playlist_url"	VARCHAR(250) NOT NULL,
          "uploader_name" VARCHAR(50) ,
          "number_of_lectures" INTEGER,
          "chapterCompleted" TEXT CHECK(chapterCompleted IN ('T','F')) NOT NULL DEFAULT 'F',
          "lengthCompletedLecture" TIME NOT NULL DEFAULT '00-00-00',
          "videosCompleted" INTEGER NOT NULL DEFAULT 0,
          FOREIGN KEY("subject_id") REFERENCES "subjects"("id")
        );
        '''
      );
      await db.execute(
        '''
        CREATE TABLE "specific_videos" (
          "id"	INTEGER PRIMARY KEY AUTOINCREMENT,
          "chapter_id"	INTEGER NOT NULL,
          "subject_id"	INTEGER NOT NULL,
          "video_lecture_number"	INTEGER NOT NULL,
          "video_url"	VARCHAR(500) NOT NULL UNIQUE,
          "video_title"	VARCHAR(50) NOT NULL UNIQUE,
          "chapter_description_box"	VARCHAR(500) NOT NULL DEFAULT 'none',
          "notes_location"	VARCHAR(100) NOT NULL ,
          "duration" INTEGER,
          "thumbnail" VARCHAR(500),
          "lectureCompleted" TEXT CHECK(lectureCompleted IN ('T','F')) NOT NULL DEFAULT 'F',
          "lengthCompletedLecture" TIME NOT NULL DEFAULT '00-00-00',
          FOREIGN KEY("chapter_id") REFERENCES "chapters"("id"),
          FOREIGN KEY("subject_id") REFERENCES "subjects"("id")
        );
        '''
      );
      await db.execute(
        '''
        INSERT INTO subjects(subject_name)
          VALUES ('physics'),('mathematics'),('chemistry');
        '''
      );
      // await db.execute(
      //   '''
        // INSERT INTO chapters(subject_id,chapter_name,playlist_url)
        //   VALUES (1,'Gravitaion','https://www.youtube.com/playlist?list=PLF_7kfnwLFCEwyxzG-rg2uYeYA2q1S2d8'),
        //   (2,'calculus','https://www.youtube.com/playlist?list=PL0-GT3co4r2wlh6UHTUeQsrf3mlS2lk6x'),
        //   (3,'atomic structure','https://www.youtube.com/playlist?list=PLF_7kfnwLFCFnjki8KSeTQHyJ7OkdBdNA');
        // '''
      // );
      // await db.execute(
      //   '''
        // INSERT INTO specific_videos(subject_id,
        //   chapter_id,
        //   video_lecture_number,
        //   video_title,
        //   video_url,
        //   notes_location
        //   )
        //   VALUES 
        //   (1,1,1,'first gra',"https://r4---sn-cvh76ney.googlevideo.com/videoplayback?expire=1625012425&ei=aWTbYP24HcX54-EP6OmJkA8&ip=65.1.86.82&id=o-ADgjMJpX9RPHnU862c_kh-MLP8uhjj0eBD5ZztYa2_gE&itag=22&source=youtube&requiressl=yes&mh=2c&mm=31%2C29&mn=sn-cvh76ney%2Csn-cvh7kney&ms=au%2Crdu&mv=m&mvi=4&pl=14&initcwndbps=643750&vprv=1&mime=video%2Fmp4&ns=U-N5vRqEWFloFaPFA9Uf7m4G&cnr=14&ratebypass=yes&dur=4944.550&lmt=1581017907918123&mt=1624990614&fvip=4&fexp=24001373%2C24007246&c=WEB&txp=5511222&n=jSvtuSs2pRuM7elUwqig6&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRAIgSQGqJZGan30JXdoNHRYBgX_f_eIrEL6i87IH6C1r2zYCID8-hTDKKoLACXi2eJcOJAZYfDW2qRneNQgON808qW1b&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAMgdkEwtWFf-DoB50uJdanB1bPUNhqh1Kj1EYW6Oq5CvAiEA33wtYKsE9BaitRaMDCBUJwMc5c0zRGhzBDkv94RWc_s%3D",'none at present 1' ),
        //   (2,2,1,'first cal',"https://r5---sn-cvh76nek.googlevideo.com/videoplayback?expire=1625012585&ei=CWXbYKvnB-394-EPoKG0sA4&ip=65.1.86.82&id=o-AOoeeOROcFD0MaACuL3xdh_G0BMpSc6aJyBKr6AD9VOX&itag=22&source=youtube&requiressl=yes&mh=8g&mm=31%2C26&mn=sn-cvh76nek%2Csn-qxa7sn7l&ms=au%2Conr&mv=m&mvi=5&pl=14&initcwndbps=656250&vprv=1&mime=video%2Fmp4&ns=jKPqnC7PLTBT7QFivOOVKHQG&cnr=14&ratebypass=yes&dur=1024.348&lmt=1538116774878707&mt=1624990851&fvip=5&fexp=24001373%2C24007246&beids=9466588&c=WEB&txp=5531332&n=9bviAl4CEH1guTJ_xFiUz&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIhAPduZ7V-0tFEt54uQZeAp3UETEc-td39Hph7jTxjq2UrAiAWLORXvUnbJR3bdZhoWsDOSi-bUngIH3i0LcuJLP7-Jw%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAPY3ZbxsLULkmq8vXrfhvEqHlrMkYBa_iFMShZLCKYoCAiEAmkJVqqOmhGCjsLA1xmqHpan0PNnKOPzb4eemyzv4gfk%3D",'none at present 2' ),
        //   (3,3,1,'first as',"https://r4---sn-cvh76nek.googlevideo.com/videoplayback?expire=1625012664&ei=WGXbYMCpL4z8juMPq5yJgAg&ip=65.1.86.82&id=o-AJ1oaqAN1BbdYTqcrXIypYKRDNKNEYlIpNwbMXrQFMQm&itag=22&source=youtube&requiressl=yes&mh=lq&mm=31%2C29&mn=sn-cvh76nek%2Csn-cvh7knle&ms=au%2Crdu&mv=m&mvi=4&pl=14&initcwndbps=643750&vprv=1&mime=video%2Fmp4&ns=bAb--T0IvyiWOpJYCVyVqHsG&cnr=14&ratebypass=yes&dur=3784.202&lmt=1608554057249458&mt=1624990614&fvip=4&fexp=24001373%2C24007246&c=WEB&txp=5535432&n=F2fgXBWLvpdOeddw7hn1C&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIgO4smakhMdV_6v1pELbLwhPOei9Ui3kLs9ofWe8LHiQ4CIQDt9__1xOiFsMhjq6QAxP62vTqnZYTeB6DMo4F5U4gcfg%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIhANAJi9LLDQalgM3TmeATG73KHx7fDZRJukHO-WNIe-boAiBQ4-WB_HdYeAL8ZQN0O8o9qvRwdjCMl6a2WddQsEicrg%3D%3D",'none at present 3' );
        // '''
      // );
    },
    );
  } // initialise database










  // // CRUD functions
  // // C
  // void insertAlarm(AlarmInfo alarmInfo) async {
  //   var db = await this.database;
  //   var result = await db.insert(databaseTableName, alarmInfo.toMap());
  //   print('result : $result');
  // }













  void rawQueryExecuter() async {
    var db = await this.database;
    (
      await 
      db.query('sqlite_master', columns:['type','name'])
    ).forEach((row) { 
      print(row.values);
    });
    print('new output---------------------------------------------');
    print(
      await db.rawQuery('''
    
    select * from specific_videos;  
    
    
    ''')
    );
    (
      await 
      db.query('sqlite_master', columns:['type','name'])
    ).forEach((row) {
      print(row.values);
    });
  }

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
