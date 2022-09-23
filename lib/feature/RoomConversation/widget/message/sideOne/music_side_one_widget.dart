import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../Globals.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../User/user.dart';
import '../../../model/conversationMessage/conversation_old_message_data_model.dart';





class MessageMusicSideOne extends StatefulWidget {
  final ConversationOldMessageDataModel message;
  const MessageMusicSideOne({Key? key,required this.message}) :
        super(key: key);

  @override
  _MessageMusicSideOneState createState() => _MessageMusicSideOneState();
}

class _MessageMusicSideOneState extends State<MessageMusicSideOne> {
   Duration duration = const Duration(
     seconds: 0
  );
  Duration position =    const Duration(
      seconds: 0
  );
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;
  bool isFirst = true;
  File? file ;


  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {

    isLocal(widget.message.localFile);
    audioPlayer.onAudioPositionChanged.listen((
        Duration d
        ) { position=Duration(
        seconds: d.inSeconds
    );
    if(d.inSeconds==duration.inSeconds-1)
    {
      position=duration;
      isPlaying = false;
      isPause = false;
      isFirst = true;

    }
    setState(() {

    });});
    audioPlayer.onDurationChanged.listen((Duration d) {
      duration =Duration(
          seconds: d.inSeconds
      );
      setState(() {

      });

    });

    super.initState();
  }


  Future isLocal(String? localFile) async{
    if(localFile!=null)
      {
        file = File(localFile);

        await audioPlayer.setUrl(localFile,
            isLocal: true);
      }
    else{
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

        await audioPlayer.setUrl(filePath,
            isLocal: true);
      }
      else{
         await audioPlayer.setUrl(
            widget.message.all_file!);
        Dio dio=Dio();
        download(dio, widget.message.all_file!, filePath);
      }
    }

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
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,


      children: [

        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => UserScreen(
                id: Global.userId!,
              ),));
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50.h,
                height: 50.h,
                child: CachedNetworkImage(
                  imageUrl:widget.message.user!.img??
                      "https://www.room.tecknick.net/WI.jpeg",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,

                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              if(Global.vipId!>0)
                SizedBox(
                  width:Global.vipId==1?64.h: 75.h,
                  height: Global.vipId==1?64.h: 75.h,
                  child:Image.asset(
                    Global.vipId==1?
                    'assets/images/solider_frame.png':
                    Global.vipId==2?
                    'assets/images/knight_frame.png':
                    Global.vipId==3?
                    'assets/images/minister_frame.png':
                    'assets/images/king_frame.png',
                    fit: BoxFit.fill,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 6.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: 18.w,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color:  const Color(0xff99AACD),
                    borderRadius: BorderRadius.circular(12.w),
                  ),

                  child: Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 2.h
                    ),
                    child: Row(
                      children: [

                        Expanded(
                          child: Text(widget.message.user!.name!,
                            style: TextStyle(
                                color: ColorManager.backgroundColor,
                                fontSize: 13.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.end,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              file!=null?
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
                          audioPlayer.play(widget.message.all_file??
                              widget.message.localFile!);
                          isPlaying=true;
                          isFirst=false;
                          setState(() {});
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
                          audioPlayer.play(widget.message.all_file??
                          widget.message.localFile!
                          );
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
              ),
            ],
          ),
        ),
        SizedBox(width: 11.w,)


      ],
    );
  }




}
