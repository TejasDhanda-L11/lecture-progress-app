import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class AWSApiToDB {
  final String playlistUrl;

  AWSApiToDB({required this.playlistUrl});

  Future<Map<String, dynamic>> getDataFromAWSApi() async {
    String linkToApi = 'http://13.127.186.252:8080/pl?l=';
    String link = linkToApi + this.playlistUrl;
    print('link = ${link}');
    var url = Uri.parse(link);
    var response = await http.get(url);
    // print('Response: ${jsonDecode(response.body)}');
    return jsonDecode(response.body);
  }

  Future<void> AWSApiToDB_func(
      {required Database dbInstance, required int subject_id}) async {
    Map<String, dynamic> dataReturned_fromAPI = await getDataFromAWSApi();

    var temp_valueReturned = await dbInstance.rawQuery('''
      INSERT INTO chapters(
        subject_id,
        chapter_name,
        playlist_url,
        uploader_name,
        number_of_lectures
      )
      VALUES 
      (
        $subject_id,
        "${dataReturned_fromAPI['title'].toString()}",
        "${this.playlistUrl.toString()}",
        "${dataReturned_fromAPI['uploader'].toString()}",
        ${dataReturned_fromAPI['number_of_videos']}
        
      )
      ;
      ''');
    List<Map<String, Object?>> chapter_id = await dbInstance.rawQuery('''
        SELECT id FROM chapters
          ORDER BY -id
          LIMIT 1
      ''');
    // debugPrint(dataReturned_fromAPI['video'].toString());
    for (int i = 0; i < dataReturned_fromAPI['number_of_videos']; i++) {
      // debugPrint("dataReturned_fromAPI['video'][$i]['URLVid'] = ${dataReturned_fromAPI['video']['0']}");
      String description = dataReturned_fromAPI['video']['$i']['description'].toString().replaceAll('"', '_').replaceAll("'", '_');
      // customPrint(description,object2: 'DESCRIPTION ----------------------------------------');
      await dbInstance.rawQuery('''
      INSERT INTO specific_videos(
        chapter_id,
        subject_id,
        video_lecture_number,
        video_url,
        video_title,
        chapter_description_box,
        notes_location,
        duration,
        thumbnail
      )
      VALUES 
      (
        ${chapter_id[0]['id']},
        $subject_id,
        ${i + 1},
        "${dataReturned_fromAPI['video']['$i']['URLVid'].toString()}",
        "${dataReturned_fromAPI['video']['$i']['titleVid'].toString()}",
        "$description",
        "none",
        ${dataReturned_fromAPI['video']['$i']['duration']},
        "${dataReturned_fromAPI['video']['$i']['thumbnail'].toString()}"

        
        
      )
      ;
      ''');
    }
  }

  Future<void> AWSApiUpdateDB_func(
      {required Database dbInstance, required int subject_id, required int chapter_id}) async {
    debugPrint('AWSApiUpdateDB_func STAGE 1------------------------------------------------------');
    Map<String, dynamic> dataReturned_fromAPI = await getDataFromAWSApi();
    debugPrint('AWSApiUpdateDB_func STAGE 2------------------------------------------------------');
    
    // debugPrint(dataReturned_fromAPI['video'].toString());
    for (int i = 0; i < dataReturned_fromAPI['number_of_videos']; i++) {
      debugPrint('AWSApiUpdateDB_func STAGE ${i+3} of ${dataReturned_fromAPI["number_of_videos"]}------------------------------------------------------');
      // debugPrint("dataReturned_fromAPI['video'][$i]['URLVid'] = ${dataReturned_fromAPI['video']['0']}");
      await dbInstance.rawQuery('''
      Update specific_videos
      set video_url = "${dataReturned_fromAPI['video']['$i']['URLVid'].toString()}"
      WHERE (chapter_id = $chapter_id)
      AND (subject_id= $subject_id)
      AND (video_lecture_number = ${i+1})
      ;
      ''');
    }
    debugPrint('old links of youtube videos are renewed ------------------------------');
  }
}

// dummy playlist link
// https://www.youtube.com/playlist?list=PLF_7kfnwLFCFFKkWI8iRKE2RW7-orWJ2N