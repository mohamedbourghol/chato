import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../model/private_old_message_data_model.dart';
import 'cont.dart';





class MessageVideoSideOne extends StatefulWidget {
  final PrivateOldMessageDataModel message;
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

        SizedBox(
          width: 6.w,
        ),
        Expanded(
          child: Column(
            children: [

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
           width: 70.w,
         ),

      ],
    );
  }


}
