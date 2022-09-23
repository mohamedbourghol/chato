import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/feature/User/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Globals.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../model/conversationMessage/conversation_old_message_data_model.dart';





class MessageFileSideOne extends StatefulWidget {
  final ConversationOldMessageDataModel message;
  const MessageFileSideOne({Key? key,required this.message}) :
        super(key: key);

  @override
  _MessageFileSideOneState createState() => _MessageFileSideOneState();
}

class _MessageFileSideOneState extends State<MessageFileSideOne> {
  File? file ;
  String downloadFile='';
  @override
  void initState() {
    isLocal(widget.message.localFile);
    super.initState();
  }

  Future isLocal(String? localFile) async{
    if(localFile!=null)
      {
        downloadFile='100%';
        file=File(widget.message.localFile!);
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
        downloadFile='100%';
        setState(() {

        });
      }
      else{

        //  Dio dio=Dio();
        //  download(dio, widget.message.all_file!, filePath);
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
      child: Row(
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
                    imageUrl:widget.message.user!.img?? "https://www.room.tecknick.net/WI.jpeg",
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
          if(widget.message.all_file!.length>35
              ||widget.message.user!.name!.length>35)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(

                      decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(0.5),
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

                                  Expanded(
                                    child: Text(
                                      widget.message.user!.name!,
                                      style: TextStyle(
                                          color: ColorManager.backgroundColor,
                                          fontSize: 13.sp,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600
                                      ),
                                      textAlign: TextAlign.start,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: ColorManager.backgroundColor,

                              thickness: 1,
                              height: 3.h,
                            ),
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
                                    ),textAlign: TextAlign.start,),
                                  SizedBox(
                                    width: 6.w,
                                  ),
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
                                        ),textAlign: TextAlign.start,),
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
                  const Expanded(
                    child: SizedBox(
                    ),
                  ),

                ],
              ),
            )else
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.5),
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
                    Container(
                      decoration:
                      widget.message.all_file!.length<=
                          widget.message.user!.name!.length?
                      const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: ColorManager.backgroundColor,
                            )
                        ),
                      ):const BoxDecoration(),

                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: 12.w
                        ),
                        child: Text(widget.message.user!.name!,
                          style: TextStyle(
                              color: ColorManager.backgroundColor,
                              fontSize: 13.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.start,

                        ),
                      ),
                    ),


                    Row(
                      children: [
                        Icon(
                          Icons.file_copy_outlined,
                          color: ColorManager.backgroundColor,
                          size: 22.w,
                        ),
                        SizedBox(
                          width: 6.w,
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
    );
  }



}
