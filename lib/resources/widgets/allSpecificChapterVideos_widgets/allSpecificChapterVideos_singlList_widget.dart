import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/NavigatorFunctions/navigationFunction.dart';
import 'package:lecture_progress/resources/functions/allSpecificChapterVideos_funcs.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';

class AllSpecificChapterVideos_singleList_stfWidget extends StatefulWidget {
  Map<String, dynamic> videoData_Map;
  AllSpecificChapterVideos_singleList_stfWidget(
      {required this.videoData_Map});

  @override
  _AllSpecificChapterVideos_singleList_stfWidgetState createState() =>
      _AllSpecificChapterVideos_singleList_stfWidgetState();
}

class _AllSpecificChapterVideos_singleList_stfWidgetState
    extends State<AllSpecificChapterVideos_singleList_stfWidget> {
  bool isDropOpen = false;
  
  @override
  Widget build(BuildContext context) {
    Duration lengthLeftToCover = lengthLeftToCoverForLectureVideo(dataOfVideo: widget.videoData_Map);

    String isLectureCompleted = widget.videoData_Map["lectureCompleted"];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color:
            isLectureCompleted == 'F' ? Colors.white : Colors.grey[50],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // thumbnail
          GestureDetector(
            onTap: () {
              gapv_dataReq_youtubePlayer = widget.videoData_Map;
              // gapv_psotionToSeekTo = Duration(
              //     hours: int.parse(
              //         widget.videoData_Map['lengthCompleted'].toString().split(widget.videoData_Map['lengthCompleted'].toString().contains('-')? '-':':')[0]),
              //     minutes: int.parse(
              //         widget.videoData_Map['lengthCompleted'].toString().split(widget.videoData_Map['lengthCompleted'].toString().contains('-')? '-':':')[1]),
              //     seconds: int.parse(
              //         widget.videoData_Map['lengthCompleted'].toString().split(widget.videoData_Map['lengthCompleted'].toString().contains('-')? '-':':')[2]));
              
              NAVIGATION_popAndPushToYoutubeVideoPlaying();
            },
            child: Container(
              width: double.infinity,
              // height: 100,

              // child: Image.network(

              //   e['thumbnail'],
              // ),
              child: Opacity(
                opacity: isLectureCompleted == 'F' ? 1 : 0.3,
                child: Image(image: NetworkImage(widget.videoData_Map['thumbnail'])),
              ),
              // color: Colors.white,
            ),
          ),
          // Lecture Name Text
          GestureDetector(
            onTap: () {
              isDropOpen = !isDropOpen;
              // customPrint(isDropOpen);
              setState(() {});
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${widget.videoData_Map['video_lecture_number']}. ${widget.videoData_Map['video_title']}',
                  style: TextStyle(
                      letterSpacing: 3,
                      fontSize: 20,
                      color: isLectureCompleted == 'F'
                          ? Colors.black
                          : Colors.black12,
                      fontWeight: FontWeight.w900),
                ),
                Divider(
                  height: 20,
                  indent: 10,
                  endIndent: 20,
                  thickness: 1,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                // length left
                                Text(
                                  // 'L:${}'
                                  'L:${lengthLeftToCover.inHours}:${lengthLeftToCover.inMinutes.remainder(60).toString().padLeft(2, '0')}:${lengthLeftToCover.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                  // 'hi1',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: isLectureCompleted == 'F'
                                          ? Colors.black
                                          : Colors.black12),
                                ),
                                VerticalDivider(
                                  indent: 0,
                                  endIndent: 0,
                                  thickness: 1,
                                ),
                                // completed length
                                Text(
                                  'D:${int.parse(widget.videoData_Map['lengthCompleted'].toString().split(widget.videoData_Map['lengthCompleted'].toString().contains('-')? '-':':')[0])}:${widget.videoData_Map['lengthCompleted'].toString().split(widget.videoData_Map['lengthCompleted'].toString().contains('-')? '-':':')[1]}:${widget.videoData_Map['lengthCompleted'].toString().split(widget.videoData_Map['lengthCompleted'].toString().contains('-')? '-':':')[2]}',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: isLectureCompleted == 'F'
                                          ? Colors.black
                                          : Colors.black12),
                                ),
                                VerticalDivider(
                                  indent: 0,
                                  endIndent: 0,
                                  thickness: 1,
                                ),
                                // Total length
                                Text(
                                  'T:${(widget.videoData_Map['duration'] / 3600).floor()}:${((widget.videoData_Map['duration'] / 60).floor() - (((widget.videoData_Map['duration'] / 3600).floor()) * 60)).toString().padLeft(2, "0")}:${((widget.videoData_Map['duration']) - ((widget.videoData_Map['duration'] / 60).floor() - (((widget.videoData_Map['duration'] / 3600).floor()) * 60)) * 60 - ((widget.videoData_Map['duration'] / 3600).floor()) * 3600).toString().padLeft(2, "0")}',
                                  // '${Timeform}'.
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: isLectureCompleted == 'F'
                                          ? Colors.black
                                          : Colors.black12),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Icon(Icons.arrow_drop_down_rounded)
                    ],
                  ),
                ),
                Visibility(
                  visible: isDropOpen,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text(widget.videoData_Map['chapter_description_box'])],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
