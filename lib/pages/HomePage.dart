import 'package:flutter/material.dart';
import 'package:lecture_progress/map_copy_for_database/map_copy_for_database.dart';
import 'package:lecture_progress/modal_classes/databaseUnit.dart';
import 'package:lecture_progress/routes/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Map<String,List<DatabaseUnit>> _sortingFunc({required List<DatabaseUnit> DatabaseUnitList_toBeSorted}){
    List<String> subjectExist = [];
    Map<String,List<DatabaseUnit>> mapToBeReturned = {};
    for (int i = 0; i< DatabaseUnitList_toBeSorted.length; i++){
      DatabaseUnit _databaseUnitInstance = DatabaseUnitList_toBeSorted[i];
      if (subjectExist.contains(_databaseUnitInstance.subject)){
        mapToBeReturned[_databaseUnitInstance.subject]!.add(_databaseUnitInstance);
      } else{
        subjectExist.add(_databaseUnitInstance.subject);
        if (mapToBeReturned[_databaseUnitInstance.subject] == null){
          mapToBeReturned[_databaseUnitInstance.subject] = [];
        }
        
        mapToBeReturned[_databaseUnitInstance.subject]!.add(_databaseUnitInstance);
      }
    }
    
    return mapToBeReturned;
    
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<DatabaseUnit>> _finalSortedList = _sortingFunc(DatabaseUnitList_toBeSorted: map_copy_for_database);
    print(_finalSortedList);
    print(_finalSortedList.keys);
    print(_finalSortedList.values);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: _finalSortedList.keys
                .map((e) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context, 
                          RouteManager.chaptersPage,
                          arguments: {
                            'listOfInstances_H2C': _finalSortedList[e]
                          }
                          );
                      },
                      child: Container(
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
                          alignment: Alignment(0, -0.7),
                          child: Text(
                            '$e',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
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
