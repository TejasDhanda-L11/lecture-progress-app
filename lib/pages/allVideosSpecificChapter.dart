import 'package:flutter/material.dart';
import 'package:lecture_progress/routes/routes.dart';

class AllVideoSpecificChapter extends StatefulWidget {

  List<Map<String,dynamic>> dataRequiredEL ;
  AllVideoSpecificChapter({required this.dataRequiredEL});

  @override
  _AllVideoSpecificChapterState createState() => _AllVideoSpecificChapterState();
}

class _AllVideoSpecificChapterState extends State<AllVideoSpecificChapter> {

  @override
  void initState() {
    super.initState();
    print('dataRequiredEL = ${widget.dataRequiredEL}');
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: widget.dataRequiredEL
                .map((e) => GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                      RouteManager.singleVideoCustomPlayer,
                      arguments: {
                        'dataReq_youtubePlayer': e
                      }


                      );
                  },
                  child: Container(

                        width: double.infinity,
                        height: 150,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(23),
                          color: Colors.white,

                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(left:10, top:10),
                          child: Text(
                            '${e['video_lecture_number']}. ${e['video_title']}',
                            style: TextStyle(
                              letterSpacing: 3,
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
