import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';
import 'package:lecture_progress/temp_variables/global_all_page_variable.dart';

// timer complete dialog 
void timerCompleteDailog() {
  BuildContext context = gapv_presentlyTopContext!;

  showGeneralDialog(

    barrierLabel: "Barrier",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return cutomDiaglog(context:context);
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );

  
}

Widget cutomDiaglog ({required BuildContext context}){
  return CupertinoAlertDialog(

    title: Text('Title'),
    content: Container(
        height: 100,
        width: 100,
        color: Colors.black,
      ),
    actions: [
      CupertinoDialogAction(child: Text('no'),onPressed: (){customPrint('NO');},),
            CupertinoDialogAction(child: Text('YES'),onPressed: (){customPrint('YES'); Navigator.pop(context);},)

    ],
  );

}




// timer running on each page



























// void custom_showDialog({required BuildContext context}) {


//   showGeneralDialog(

//     barrierLabel: "Barrier",
//     barrierDismissible: false,
//     barrierColor: Colors.black.withOpacity(0.5),
//     transitionDuration: Duration(milliseconds: 700),
//     context: context,
//     pageBuilder: (_, __, ___) {
//       return cutomDiaglog(context:context);
//     },
//     transitionBuilder: (_, anim, __, child) {
//       return SlideTransition(
//         position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
//         child: child,
//       );
//     },
//   );

  
// }

// Widget cutomDiaglog ({required BuildContext context}){
//   return CupertinoAlertDialog(

//     title: Text('Title'),
//     content: Container(
//         height: 100,
//         width: 100,
//         color: Colors.black,
//       ),
//     actions: [
//       CupertinoDialogAction(child: Text('no'),onPressed: (){customPrint('NO');},),
//             CupertinoDialogAction(child: Text('YES'),onPressed: (){customPrint('YES'); Navigator.pop(context);},)

//     ],
//   );

// }