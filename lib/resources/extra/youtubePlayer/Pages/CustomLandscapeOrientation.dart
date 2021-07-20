import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:lecture_progress/mainImplementation/temp_variables/global_all_page_variable.dart';

class CustomLandscapeOrientation extends StatefulWidget {
  final ChewieController? chewieController;
  CustomLandscapeOrientation({required this.chewieController});
  @override
  _CustomLandscapeOrientationState createState() =>
      _CustomLandscapeOrientationState();
}

class _CustomLandscapeOrientationState
    extends State<CustomLandscapeOrientation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.chewieController == null
      ?gapv_loadingScreen
      :Chewie(
        controller: widget.chewieController!,
      )

    );
  }
}
