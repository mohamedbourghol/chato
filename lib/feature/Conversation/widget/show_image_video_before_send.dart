import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../core/utils/color_manager.dart';
import '../bloc/conversation_bloc.dart';



class ShowImageVideoBeforeSendCon extends StatefulWidget {
   final  File file;
   final ConversationBloc bloc;
   final int roomId;
  const ShowImageVideoBeforeSendCon({Key? key,
   required this.file,
    required this.bloc,
    required this.roomId
  }) : super(key: key);

  @override
  _ShowImageVideoBeforeSendConState createState() => _ShowImageVideoBeforeSendConState();
}

class _ShowImageVideoBeforeSendConState extends State<ShowImageVideoBeforeSendCon> {

   TextEditingController textEditingController=
       TextEditingController();
   late VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if( checkIsVideo(widget.file.path))
      {
        _controller = VideoPlayerController.file(
            widget.file)
          ..initialize().then((_) {
            setState(() {});
          });
      }
  }

  bool checkIsVideo(String? endUrl) {
    if (endUrl != null) {
      if (endUrl.contains('mp4') ||
          endUrl.contains('mov') ||
          endUrl.contains('wmv') ||
          endUrl.contains('avi') ||
          endUrl.contains('3gp') ||
          endUrl.contains('flv')) {
        return true;
      }
    }


    return false;
  }

  bool checkIsImage(String? endUrl) {
    if (endUrl != null) {
      endUrl = endUrl.substring(endUrl.length - 4, endUrl.length);
      if (endUrl.contains('jpeg') ||
          endUrl.contains('jpg') ||
          endUrl.contains('png') ||
          endUrl.contains('gif')) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.darkPrimary,
        body: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.only(
                top: 16.h,
                right: 12.w,
                bottom: 12.w
              ),
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(
                    Icons.close,
                    size: 22.w,
                    color: ColorManager.backgroundColor,
                  )),
                ],
              ),
            ),
            if( checkIsImage(widget.file.path))
              Image.file(widget.file,
                height: 0.7.sh,

              ),
            if(checkIsVideo(widget.file.path))
              _controller!.value.isInitialized
                  ? SizedBox(
                     height: 0.7.sh,
                      child: VideoPlayer(_controller!),
              )
                  : Container(),

            SizedBox(height: 20.h,),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
               child: Container(
                 decoration: BoxDecoration(
                     borderRadius:
                     BorderRadius.circular(25.w),
                     border: Border.all(
                       color: ColorManager
                           .backgroundColor,
                     )),
                 child: Row(
                   children: [
                     Expanded(
                     child: TextField(
                       keyboardType:
                       TextInputType
                           .multiline,
                       minLines: 1,
                       maxLines: 5,
                       controller:
                       textEditingController,
                       onEditingComplete:
                           () {
                         FocusScope.of(
                             context).unfocus();
                       },
                       onSubmitted:
                           (st) {
                         FocusScope.of(
                             context)
                             .unfocus();

                       },
                       style: TextStyle(
                         fontSize: 15.sp,
                         color: ColorManager
                             .backgroundColor,
                         height: 1.5.h,
                       ),
                       cursorColor:
                       ColorManager
                           .backgroundColor,
                       decoration:
                       InputDecoration(
                         contentPadding:
                         EdgeInsets
                             .symmetric(
                           horizontal:
                           12.w,
                         ),
                         enabledBorder:
                         InputBorder
                             .none,
                         focusedBorder:
                         InputBorder
                             .none,
                         disabledBorder:
                         InputBorder
                             .none,
                         border:
                         InputBorder
                             .none,
                         hintText: tr(
                             'write message'),
                         hintStyle:
                         TextStyle(
                           fontSize:
                           15.sp,
                           color: ColorManager
                               .backgroundColor,
                         ),
                         focusColor:
                         ColorManager
                             .backgroundColor,
                         fillColor:
                         ColorManager
                             .backgroundColor,
                       ),
                     ),
                   ),
                     IconButton(
                         onPressed: () {
                           widget.bloc.onSendMessageEvent(
                               textEditingController
                                   .text,
                               widget.roomId,
                               widget.file);

                           if (FocusScope.of(
                               context)
                               .hasFocus) {
                             textEditingController
                                 .clear();
                           }
                           widget.bloc.onStartRecord(
                               false);
                           Navigator.pop(context);
                         },
                         icon: Icon(
                           Icons.send,
                           color: ColorManager
                               .backgroundColor,
                           size: 22.w,
                         )),

                   ],
                 ),
               ),
             ),
            SizedBox(height: 20.h,),
          ],
        ),

      ),
    );
  }
}
