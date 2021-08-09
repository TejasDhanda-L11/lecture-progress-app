
import 'package:custom_highly_reusable_functions/HighlyReusableFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


void RemoveSubject_Function(
    {required int id,
    required Function? State_SubjectsPage_ListView,
    required Database database,
    required BuildContext context,
    required String SUBJECT
    }) async {

  void DeleteSubject(){
    try{
                database.rawQuery(
                  '''
                  DELETE FROM subjects 
                  WHERE id=$id
                  '''
                );
                State_SubjectsPage_ListView!.call((){});
                customPrint('Congrats, deleted  $SUBJECT');
              } catch (e){
                customPrint(e,object2: 'error onLongPressClicking Try');
              }
  }


  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return cutomDiaglog(context: context, function_DeleteSubject: DeleteSubject, SUBJECT: SUBJECT);
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );



  
}



Widget cutomDiaglog({required BuildContext context, required String SUBJECT, required Function function_DeleteSubject}) {

  return CupertinoAlertDialog(
    title: Text('Timer Complete'),
    content: Column(
      children: [
        Text(
            'Do You Really Want To Delete $SUBJECT subject permanently'),
        ],
    ),
    actions: [
      CupertinoDialogAction(
        child: Text('No'),
        onPressed: () {
          customPrint('NO');

          Navigator.pop(context);
        },
      ),
      CupertinoDialogAction(
        child: Text('YES'),
        onPressed: () {
          customPrint('YES');

          function_DeleteSubject.call();

          Navigator.pop(context);
        },
      )
    ],
  );
}
