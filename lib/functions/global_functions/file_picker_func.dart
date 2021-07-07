// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:lecture_progress/highlyReusable_Functions/highlyReusable_Functions.dart';

// Future<void> file_picker_simple() async {

//   // FilePickerResult? result = await FilePicker.platform.pickFiles();
//   FilePickerResult? result = await FilePicker.platform.pickFiles(allowedExtensions: ['pdf'],type: FileType.custom);

//   if(result != null) {
//     File file = File(result.files.single.path!);
//     customPrint(file);
//   } else {
//     // User canceled the picker
//   }


// }