import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../User/user.dart';
import '../../../model/private_old_message_data_model.dart';
import '../sideOne/cont.dart';




class MessageVideoSideTwo extends StatefulWidget {
  final PrivateOldMessageDataModel message;
  const MessageVideoSideTwo({Key? key,required this.message}) :
        super(key: key);

  @override
  _MessageVideoSideTwoState createState() =>
      _MessageVideoSideTwoState();
}

class _MessageVideoSideTwoState extends State<MessageVideoSideTwo> {
   VideoPlayerController? _controller;
   String downloadFile='';
   File? file;

  @override
  void initState() {
    isLocal();


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
    print("filePath");
    print(filePath);
    print("filePath");
    file = File(filePath);
    if (await file!.exists()) {
      print('1');
      downloadFile='100';
      _controller=VideoPlayerController.file(
          file!)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }
    else{

      print('2');
      _controller=VideoPlayerController.network
        (widget.message.all_file!)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
     // Dio dio=Dio();
    //  download(dio, widget.message.all_file!, filePath);
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
      print("response.headers");
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
      downloadFile=(received / total * 100).toStringAsFixed(0) + "%";
      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: 12.w
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,


        children: [

          SizedBox(
            width: 70.w,
          ),
          Expanded(
            child: Stack(
              children: [

                if(downloadFile.contains('100'))
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
    );
  }



}
