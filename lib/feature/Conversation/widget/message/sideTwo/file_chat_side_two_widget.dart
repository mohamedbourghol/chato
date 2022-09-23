import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../model/private_old_message_data_model.dart';





class MessageFileSideTwo extends StatefulWidget {
  final PrivateOldMessageDataModel message;
  const MessageFileSideTwo({Key? key,required this.message}) :
        super(key: key);

  @override
  _MessageFileSideTwoState createState() => _MessageFileSideTwoState();
}

class _MessageFileSideTwoState extends State<MessageFileSideTwo> {
  File? file ;
  String downloadFile='';
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
    file = File(filePath);
    if (await file!.exists()) {
      downloadFile='100%';
      setState(() {

      });
    }
    else{

    //  Dio dio=Dio();
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
      downloadFile=
          (received / total * 100).toStringAsFixed(0) + "%";
      setState(() {

      });
    }
  }

   bool isUrl(String message){
    if(message.startsWith('https')){
      return true;
    }
    if(message.startsWith('http')){
      return true;
    }
    if(message.startsWith('www')){
      return true;
    }

    return false;
 }

  @override
  build(BuildContext context)  {
    return GestureDetector(
      onTap: (){
        try{
          OpenFile.open(file!.path);
        }
        // ignore: empty_catches
        catch (e){

        }

      },
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 12.w
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if(widget.message.all_file!.length>35
                ||widget.message.user!.name!.length>35)
              Expanded(
                child: Row(
                  children: [
                    const Expanded(
                      child: SizedBox(
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(

                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xffFF7642),
                                  Color(0xffF9C45C),
                                ]
                            ),
                            borderRadius: BorderRadius.only(
                              topRight:  Radius.circular(12.w),
                              bottomLeft: Radius.circular(12.w),
                              topLeft: Radius.circular(12.w),
                              bottomRight:  Radius.circular(12.w),

                            )
                        ),
                        child:  Padding(
                          padding:  EdgeInsets.symmetric(
                              vertical: 4.h
                          ),
                          child: Column(

                            children: [


                              Padding(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 12.w
                                ),
                                child: Row(
                                  children: [
                                    downloadFile.isEmpty?
                                        InkWell(
                                          onTap: (){
                                              Dio dio=Dio();
                                              download(dio, widget.message.all_file!, file!.path);
                                          },
                                          child: Icon(Icons.download,
                                            color: ColorManager.backgroundColor,
                                            size: 22.w,
                                          ),
                                        ):
                                    downloadFile.contains('100')?
                                     Icon(
                                      Icons.file_copy_outlined,
                                      color: ColorManager.backgroundColor,
                                      size: 22.w,
                                    ):Text(downloadFile
                                      ,style: TextStyle(
                                          color:isUrl (widget.message.message!)?
                                          Colors.blue.shade700:
                                          ColorManager.backgroundColor,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600
                                      ),textAlign: TextAlign.end,),
                                    Expanded(
                                      child: InkWell(
                                        onTap:isUrl (widget.message.message!)?()
                                       async {
                                         await launch(widget.message.message!);
                                        }:null,
                                        child: Text(widget.message.all_file!
                                          ,style: TextStyle(
                                              color:isUrl (widget.message.message!)?
                                              Colors.blue.shade700:
                                              ColorManager.backgroundColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600
                                          ),textAlign: TextAlign.end,),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )else
              Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xffFF7642),
                          Color(0xffF9C45C),
                        ]
                    ),
                    borderRadius: BorderRadius.only(
                      topRight:  Radius.circular(12.w),
                      bottomLeft: Radius.circular(12.w),
                      topLeft: Radius.circular(12.w),
                      bottomRight:  Radius.circular(12.w),

                    )
                ),
                child:  Padding(
                  padding:  EdgeInsets.symmetric(
                      vertical: 4.h
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [



                      Row(
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            color: ColorManager.backgroundColor,
                            size: 22.w,
                          ),
                          InkWell(
                            onTap:isUrl(widget.message.message!)? () async {
                              await launch(widget.message.message!);
                            }:null,
                            child: Container(
                              decoration:
                              widget.message.message!.length>
                                  widget.message.user!.name!.length?
                              const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                      color: ColorManager.backgroundColor,
                                    )
                                ),
                              ):const BoxDecoration(),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 12.w),
                                child: Text(widget.message.all_file!,
                                  style: TextStyle(
                                      color:isUrl(widget.message.message!)?
                                      Colors.blue.shade700:
                                      ColorManager.backgroundColor,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600
                                  ),textAlign: TextAlign.start,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),





          ],
        ),
      ),
    );
  }



}
