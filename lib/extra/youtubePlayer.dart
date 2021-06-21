import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class CustomYoutubePlayer extends StatefulWidget {
  const CustomYoutubePlayer({ Key? key }) : super(key: key);

  @override
  _CustomYoutubePlayerState createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  
  bool chewieController_initialised = false;
  late ChewieController chewieController;

  void chewieConfigStuff () async{
    final videoPlayerController = VideoPlayerController.network(
'https://r1---sn-1xvoxu-qxae.googlevideo.com/videoplayback?expire=1624311901&ei=_bPQYOG_K5K23LUPmoOCcA&ip=13.127.199.142&id=o-ABm80q-XyIsX9VizHc_tNdXv07z_wV2Q3FCDA7AnwXsg&itag=18&source=youtube&requiressl=yes&vprv=1&mime=video%2Fmp4&ns=d84s1nr-4_Q25kj_MWzLbFgF&gir=yes&clen=15734124&ratebypass=yes&dur=193.724&lmt=1518891449108255&fexp=24001373,24007246&c=WEB&n=It2FhpOGX_jcXWiD4&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRgIhALdc4ucOa1AsUXcxHY3P2WZVwg4L2r5kOj-rr52qPIRRAiEAhJneBWUqdsMF3G6H9o2u4VmlGephjtnhhJo2kCTJCLU=&redirect_counter=1&rm=sn-cvhse76&req_id=3aef56498c63a3ee&cms_redirect=yes&ipbypass=yes&mh=Pr&mip=103.77.40.126&mm=31&mn=sn-1xvoxu-qxae&ms=au&mt=1624290053&mv=m&mvi=1&pl=24&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRAIgCH4p5ka7eNHJpLyDCKBUHy8K8m3JHQj1SSUXntD_4N4CIHYLdNhvFuIbGy3U-fkO314p5qFr9c5oYEY-rUN3bz4u'
);
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: true,
      
      
    );
    
    setState(() {
      chewieController_initialised = true;
      
    });
  }

  @override
  void initState()  {
    super.initState();
    chewieConfigStuff();
  }

  @override
  void dispose() {
    super.dispose();
    chewieController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        chewieController.enterFullScreen();
        
      },),
      body: chewieController_initialised ? Chewie(
        controller: chewieController,

      ): Container()
    );
  }
}

























































// class CustomYoutubePlayer extends StatefulWidget {
//   const CustomYoutubePlayer({ Key? key }) : super(key: key);

//   @override
//   _CustomYoutubePlayerState createState() => _CustomYoutubePlayerState();
// }

// class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {

//   late VideoPlayerController _controller;
//   late Future<void> _initialiseVideoPlayerFuture;

//   @override
//   void initState() {

    
//     _controller = VideoPlayerController.network(
// "https://r5---sn-cvh7kney.googlevideo.com/videoplayback?expire=1624306818&ei=IqDQYKBuvoCO4w_Qhaj4BQ&ip=13.127.199.142&id=o-AAwnNSFcQSSO6omYkLC0YpiFTZxYayZpinBqGfMoB8Gu&itag=18&source=youtube&requiressl=yes&mh=Pr&mm=31%2C26&mn=sn-cvh7kney%2Csn-qxa7snel&ms=au%2Conr&mv=m&mvi=5&pl=15&initcwndbps=753750&vprv=1&mime=video%2Fmp4&ns=qdOmGP_fA1EMiovlYQptKl4F&gir=yes&clen=15734124&ratebypass=yes&dur=193.724&lmt=1518891449108255&mt=1624285021&fvip=5&fexp=24001373%2C24007246&c=WEB&n=4Wk_SUDA5fojfi7WY&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIgMAE9u7Fofmk5cHJe2B3wR5ecZ4N1YaAiJjZd5k-i7E8CIQCsT0iUml3njfbBKkkfls2V6DYSOtV6cx4ezKxkj4eLlQ%3D%3D&sig=AOq0QJ8wRQIgTDrI00hBNVRqek62rQMaZR-EmgfYfTLKdGpOkKWOX1ICIQDZoA8G_HlsLW2MynvGV4h7ojvjPITaFcv46Wmt_jckYg=="  
//       , videoPlayerOptions: );
//     _initialiseVideoPlayerFuture = _controller.initialize();
//     super.initState();
//   }


//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: (){
//             print('tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt${_controller.value.size}');
//             print('tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt${_controller.value.buffered}');
//             setState(() {
//               if (_controller.value.isPlaying) _controller.pause();
//               else if (!_controller.value.isPlaying)
//               {_controller.play();
                
//               };
              
//             });
//           },
//           child: Icon(
//             _controller.value.isPlaying? Icons.pause: Icons.play_arrow ,
//           )),
//         body: FutureBuilder(
//           future: _initialiseVideoPlayerFuture,
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
//             if (snapshot.connectionState == ConnectionState.done){
//               return AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller,),
//               );
//             } else{
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
      
      
//           },
          
//         ),
//       ),
//     );
//   }
// }

