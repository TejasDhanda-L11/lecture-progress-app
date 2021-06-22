import 'package:flutter/material.dart';
import 'package:lecture_progress/modal_classes/databaseUnit.dart';
import 'package:lecture_progress/routes/routes.dart';

class ChaptersPage extends StatefulWidget {
  final List<DatabaseUnit> listOfChapters;
  ChaptersPage({required this.listOfChapters});
  @override
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {

  Map<String,List<DatabaseUnit>> _sortingFunc({required List<DatabaseUnit> DatabaseUnitList_toBeSorted}){
    List<String> subjectExist = [];
    Map<String,List<DatabaseUnit>> mapToBeReturned = {};
    for (int i = 0; i< DatabaseUnitList_toBeSorted.length; i++){
      DatabaseUnit _databaseUnitInstance = DatabaseUnitList_toBeSorted[i];
      if (subjectExist.contains(_databaseUnitInstance.chapterTitle)){
        mapToBeReturned[_databaseUnitInstance.chapterTitle]!.add(_databaseUnitInstance);
      } else{
        subjectExist.add(_databaseUnitInstance.chapterTitle);
        if (mapToBeReturned[_databaseUnitInstance.chapterTitle] == null){
          mapToBeReturned[_databaseUnitInstance.chapterTitle] = [];
        }
        
        mapToBeReturned[_databaseUnitInstance.chapterTitle]!.add(_databaseUnitInstance);
      }
    }
    
    return mapToBeReturned;
    
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<DatabaseUnit>> _finalSortedList = _sortingFunc(DatabaseUnitList_toBeSorted: widget.listOfChapters);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: _finalSortedList.keys
                .map((e) => GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(
                      context, 
                      RouteManager.allVideosSpecificChapterPage,
                      arguments: {
                        'listOfInstances_C2AVSC': _finalSortedList[e]
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

// Set<Map<String, String>> all_chapter_data = {
//   {
//     'Chapter': 'Gravitation',
//     'linkPlaylist' : 'https://www.youtube.com/playlist?list=PLF_7kfnwLFCEwyxzG-rg2uYeYA2q1S2d8'
//   },
//   // {
//   //   'Chapter': 'Wave',
//   //   'linkPlaylist' : 'https://www.youtube.com/playlist?list=PLF_7kfnwLFCEp1eygWPhgPI6A9th2Fw-S'
//   // },
//   // {
//   //   'Chapter': 'Harmonic Motion',
//   //   'linkPlaylist' : 'https://www.youtube.com/playlist?list=PLF_7kfnwLFCEvhpUaPoDQvhPwug0aZ1R4'
//   // },
// };
