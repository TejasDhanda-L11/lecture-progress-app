// import 'package:flutter/material.dart';
// import 'package:lecture_progress/resources/highlyReusable_Functions/highlyReusable_Functions.dart';
// import 'dart:async';
// import 'package:receive_sharing_intent/receive_sharing_intent.dart';



// class gotYoutubePlaylistIntentPage extends StatefulWidget {

//   @override
//   _gotYoutubePlaylistIntentPageState createState() => _gotYoutubePlaylistIntentPageState();
// }

// class _gotYoutubePlaylistIntentPageState extends State<gotYoutubePlaylistIntentPage> {
  
//   StreamSubscription? _intentDataStreamSubscription;
//   List<SharedMediaFile>? _sharedFiles;
//   String? _sharedText;

//   @override
//   void initState() {
//     super.initState();

//     // // For sharing images coming from outside the app while the app is in the memory
//     // _intentDataStreamSubscription =
//     //     ReceiveSharingIntent.getMediaStream().listen((List<SharedMediaFile> value) {
//     //   setState(() {
//     //     customPrint("Shared:" + (_sharedFiles?.map((f)=> f.path).join(",") ?? ""));
//     //     _sharedFiles = value;
//     //   });
//     // }, onError: (err) {
//     //   customPrint("getIntentDataStream error: $err");
//     // });

//     // // For sharing images coming from outside the app while the app is closed
//     // ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
//     //   setState(() {
//     //     _sharedFiles = value;
//     //   });
//     // });

//     // For sharing or opening urls/text coming from outside the app while the app is in the memory
//     _intentDataStreamSubscription =
//         ReceiveSharingIntent.getTextStream().listen((String value) {
//       setState(() {
//         _sharedText = value;
//       });
//     }, onError: (err) {
//       customPrint("getLinkStream error: $err");
//     });

//     // For sharing or opening urls/text coming from outside the app while the app is closed
//     ReceiveSharingIntent.getInitialText().then((value) {
//       setState(() {
//         _sharedText = value ?? 'nothingcl';
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _intentDataStreamSubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               Text("Shared files:", style: textStyleBold),
//               Text(_sharedFiles?.map((f)=> f.path).join(",") ?? ""),
//               SizedBox(height: 100),
//               Text("Shared urls/text:", style: textStyleBold),
//               Text(_sharedText ?? "")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }