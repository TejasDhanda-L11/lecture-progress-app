// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomYoutubePlayer extends StatefulWidget {
  const CustomYoutubePlayer({ Key? key }) : super(key: key);

  @override
  _CustomYoutubePlayerState createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {

  late VideoPlayerController _controller;
  late Future<void> _initialiseVideoPlayerFuture;
  // late AudioPlayer _audioPlayer;

  @override
  void initState() {
    // AudioPlayer _audioPlayer = AudioPlayer();
    
    // AudioPlayer.logEnabled = true;
    _controller = VideoPlayerController.network('https://r1---sn-cvh76nes.googlevideo.com/videoplayback?expire=1624236104&ei=6IvPYKTZNPu_3LUP_9O2MA&ip=13.127.199.142&id=o-ALXLv2oNzohT-eEB_6LkCTZ-atb9b8d7eh_rB8oOSJO2&itag=247&aitags=133%2C134%2C135%2C136%2C160%2C242%2C243%2C244%2C247%2C278&source=youtube&requiressl=yes&mh=BB&mm=31%2C29&mn=sn-cvh76nes%2Csn-cvh7kney&ms=au%2Crdu&mv=m&mvi=1&pl=15&initcwndbps=355000&vprv=1&mime=video%2Fwebm&ns=R-SgexquY91H4Tm-JogEbisF&gir=yes&clen=27462758&dur=383.840&lmt=1600343508557556&mt=1624214206&fvip=1&keepalive=yes&fexp=24001373%2C24007246&c=WEB&txp=5432432&n=rQBo4IBa39J9XRHd7&sparams=expire%2Cei%2Cip%2Cid%2Caitags%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRAIgS3hfN3ETKxw8nZDfvvpgGuv161J7oRo7pe4gewSYwwcCIHx3SZbdXrjwvq2BmKmtU79P89HFPgXBMTjrWHKjs_Sd&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIgNs1ADuI9eiN2iRxWMSvQv-19rLJczFsyQSvHqJydPLECIQDoRSGZQgzh0F1hht9Tts7os1EZo0Rwqo5Mj_d6S6Elqw%3D%3D', );
    _controller.setLooping(true);
    _initialiseVideoPlayerFuture = _controller.initialize();
    super.initState();
  }
  // dynamic play() async {
  //   print('11111111111111111111111111111111111111111111111111111111111111111111111111111');
  //   int result = await _audioPlayer.play('https://r1---sn-cvh76nes.googlevideo.com/videoplayback?expire=1624236104&ei=6IvPYKTZNPu_3LUP_9O2MA&ip=13.127.199.142&id=o-ALXLv2oNzohT-eEB_6LkCTZ-atb9b8d7eh_rB8oOSJO2&itag=140&source=youtube&requiressl=yes&mh=BB&mm=31%2C29&mn=sn-cvh76nes%2Csn-cvh7kney&ms=au%2Crdu&mv=m&mvi=1&pl=15&initcwndbps=355000&vprv=1&mime=audio%2Fmp4&ns=R-SgexquY91H4Tm-JogEbisF&gir=yes&clen=6214588&dur=383.941&lmt=1600343226054092&mt=1624214206&fvip=1&keepalive=yes&fexp=24001373%2C24007246&c=WEB&txp=5431432&n=rQBo4IBa39J9XRHd7&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRQIhALHDQT8iRz1NdI5_59-R0wneProLgRel-05e_dGm50zOAiBJuj4_Fp2HzIa4CL17_jSQBRk7zdkY_lJ2ApCBFmN1Hw%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIgNs1ADuI9eiN2iRxWMSvQv-19rLJczFsyQSvHqJydPLECIQDoRSGZQgzh0F1hht9Tts7os1EZo0Rwqo5Mj_d6S6Elqw%3D%3D');
  //   if (result == 1) {
  //     // success
  //     print('sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            // play();
            setState(() {
              if (_controller.value.isPlaying) _controller.pause();
              else if (!_controller.value.isPlaying)
              {_controller.play();
                
              };
              
            });
          },
          child: Icon(
            _controller.value.isPlaying? Icons.pause: Icons.play_arrow ,
          )),
        body: FutureBuilder(
          future: _initialiseVideoPlayerFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
            if (snapshot.connectionState == ConnectionState.done){
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller,),
              );
            } else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
      
      
          },
          
        ),
      ),
    );
  }
}

// video url = https://r2---sn-qxaeeney.googlevideo.com/videoplayback?expire=1623419690&ei=yhbDYJyrGMj74-EPh_K_wAU&ip=103.77.40.126&id=o-ADve4W6_fWY2yUw1Ts4s0yNj0N1bVPmQYkXCmdIslmtw&itag=22&source=youtube&requiressl=yes&vprv=1&mime=video%2Fmp4&ns=_wSpRnYsqBoN8xEK3_3BdWkF&cnr=14&ratebypass=yes&dur=98.917&lmt=1623386469993489&fexp=24001373,24007246&c=WEB&txp=6311224&n=yRW6n1fNt2iacLvz6pe&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRAIgdvyUcJ7bswlOuzs0XCQ8KjjoBsn8a3T0GDfacbw7NYsCIBEXMhL7zC6GbicZkP-8HEPpVgBncYbwxI9SvtuYAtfJ&redirect_counter=1&cm2rm=sn-1xvoxu-qxae7l&req_id=59069ba98318a3ee&cms_redirect=yes&mh=S7&mm=29&mn=sn-qxaeeney&ms=rdu&mt=1623398930&mv=m&mvi=2&pl=24&lsparams=mh,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRQIgbAlMiWd8s3IVCvhvMgPvxqJsEsp2gNqjUqeCBz0Gza4CIQD-C359G4JW-zT8z7oRQRRsV2k2cWa5Y-Uzw-I-ZJry-w%3D%3D