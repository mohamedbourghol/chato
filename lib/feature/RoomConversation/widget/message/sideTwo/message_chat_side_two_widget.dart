import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Globals.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../User/user.dart';
import '../../../model/conversationMessage/conversation_old_message_data_model.dart';





class MessageChatSideTwo extends StatefulWidget {
  final ConversationOldMessageDataModel message;
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
     if(widget.message.message!.startsWith('http')
    && widget.message.message!.contains('smiles')
    ) {
       return Row(
         mainAxisAlignment: MainAxisAlignment.end,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [

           Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   CachedNetworkImage(
                     imageUrl: widget.message.message??
                         "https://www.room.tecknick.net/WI.jpeg",
                     imageBuilder: (context, imageProvider) => Container(
                       height: 120.w,
                       width: 120.w,
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
                 ],
               ),
             ],
           ),

           SizedBox(
             width: 6.w,
           ),
           GestureDetector(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>
                     UserScreen(id: widget.message.user!.id!,)),
               );
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
                 if(widget.message.user!.vip_user!=null)
                   SizedBox(
                     width:widget.message.user!.vip_user!.vip_id=="1"?64.h: 75.h,
                     height: widget.message.user!.vip_user!.vip_id=="1"?64.h: 75.h,
                     child:Image.asset(
                       widget.message.user!.vip_user!.vip_id=="1"?
                       'assets/images/solider_frame.png':
                       widget.message.user!.vip_user!.vip_id=="2"?
                       'assets/images/knight_frame.png':
                       widget.message.user!.vip_user!.vip_id=="3"?
                       'assets/images/minister_frame.png':
                       'assets/images/king_frame.png',
                       fit: BoxFit.fill,
                     ),
                   ),
               ],
             ),
           ),





         ],
       );
     }
     else{
       return Row(
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
                                       textAlign: TextAlign.end,

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
                   crossAxisAlignment: CrossAxisAlignment.end,

                   children: [
                     Container(
                       decoration:
                       widget.message.message!.length<=
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
                           textAlign: TextAlign.end,

                         ),
                       ),
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
                     ),
                   ],
                 ),
               ),
             ),

           SizedBox(
             width: 6.w,
           ),
           GestureDetector(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>
                     UserScreen(id: widget.message.user!.id!,)),
               );
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
                 if(widget.message.user!.vip_user!=null)
                   SizedBox(
                     width:widget.message.user!.vip_user!.vip_id=="1"?64.h: 75.h,
                     height: widget.message.user!.vip_user!.vip_id=="1"?64.h: 75.h,
                     child:Image.asset(
                       widget.message.user!.vip_user!.vip_id=="1"?
                       'assets/images/solider_frame.png':
                       widget.message.user!.vip_user!.vip_id=="2"?
                       'assets/images/knight_frame.png':
                       widget.message.user!.vip_user!.vip_id=="3"?
                       'assets/images/minister_frame.png':
                       'assets/images/king_frame.png',
                       fit: BoxFit.fill,
                     ),
                   ),
               ],
             ),
           ),

           //   Image.asset('assets/stickers/01_Cuppy_smile.webp',
           //    width: 40.w,
           //     fit: BoxFit.fill,
           //   ),



         ],
       );
     }

  }



}
