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
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(23),
                          color: Colors.white,

                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(left:10, top:10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${e['video_lecture_number']}. ${e['video_title']}',
                                style: TextStyle(

                                  letterSpacing: 3,
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                                    
                              ),
                              
                              Divider(height: 20,indent: 10, endIndent: 20,thickness: 1,),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    
                                    '${(e['duration']/3600).floor()}:${((e['duration']/60).floor()-(((e['duration']/3600).floor())*60)).toString().padLeft(2,"0")}:${ ((e['duration'])-((e['duration']/60).floor()-(((e['duration']/3600).floor())*60))*60-((e['duration']/3600).floor())*3600 ).toString().padLeft(2,"0")}' ,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700
                                    ),
                                    ),
                                ],
                              )
                            ],
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
