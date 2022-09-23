import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/core/widget/photo_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

import '../../../model/private_old_message_data_model.dart';




class MessageImageSideOne extends StatefulWidget {
  final PrivateOldMessageDataModel message;
  const MessageImageSideOne({Key? key,required this.message}) :
        super(key: key);

  @override
  _MessageImageSideOneState createState() => _MessageImageSideOneState();
}

class _MessageImageSideOneState extends State<MessageImageSideOne> {

  File? file ;
  @override
  void initState() {
    isLocal(widget.message.localFile);


    super.initState();
  }


  Future isLocal(String? localFile) async{
    if(localFile!=null)
    {
      file = File(localFile);
      setState(() {

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
      File fileTwo = File(filePath);

      if (await fileTwo.exists()) {
        file =fileTwo;
        setState(() {

        });
      }
      else{


        Dio dio=Dio();
        download(dio, widget.message.all_file!, filePath);


      }
    }}



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
      File fileTwo = File(savePath);
      var raf = fileTwo.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      file=fileTwo;
      setState(() {

      });
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
        file!=null?
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder:
                (context) => PhotoViewWidget(
              file: file!,
              networkImage: null,

            ) ,));
          },
          child: Image.file(file!,
          ),
        ):
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder:
                (context) => PhotoViewWidget(
              file: null,
              networkImage: widget.message.all_file??
                  "https://www.room.tecknick.net/WI.jpeg",

            ) ,));
          },
          child: CachedNetworkImage(
            imageUrl: widget.message.all_file??
                "https://www.room.tecknick.net/WI.jpeg",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(

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
         SizedBox(
           width: 80.w,
         ),



      ],
    );
  }



}
