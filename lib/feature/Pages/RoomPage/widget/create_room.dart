import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:profanity_filter/profanity_filter.dart';
import '../../../../injection.dart';
import '../bloc/room_bloc.dart';
import '../bloc/room_state.dart';

class CreateRoom extends StatefulWidget {
  final RoomBloc bloc;
  const CreateRoom({Key? key,required this.bloc}) : super(key: key);

  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
   TextEditingController controller=
       TextEditingController(text: '');


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc,RoomState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if(state.createRoomModel.message!.isNotEmpty)
          {
            AwesomeDialog(
              context: context,
              dialogType:state.createRoomModel.status!?
                DialogType.SUCCES:  DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title:tr(state.createRoomModel.message!) ,
              titleTextStyle: TextStyle(
                fontSize: 16.sp,
              ),
              btnCancelText: tr('ok'),
              btnCancelColor:ColorManager.primaryColor ,
              btnCancelOnPress: () {
                if(state.createRoomModel.status!)
                  {
                    Navigator.pop(context);
                  }
              },
            ).show();
          }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state.isLoading!,
          child: SafeArea(
              child: Scaffold(
                  body: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: (){
                                Navigator.pop(context);
                                  },
                                  icon:  Icon(
                                      Icons.arrow_back,
                                    size: 22.w,
                                  )),
                              Text(
                                "Create Conversation Room".tr(),
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    color: ColorManager.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width:32.w,),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 100.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(90),
                                            bottomLeft: Radius.circular(90)),
                                        border: Border.all(
                                            color: ColorManager.primaryColor, width: 1)),
                                    height: 150.h,
                                    width: 80.w,
                                  )
                                ],
                              ),
                              const Expanded(child: SizedBox()),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(75)),
                                        border: Border.all(
                                            color: ColorManager.primaryColor, width: 1)),
                                    height: 150.h,
                                    width: 150.w,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Text(
                                      "Room Name".tr(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                        color: ColorManager.primaryColor,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  height: 50.h,
                                  child: TextField(
                                    controller: controller,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Theme.of(context).primaryColorDark
                                    ),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        const BorderSide(color: ColorManager.primaryColor),
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        const BorderSide(color: ColorManager.primaryColor),
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(
                                      "1500".tr(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.sp,
                                        color: ColorManager.primaryColor,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    SvgPicture.asset(
                                        'assets/icons/coins.svg',
                                      width: 22.w,
                                    ),

                                  ],
                                ),
                                SizedBox(height: 200.h,),
                                InkWell(
                                  onTap: (){
                                    if(double.tryParse(Global.userCoins!)! >1500)
                                      {
                                        final filter =sl<ProfanityFilter> ();
                                        bool hasProfanity=  filter.hasProfanity(controller.text);
                                        if(!hasProfanity)
                                        {
                                          if(controller.text.isNotEmpty) {
                                            widget.bloc.onCreateRoomEvent
                                              (controller.text);
                                          }
                                        }
                                        else{
                                          Fluttertoast.showToast(
                                              msg: 'Room name contains profanity'.tr(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: ColorManager.primaryColor,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }
                                      }
                                    else{
                                      Fluttertoast.showToast(
                                          msg: 'There is not enough balance'.tr(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: ColorManager.primaryColor,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }





                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    height: 100.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        color: ColorManager.backgroundColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: ColorManager.primaryColor
                                        )
                                    ),
                                    child: Container(alignment: Alignment.center,height: 90.h,
                                      width: 90.w,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorManager.primaryColor
                                      ),child: Text("Create".tr(),style: TextStyle(
                                          color: ColorManager.backgroundColor,
                                          fontSize: FontSize.s20,
                                          fontWeight: FontWeight.bold
                                      ),),),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))),
        );
      },

    );
  }
}
