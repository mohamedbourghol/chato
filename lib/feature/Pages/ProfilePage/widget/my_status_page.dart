import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/feature/Pages/ProfilePage/bloc/prof_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../Globals.dart';
import '../../../../core/utils/color_manager.dart';





class MyStatusPage extends StatefulWidget {
  final ProfBloc profBloc;

  const MyStatusPage({
    Key? key,
    required this.profBloc
  }) : super(key: key);

  @override
  _MyStatusPageState createState() => _MyStatusPageState();
}

class _MyStatusPageState extends State<MyStatusPage> {

  bool checkIsImage(String? endUrl)
  {

    if(endUrl!=null)
    {
      endUrl= endUrl.substring(endUrl.length-4,endUrl.length);
      if(endUrl.contains('jpeg')
          ||endUrl.contains('jpg')
          ||endUrl.contains('png')
          ||endUrl.contains('gif')
      )
      {
        return true;
      }

    }

    return false;
  }
    late List<VideoPlayerController?>?  videoPlayer=[];
    int i=-1;

  @override
  void initState() {


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          Expanded(child: Row(
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(
                Icons.arrow_back_ios,
                size: 22.w,
                color: ColorManager.backgroundColor,
              )),
              Expanded(
                child: Text("My Status",
                  style: TextStyle(
                    fontSize: 19.sp,

                  ),
                  textAlign: TextAlign.center,
                ).tr(),
              ),
              SizedBox(width: 42.w,),

            ],
          ),)
        ],
        backgroundColor: ColorManager.primaryColor,
        leading: const SizedBox(),
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:Global.myStatus!.isNotEmpty?

        ListView.builder(itemBuilder: (context, index) {
          if(!checkIsImage(Global.myStatus![index].status))
            {


              videoPlayer!.add(
              VideoPlayerController.network(
                  Global.myStatus![index].status!)
                ..initialize().then((_) {
                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                  setState(() {});
                })
              );
            }
          else{
            videoPlayer!.add(null);
          }
           return  Padding(
            padding:  EdgeInsets.symmetric(
                vertical: 12.h
            ),
            child: Row(
              children: [
            if(checkIsImage(Global.myStatus![index].status))
                CachedNetworkImage(
                  height: 70.w,
                  width: 70.w,
                  imageUrl: Global.myStatus![index].status!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,

                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
            else
              ClipRRect(

                borderRadius: BorderRadius.circular(55.0),
                child: SizedBox(
                  height: 70.w,
                  width: 70.w,


                  child: VideoPlayer(videoPlayer![index]!),
                ),
              ),
                SizedBox(
                  width: 6.w,
                ),
                Expanded(child: Text('My Status',
                  style: TextStyle(
                      fontSize: 17.sp,

                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).disabledColor
                  ),
                ).tr()),
                PopupMenuButton(
                    color: ColorManager.darkPrimary,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry>[


                      PopupMenuItem(
                        onTap: (){
                          widget.profBloc.onDeleteStatusEvent(
                              Global.myStatus![index].id!);
                          Global.myStatus!.removeAt(index);
                          setState(() {

                          });

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete,
                              color: ColorManager.backgroundColor,
                              size: 22.w,
                            ),
                            SizedBox(
                              width: 6.w,
                            ),

                            Text('Delete',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ColorManager.backgroundColor
                              ),
                            ).tr(),
                          ],
                        ),
                      ),



                    ]),
                SizedBox(
                  width: 6.w,
                ),
              ],
            ),
          );
        },

        itemCount: Global.myStatus!.length,
        ):
        Center(
          child: Text('No Status',
          style: TextStyle(
              fontSize: 19.sp,

              fontWeight: FontWeight.w700,
              color: Theme.of(context).disabledColor
          ),
          ),
        )

        ,
      )
      ,
    );
  }


}