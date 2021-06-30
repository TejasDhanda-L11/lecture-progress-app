import 'package:flutter/material.dart';
import 'package:lecture_progress/routes/routes.dart';

//link to server =
// http://13.127.186.252:8080/pl?l=https://www.youtube.com/playlist?list=PLF_7kfnwLFCEQgs5WwjX45bLGex2bLLwY
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: RouteManager.homePage,
      onGenerateRoute: RouteManager.generateRoute,
      debugShowCheckedModeBanner: false,

    );
  }
}
