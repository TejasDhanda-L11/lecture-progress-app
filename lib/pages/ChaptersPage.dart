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
                .map((e) => GestureDetector(
                  onTap: (){
                    // Navigator.push(context, '');
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
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Chapter Name
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Text(
                                '${e['Chapter']!}',
                                style: TextStyle(
                                  letterSpacing: 3,
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            
                            
                          ],
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

Set<Map<String, String>> all_chapter_data = {
  {
    'Chapter': 'Gravitation',
    'linkPlaylist' : 'https://www.youtube.com/playlist?list=PLF_7kfnwLFCEwyxzG-rg2uYeYA2q1S2d8'
  },
  {
    'Chapter': 'Wave',
    'linkPlaylist' : 'https://www.youtube.com/playlist?list=PLF_7kfnwLFCEp1eygWPhgPI6A9th2Fw-S'
  },
  {
    'Chapter': 'Harmonic Motion',
    'linkPlaylist' : 'https://www.youtube.com/playlist?list=PLF_7kfnwLFCEvhpUaPoDQvhPwug0aZ1R4'
  },
};
