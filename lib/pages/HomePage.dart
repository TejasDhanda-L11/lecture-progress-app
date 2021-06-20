import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: all_subjects
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
                      child: Align(
                        alignment: Alignment(0,-0.7),
                        child: Text(
                      
                          e,
                          style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w900),
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

List<String> all_subjects = <String>[
  'Physics',
  'Math',
  'Chem',
  'Book',
  'AudioBook'
];
