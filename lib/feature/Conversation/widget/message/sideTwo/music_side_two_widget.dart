import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../User/user.dart';
import '../../../model/private_old_message_data_model.dart';





class MessageMusicSideTwo extends StatefulWidget {
  final PrivateOldMessageDataModel message;
  const MessageMusicSideTwo({Key? key,required this.message}) :
        super(key: key);

  @override
  _MessageMusicSideTwoState createState() => _MessageMusicSideTwoState();
}

class _MessageMusicSideTwoState extends State<MessageMusicSideTwo> {
  late Duration duration =const Duration();
  Duration position =   const Duration(seconds: 0);
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;
  bool isFirst = true;
  File? file ;


  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    isLocal();
    audioPlayer.onAudioPositionChanged.listen((
        Duration d
        ) { position=Duration(
        seconds: d.inSeconds
    );
        if(position==duration)
          {
             isPlaying = false;

             isPause = false;
             isFirst = true;

          }
    setState(() {

    });});
    audioPlayer.onDurationChanged.listen((Duration d) {
       duration =Duration(
           seconds: d.inSeconds-1
       );
       setState(() {
       });
    });

    super.initState();
  }


  Future isLocal() async{
    var dir;
    if(Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
    } else {
      dir = await getTemporaryDirectory();
    }
    String fileName=widget.message.all_file!.substring(50,
        widget.message.all_file!.length);
  String  filePath = dir.path + "/" + fileName;
     file = File(filePath);
    if (await file!.exists()) {
      int result =
      await audioPlayer.setUrl(filePath,
          isLocal: true);
    }
    else{
      int result = await audioPlayer.setUrl(
          widget.message.all_file!);
      Dio dio=Dio();
      download(dio, widget.message.all_file!, filePath);
    }
  }

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  Future download(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) { return status! < 500; }
        ),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }


  @override
  Widget build(BuildContext context) {
    return file!=null?
        Row(
          children: [
            Expanded(
              child:  BubbleNormalAudio(
                color: const
                Color(0xFFE8E8EE),
                duration: duration.inSeconds.toDouble(),
                position: position.inSeconds.toDouble(),
                isPlaying: isPlaying,
                isLoading: isLoading,
                isPause: isPause,
                onSeekChanged: (dou){
                  print(dou);
                  position=Duration(
                      seconds: int.parse(dou.floor().toString())
                  );

                  audioPlayer.seek(Duration(
                      seconds: int.parse(dou.floor().toString())
                  ));
                  setState(() {

                  });
                },
                // ignore: curly_braces_in_flow_control_structures
                onPlayPauseButtonClick: (){
                  if(isFirst)
                  {
                    audioPlayer.play(widget.message.all_file!);
                    isPlaying=true;
                    isFirst=false;
                    setState(() {

                    });
                  }
                  else if (isPlaying){
                    audioPlayer.pause();
                    isPlaying=false;
                    isPause=true;

                    setState(() {});
                  }
                  else if (!isPlaying){
                    audioPlayer.resume();
                    isPlaying=true;
                    isPause=false;


                    setState(() {});
                  }
                  else{

                  }

                },
                sent: false,
              ),
            ),
          ],
        ):
        Row(
          children: [
            Expanded(
              child:  BubbleNormalAudio(
                color: const
                Color(0xFFE8E8EE),
                duration: duration.inSeconds.toDouble(),
                position: position.inSeconds.toDouble(),
                isPlaying: isPlaying,
                isLoading: isLoading,
                isPause: isPause,
                onSeekChanged: (dou){
                  print(dou);
                  position=Duration(
                      seconds: int.parse(dou.floor().toString())
                  );

                  audioPlayer.seek(Duration(
                    seconds: int.parse(dou.floor().toString())
                  ));
                  setState(() {

                  });
                },
                // ignore: curly_braces_in_flow_control_structures
                onPlayPauseButtonClick: (){
                  if(isFirst)
                    {
                      audioPlayer.play(widget.message.all_file!);
                      isPlaying=true;
                      isFirst=false;
                      setState(() {

                      });
                    }
                  else if (isPlaying){
                    audioPlayer.pause();
                    isPlaying=false;
                    isPause=true;

                    setState(() {});
                  }
                  else if (!isPlaying){
                    audioPlayer.resume();
                    isPlaying=true;
                    isPause=false;


                    setState(() {});
                  }
                  else{

                  }

                },
                sent: false,
              ),
            ),
          ],
        );
  }



}
