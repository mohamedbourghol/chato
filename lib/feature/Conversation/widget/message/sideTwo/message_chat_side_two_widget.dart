import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../model/private_old_message_data_model.dart';





class MessageChatSideTwo extends StatefulWidget {
  final PrivateOldMessageDataModel message;
  const MessageChatSideTwo({Key? key,required this.message}) :
        super(key: key);

  @override
  _MessageChatSideTwoState createState() => _MessageChatSideTwoState();
}

class _MessageChatSideTwoState extends State<MessageChatSideTwo> {


  @override
  void initState() {
    super.initState();
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
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: 12.w
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if(widget.message.message!.length>35
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
                                  Expanded(
                                    child: InkWell(
                                      onTap:isUrl (widget.message.message!)?()
                                     async {
                                       await launch(widget.message.message!);
                                      }:null,
                                      child: Text(widget.message.message!
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
                    vertical: 6.h,
                  horizontal: 6.w
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [



                    InkWell(
                      onTap:isUrl(widget.message.message!)? () async {
                        await launch(widget.message.message!);
                      }:null,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(widget.message.message!,
                          style: TextStyle(
                              color:isUrl(widget.message.message!)?
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
            ),






        ],
      ),
    );
  }



}
