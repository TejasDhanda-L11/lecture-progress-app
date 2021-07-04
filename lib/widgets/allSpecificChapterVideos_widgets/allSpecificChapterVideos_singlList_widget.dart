import 'package:flutter/material.dart';
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/routes/routes.dart';
import 'package:lecture_progress/temp_variables/global_all_page_variable.dart';
import 'package:sqflite/sqflite.dart';

class AllSpecificChapterVideos_singleList_stfWidget extends StatefulWidget {
  Map<String, dynamic> e;
  String isLectureCompleted;
  Duration lengthLeftToCover;
  Database dbInstance;
  AllSpecificChapterVideos_singleList_stfWidget(
      {required this.e,
      required this.isLectureCompleted,
      required this.lengthLeftToCover,
      required this.dbInstance});

  @override
  _AllSpecificChapterVideos_singleList_stfWidgetState createState() =>
      _AllSpecificChapterVideos_singleList_stfWidgetState();
}

class _AllSpecificChapterVideos_singleList_stfWidgetState
    extends State<AllSpecificChapterVideos_singleList_stfWidget> {
  bool isDropOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color:
            widget.isLectureCompleted == 'F' ? Colors.white : Colors.grey[50],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // thumbnail
          GestureDetector(
            onTap: () {
              gapv_dataReq_youtubePlayer = widget.e;
              Navigator.popAndPushNamed(
                  context, RouteManager.singleVideoCustomPlayer, );
            },
            child: Container(
              width: double.infinity,
              // height: 100,

              // child: Image.network(

              //   e['thumbnail'],
              // ),
              child: Opacity(
                opacity: widget.isLectureCompleted == 'F' ? 1 : 0.3,
                child: Image(image: NetworkImage(widget.e['thumbnail'])),
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
                  '${widget.e['video_lecture_number']}. ${widget.e['video_title']}',
                  style: TextStyle(
                      letterSpacing: 3,
                      fontSize: 20,
                      color: widget.isLectureCompleted == 'F'
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
                                  '${widget.lengthLeftToCover.inHours}:${widget.lengthLeftToCover.inMinutes.remainder(60)}:${widget.lengthLeftToCover.inSeconds.remainder(60)}',
                                  // 'hi1',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: widget.isLectureCompleted == 'F'
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
                                  '${int.parse(widget.e['lengthCompleted'].toString().split('-')[0])}:${widget.e['lengthCompleted'].toString().split('-')[1]}:${widget.e['lengthCompleted'].toString().split('-')[2]}',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: widget.isLectureCompleted == 'F'
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
                                  '${(widget.e['duration'] / 3600).floor()}:${((widget.e['duration'] / 60).floor() - (((widget.e['duration'] / 3600).floor()) * 60)).toString().padLeft(2, "0")}:${((widget.e['duration']) - ((widget.e['duration'] / 60).floor() - (((widget.e['duration'] / 3600).floor()) * 60)) * 60 - ((widget.e['duration'] / 3600).floor()) * 3600).toString().padLeft(2, "0")}',
                                  // '${Timeform}'.
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: widget.isLectureCompleted == 'F'
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
                    children: [
                      Text(widget.e['chapter_description_box'])
                    ],
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
