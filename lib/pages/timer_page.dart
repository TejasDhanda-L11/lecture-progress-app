// import 'package:flutter/services.dart';
// import 'package:lecture_progress/widgets/timer_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class TimerPage extends StatefulWidget {
  

//   @override
//   State<TimerPage> createState() => _TimerPageState();
// }

// class _TimerPageState extends State<TimerPage> {
  
//   Duration howLong = Duration(seconds: 5);

//   @override
//   void initState() {
//     super.initState();
//     debugPrint('hi');
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     debugPrint('atleast came here');
//     debugPrint('howLong = $howLong ---------------------------------');
//     return Scaffold(
//       body: Container(
//         color: Colors.black,
//           height: double.infinity,
//           width: double.infinity,
//           child: Column(
//             children: [
              
//               Flexible(fit: FlexFit.tight, flex: 10, child: TimerWidget(howLong: howLong,)),
//               Flexible(
//                   flex: 10,
//                   fit: FlexFit.tight,
//                   child: Container(
                    
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    
//                       color: Colors.white,
//                     ),
//                     height: double.infinity,
//                     width: double.infinity,
//                     child: Column(
//                       children: [
//                         Container(
//                           width: double.infinity,
//                           child: CupertinoTimerPicker(
//                             mode: CupertinoTimerPickerMode.hms,
//                             onTimerDurationChanged: (time){
//                               howLong = time;
//                               debugPrint('howLong_Cupertino = $howLong ---------------------------------');
//                             },
//                             initialTimerDuration: Duration(seconds: 1),
//                             ),
//                         ),
//                         SizedBox(height: 10,),
                        
//                         FlatButton.icon(onPressed: (){
//                           debugPrint('howLong_Cupertino = $howLong ---------------------------------');

//                           setState(() {
//                           });
//                         }, icon: Icon(Icons.double_arrow_rounded), label: Text('Start'))
//                       // AnimatedContainer(
//                       //   duration: Duration(milliseconds: 400),
                        
//                       //   ),
//                       ],
//                     ),
//                   )
//                 )
//             ],
//           )),
//     );
//   }
// }
