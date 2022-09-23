
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/feature/RoomConversation/bloc/room_conversation_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/color_manager.dart';
import '../bloc/room_conversation_bloc.dart';





class BackgroundImagesScreen extends StatefulWidget {
  final RoomConversationBloc bloc;
  final int roomId;

  const BackgroundImagesScreen({Key? key,
    required this.bloc,
    required this.roomId

  }) : super(key: key);

  @override
  _BackgroundImagesScreenState createState() => _BackgroundImagesScreenState();
}

class _BackgroundImagesScreenState extends State<BackgroundImagesScreen> {


  @override
  void initState() {
    widget.bloc.onGetBackgroundImageEvent();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomConversationBloc,RoomConversationState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80.h,
              actions: [
                Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme
                                .of(context)
                                .primaryColor,
                            Theme
                                .of(context)
                                .primaryColor,
                          ]
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 12.h
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20.w,
                                color: ColorManager.backgroundColor,
                              ),
                            ),




                            Expanded (
                              child: Text('Change Background',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: ColorManager.backgroundColor),
                                textAlign: TextAlign.center,

                              ).tr(),
                            ),
                            SizedBox(width: 25.w,),


                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),

                      ],
                    ),
                  ),


                )
              ],
            ),
            body: SizedBox(
              height: 1.sh-80.h,
              child:  Padding(
                padding:  const EdgeInsets.all(4.0),
                child: GridView.builder(
                  gridDelegate: const
                  SliverGridDelegateWithFixedCrossAxisCount(
                    // number of items per row
                      crossAxisCount: 2,
                      // vertical spacing between the items
                      mainAxisSpacing: 5,
                      // horizontal spacing between the items
                      crossAxisSpacing: 5,

                      childAspectRatio: 0.75
                  ),
                  // number of items in your list
                  itemCount: state.backgroundImageModel.data!.length,
                  itemBuilder: (context,i){
                    return InkWell(
                      onTap: (){
                        widget.bloc.onChangeBackgroundImageEvent
                          (
                            state.backgroundImageModel.data![i].id,
                            state.backgroundImageModel.data![i].background,
                          widget.roomId

                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: CachedNetworkImage(
                        imageUrl: state.backgroundImageModel.data![i].background!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(17.w),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,

                            ),
                          ),
                        ),
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    );
                  },
                ),
              ),
            ),


          ),
        );
      },

    );
  }

}