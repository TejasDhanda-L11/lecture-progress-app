import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

class CustomLandscapeOrientation extends StatefulWidget {
  final ChewieController? chewieController;
  Widget loadingScreen;
  CustomLandscapeOrientation({required this.chewieController, required this.loadingScreen});
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
      ?widget.loadingScreen
      :Chewie(
        controller: widget.chewieController!,
      )

    );
  }
}
