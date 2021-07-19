import 'package:sqflite/sqlite_api.dart';

void Done_Not_Done_onPressed (
    {required Database database,
    required Function setStateFunc,
    required String T_F_toBeSetOnClick,
    required int idOfVideo}) async {
  database.rawQuery('''
                    UPDATE specific_videos
                    SET lectureCompleted = '${T_F_toBeSetOnClick}'
                    WHERE id = ${idOfVideo}
                    ''');
  setStateFunc(() {});
}
