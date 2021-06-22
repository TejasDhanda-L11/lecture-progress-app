import 'package:flutter/material.dart';
import 'package:lecture_progress/modal_classes/databaseUnit.dart';
import 'package:lecture_progress/routes/routes.dart';

class AllVideoSpecificChapter extends StatefulWidget {
  final String linkToPlaylist;
  final List<DatabaseUnit> listOfLecture;
  AllVideoSpecificChapter({ this.linkToPlaylist = '', required this.listOfLecture});
  @override
  _AllVideoSpecificChapterState createState() => _AllVideoSpecificChapterState();
}

class _AllVideoSpecificChapterState extends State<AllVideoSpecificChapter> {

    Map<String,List<DatabaseUnit>> _sortingFunc({required List<DatabaseUnit> DatabaseUnitList_toBeSorted}){
    List<String> subjectExist = [];
    Map<String,List<DatabaseUnit>> mapToBeReturned = {};
    for (int i = 0; i< DatabaseUnitList_toBeSorted.length; i++){
      DatabaseUnit _databaseUnitInstance = DatabaseUnitList_toBeSorted[i];
      if (subjectExist.contains(_databaseUnitInstance.lectureName)){
        mapToBeReturned[_databaseUnitInstance.lectureName]!.add(_databaseUnitInstance);
      } else{
        subjectExist.add(_databaseUnitInstance.lectureName);
        if (mapToBeReturned[_databaseUnitInstance.lectureName] == null){
          mapToBeReturned[_databaseUnitInstance.lectureName] = [];
        }
        
        mapToBeReturned[_databaseUnitInstance.lectureName]!.add(_databaseUnitInstance);
      }
    }
    
    return mapToBeReturned;
    
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<DatabaseUnit>> _finalSortedList = _sortingFunc(DatabaseUnitList_toBeSorted: widget.listOfLecture);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: _finalSortedList.keys
                .map((e) => GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(
                      context, 
                      RouteManager.singleVideoCustomPlayer,
                      arguments: {
                        'videoSpecificInstance': _finalSortedList[e]
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
                                '${e}',
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
