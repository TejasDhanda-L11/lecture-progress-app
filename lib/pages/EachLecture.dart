// import 'package:flutter/material.dart';

// class EachLecture extends StatefulWidget {

//   @override
//   _EachLectureState createState() => _EachLectureState();
// }

// class _EachLectureState extends State<EachLecture> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: all_subjects
//                 .map((e) => Container(
                  
//                       width: double.infinity,
//                       height: 150,
//                       margin: EdgeInsets.only(
//                           left: 20, right: 20, top: 20, bottom: 20),
                      
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(23),
//                         gradient: LinearGradient(
//                             colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)]),
//                       ),
//                       child: Align(
//                         alignment: Alignment(0,-0.7),
//                         child: Text(
                      
//                           e,
//                           style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w900),
//                         ),
//                       ),
//                     ))
//                 .toList(),
//           ),
//         ),
//       ),
//     );
      
    
//   }
// }



// Set<Map> all_videos = {
//   {
//     'Title':'Lec 1',
//     'Watched': '0',
    
//   }
// };