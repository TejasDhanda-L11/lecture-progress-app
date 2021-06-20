import 'package:flutter/material.dart';

class ChaptersPage extends StatefulWidget {
  @override
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: all_chapter_data
                .map((e) => Container(
                      width: double.infinity,
                      height: 150,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        gradient: LinearGradient(
                            colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)]),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Chapter Name
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              '#${e['Chapter']!}',
                              style: TextStyle(
                                letterSpacing: 3,
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          // Percentage Stuff
                          Positioned(
                            top: 60,
                            left: 20,
                            child: Text(
                              e['ProgressPercentage']!,
                              style: TextStyle(
                                letterSpacing: 3,
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          // Videos Left Stuff
                          Positioned(
                            top: 60,
                            width: 40,
                            right: 10,
                            child: Column(
                              children: [
                                Text(e['VideosLeft']!,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900)),
                                // VerticalDivider(width: 100, thickness: 10,color: Colors.green,),
                                Divider(color: Colors.white,height: 20,thickness: 2,),
                                Text(e['TotalVideos']!,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900)),
                              ],
                            ),
                          ),
                          // Date Stuff
                          Positioned(
                            bottom: 10,
                            left: 5,
                            child: Text(
                              '${e['DateStarted']} - ${e['DateCompleted']}',
                              style: TextStyle(
                                wordSpacing: 2,
                                letterSpacing: 2,
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

Set<Map<String, String>> all_chapter_data = {
  {
    'Chapter': 'Gravitation',
    'ProgressPercentage': '89%',
    'DateStarted': '12th June',
    'DateCompleted': 'current',
    'TotalVideos': '12',
    'VideosLeft': '6'
  },
  {
    'Chapter': 'Wave',
    'ProgressPercentage': '89%',
    'DateStarted': '12th June',
    'DateCompleted': 'current',
    'TotalVideos': '12',
    'VideosLeft': '6'
  },
  {
    'Chapter': 'Harmonic Motion',
    'ProgressPercentage': '89%',
    'DateStarted': '12th June',
    'DateCompleted': 'current',
    'TotalVideos': '12',
    'VideosLeft': '6'
  },
};
