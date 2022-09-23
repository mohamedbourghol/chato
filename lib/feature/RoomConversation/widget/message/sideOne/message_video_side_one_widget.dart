
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import '../../../../../Globals.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../User/user.dart';
import '../../../model/conversationMessage/conversation_old_message_data_model.dart';
import 'cont.dart';





class MessageVideoSideOne extends StatefulWidget {
  final ConversationOldMessageDataModel message;
  const MessageVideoSideOne({Key? key,required this.message}) :
        super(key: key);

  @override
  _MessageVideoSideOneState createState() => _MessageVideoSideOneState();
}

class _MessageVideoSideOneState extends State<MessageVideoSideOne> {
   VideoPlayerController? _controller;
  String downloadFile='';
   File? file;
  @override
  void initState() {
    isLocal(widget.message.localFile);


    super.initState();
  }


  Future isLocal(String? localFile) async{
    if(localFile!=null)
    {
      downloadFile='100';
      _controller=VideoPlayerController.file(
          File(localFile))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
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
      var file = File(filePath);
      if (await file.exists()) {
        downloadFile='100';
        _controller=VideoPlayerController.file(
            file)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
      }
      else{


        _controller=VideoPlayerController.network
          (widget.message.all_file!)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
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
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,


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
            children: [
              Container(
                decoration: BoxDecoration(
                  color:  const Color(0xff99AACD),
                  borderRadius: BorderRadius.circular(12.w),
                ),

                child: Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: 12.w
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
              Expanded(
                child: Stack(
                  children: [

                    if(downloadFile.contains('100')||
                        widget.message.localFile!=null)
                      ...[
                        if(_controller!=null)
                          VideoPlayer(_controller!),
                        if(_controller!=null)
                          ControlsOverlay(controller: _controller!),
                        if(_controller!=null)
                          VideoProgressIndicator(_controller!,
                            allowScrubbing: true,
                          ),
                      ]
                    else if(downloadFile.isEmpty)
                      ...[
                        if(_controller!=null)
                          VideoPlayer(_controller!),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: (){
                              Dio dio=Dio();
                              download(dio, widget.message.all_file!, file!.path);
                            },
                            icon: Icon(
                              Icons.download,
                              size: 22.w,
                              color: ColorManager.backgroundColor,
                            ),
                          ),
                        ),
                      ]
                    else ...[
                        if(_controller!=null)
                          VideoPlayer(_controller!),
                        Positioned(
                          bottom: 70.h,
                          left: 0,
                          right: 0,

                          child: Text(downloadFile
                            ,style: TextStyle(
                                color: ColorManager.backgroundColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600
                            ),textAlign: TextAlign.center,),
                        )
                      ]

                  ],
                ),
              ),
            ],
          ),
        ),
         SizedBox(
           width: 50.w,
         ),



      ],
    );
  }


}
