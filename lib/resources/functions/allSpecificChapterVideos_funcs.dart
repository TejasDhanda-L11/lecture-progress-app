import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';

void dropdown ({required Function setState_func, required bool isClose}){
  isClose != isClose;
  setState_func((){});

}

Duration lengthLeftToCoverForLectureVideo({required Map<String, dynamic> dataOfVideo}){
  Duration lengthLeftToCover = Duration.zero;

  if (dataOfVideo['lectureCompleted'] == 'F'){
    Duration totalLength_Duration =
            Duration(seconds: dataOfVideo['duration']);
        // customPrint(totalLength_Duration);

        Duration lengthCompleted_Duration = Duration(
            hours: int.parse(dataOfVideo['lengthCompleted']
                .toString()
                .split(dataOfVideo['lengthCompleted']
                        .toString()
                        .contains('-')
                    ? '-'
                    : ':')[0]),
            minutes: int.parse(dataOfVideo['lengthCompleted']
                .toString()
                .split(
                    dataOfVideo['lengthCompleted'].toString().contains('-')
                        ? '-'
                        : ':')[1]),
            seconds: int.parse(dataOfVideo['lengthCompleted'].toString().split(dataOfVideo['lengthCompleted'].toString().contains('-') ? '-' : ':')[2]));
        // customPrint(lengthCompleted_Duration);

        lengthLeftToCover = Duration(
            seconds:
                (totalLength_Duration.inSeconds -
                    lengthCompleted_Duration
                        .inSeconds));
  }
  // customPrint(dataOfVideo['lectureCompleted']);
  //       customPrint(lengthLeftToCover);
  return lengthLeftToCover;
}