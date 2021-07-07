import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  Duration howLong;
  Duration timeSpent;
  TimerWidget({
    required this.howLong,
    required this.timeSpent
  });
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  
  



  // TimeOfDay timeOfDay = TimeOfDay(hour: 1, minute: 10);

  @override
  void initState() {
    // totalTime_1000 = widget.howLong.inSeconds;
    
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   // ignore: todo
    //   // TODO: change this to better
    //   if (true){
    //     if (totalTime_1000 >= timeSpent && timeSpent > 0){
    //     setState(() {
        
        
    //   });
    //   } else{ 
    //     print('Timer is Complete -------------------------------------');
    //     timer.cancel();
    //     }
    //   } else {
    //     timer.cancel();
    //   }
      
    // });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // debugPrint('came_into_timer_widget--------------------------------');
    // debugPrint('howLong_timer_widget_inside = ${widget.howLong}');
    // debugPrint('timeSpent_timer_widget_inside = ${widget.timeSpent}');
    // debugPrint('howLong_timer_widget_inside___h = ${widget.howLong.inHours}');
    // debugPrint('howLong_timer_widget_inside___m = ${widget.howLong.inMinutes}');
    // debugPrint('howLong_timer_widget_inside___s = ${widget.howLong.inSeconds}');

    // timeSpent += 1 ;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(painter: TimerPainter(totalTime_1000: widget.howLong, timeSpent: widget.timeSpent)),
      
    );
  }
}



























class TimerPainter extends CustomPainter{
  Duration totalTime_1000;
  Duration timeSpent;
  


  TimerPainter({required this.totalTime_1000, required this.timeSpent});

  
  @override
  void paint(Canvas canvas, Size size) {
    // print('totalTime_1000 = $totalTime_1000');
    int hourTimerTime = (totalTime_1000.inHours);
    // print('hourTimerTime = $hourTimerTime');
    int minTimerTime = totalTime_1000.inMinutes % 60;
    // print('minTimerTime = $minTimerTime');

    int secTimerTime = totalTime_1000.inSeconds % 60;
    // print('secTimerTime = $secTimerTime');

    DateTime timerTime = DateTime.parse("2012-02-27 ${hourTimerTime.toString().padLeft(2,'0')}:${minTimerTime.toString().padLeft(2,'0')}:${secTimerTime.toString().padLeft(2,'0')}").subtract(timeSpent);

    double centerX = size.width/2;
    double centerY = size.height/2;
    double radiusMax = min(centerX, centerY); 

//////////////////////////////************************************************************************ */
    // ignore: todo
    // // TODO: outer circle with time runninf indigoish
    // var outestCircle = Paint()
    // ..color = Colors.white30
    // ..style = PaintingStyle.stroke
    // ..strokeWidth = 0.1;
    // var radiusOuterCircle = radiusMax;
    // canvas.drawCircle(Offset(centerX, centerY), radiusOuterCircle, outestCircle);
////////////////////////**************************************************************** */
    // ignore: todo
    // TODO: Arc on outer most circle

    double strokeWidthOutermostArc = 5;

    Paint outestArc = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.indigo
    ..strokeWidth = strokeWidthOutermostArc
    ..strokeCap = StrokeCap.round
    
    
    ;

    double radiusOuterArc = radiusMax- 10;
    // print('TIME TOTAL = ${totalTime_1000}');

    // print('TIME SPENT = ${timeSpent}');
    // print('${((360*timeSpent)/totalTime_1000)}');
    double angleSwept = 0;
    if (totalTime_1000.inSeconds > 0){
      angleSwept = 360 - ((360*timeSpent.inSeconds)/totalTime_1000.inSeconds);
    } 


    canvas.drawArc(
      Offset(centerX- radiusOuterArc + (strokeWidthOutermostArc/2)  ,  centerY - radiusOuterArc + (strokeWidthOutermostArc/2)) & Size(2* radiusOuterArc - strokeWidthOutermostArc, 2 * radiusOuterArc - strokeWidthOutermostArc), 
      -((90*pi)/180), 
      (angleSwept* pi)/180, 
      false, 
      outestArc);


/////////////////////////***************************************************************** */
    // ignore: todo
    // TODO: Central outer circle

    Paint CentralOuterCircle = Paint()
    ..color = Colors.white38
    
    
    ;
    double radiusCentralOuterCircle = radiusMax-30;

    canvas.drawCircle(Offset(centerX, centerY), radiusCentralOuterCircle, CentralOuterCircle);
    
    /////************************************************************************************* */
    // ignore: todo
    // TODO: Time Text on Top

    final TextPainter timeTextPainter = TextPainter(
      text: TextSpan(
          text: 'Time',
          style: TextStyle(
            fontSize: radiusCentralOuterCircle / 7,
            fontWeight: FontWeight.w500
          )),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width, minWidth: 0.0);  

    timeTextPainter.paint(canvas, Offset(centerX - timeTextPainter.width/2, centerY- timeTextPainter.height/2 - radiusCentralOuterCircle/1.5));
    
    TextPainter runningTimeTextPainter = TextPainter(
          text: TextSpan(
            text: '${timerTime.hour.toString().padLeft(2,'0')} : ${timerTime.minute.toString().padLeft(2,'0')} : ${timerTime.second.toString().padLeft(2,'0')}', 
            style: TextStyle(
              fontSize: radiusCentralOuterCircle/3,
              fontWeight: FontWeight.w700
              
              )),
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,

        )
          ..layout(maxWidth: size.width, minWidth: 0.0);  
    runningTimeTextPainter.paint(canvas, Offset(centerX - runningTimeTextPainter.width/2, centerY- runningTimeTextPainter.height/2 - radiusCentralOuterCircle/3));

    // ParagraphBuilder timerParagraphBuilder =ParagraphBuilder(
    //   ParagraphStyle(
    //     fontSize: size.width/12,
    //     textAlign: TextAlign.
        
    //     )
    //   )
    //   ..addText('Timer')
    //   ;
    // Paragraph timerParagraph = timerParagraphBuilder.build()..layout(ParagraphConstraints(width: centerX + radiusCentralOuterCircle));


    // canvas.drawParagraph(
    //   timerParagraph,
    //    Offset(centerX - radiusCentralOuterCircle, centerY ));


//*************************************************************************************************** */
    // ignore: todo
    // TODO: Showing Timer
    // ignore: todo
    // TODO: intr






    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
    return true;
  }


}
