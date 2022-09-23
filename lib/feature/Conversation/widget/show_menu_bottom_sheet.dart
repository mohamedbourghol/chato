

import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/feature/Conversation/bloc/conversation_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../User/user.dart';
import '../bloc/conversation_bloc.dart';


void showMenuBottomSheet({
  required BuildContext ctx,
  required int userTwoId,
  required ConversationBloc bloc
}) {

  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.w),
          topRight: Radius.circular(30.w),
        ),
        side: const BorderSide(
          color: ColorManager.darkBackgroundColor,
          width: 2
        ),
      ),

      builder: (ctx) => BlocConsumer<ConversationBloc,
          ConversationState>(
        bloc: bloc,
        listener: (context, state) {
           if(state.isSuccessBloc!)
             {
               Fluttertoast.showToast(
                   msg: state.blocUser,
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIosWeb: 1,
                   backgroundColor: ColorManager.primaryColor,
                   textColor: Colors.white,
                   fontSize: 16.0
               );
             }
        },
        builder: (context, state) {

          return  Container(

            width: 1.sw,
            height: 300.h,

            alignment: Alignment.center,
            child:state.isLoadingBloc!?
                const Center(
                  child: CircularProgressIndicator(),
                ):
            Column(
              children: [
                SizedBox(height: 40.h,),
                SizedBox(
                  width: 0.5.sw,
                  child: ElevatedButton(
                      child: Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorManager.primaryColor
                          )
                      ).tr(),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(ColorManager.primaryColor),
                          backgroundColor: MaterialStateProperty.all<Color>(ColorManager.backgroundColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: const BorderSide(color: ColorManager.primaryColor)
                              )
                          ),
                          padding:MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                              vertical: 15.h
                          ))
                      ),
                      onPressed: () {
                        Navigator.push(ctx,
                            MaterialPageRoute(builder: (context) =>
                                UserScreen(id: userTwoId,) ,));
                      }
                  ),
                ),
                SizedBox(height: 20.h,),
                SizedBox(
                  width: 0.5.sw,
                  child: ElevatedButton(
                      child: Text(
                          "block",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorManager.primaryColor
                          )
                      ).tr(),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(ColorManager.primaryColor),
                          backgroundColor: MaterialStateProperty.all<Color>(ColorManager.backgroundColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: const BorderSide(color: ColorManager.primaryColor)
                              )
                          ),
                          padding:MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                              vertical: 15.h
                          ))
                      ),
                      onPressed: () {
                        bloc.onBlockUserEvent(userTwoId);
                      }
                  ),
                ),
                SizedBox(height: 20.h,),
                SizedBox(
                  width: 0.5.sw,
                  child: ElevatedButton(
                      child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorManager.primaryColor
                          )
                      ).tr(),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(ColorManager.primaryColor),
                          backgroundColor: MaterialStateProperty.all<Color>(ColorManager.backgroundColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: const BorderSide(color: ColorManager.primaryColor)
                              )
                          ),
                          padding:MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                              vertical: 15.h
                          ))
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                      }
                  ),
                ),

              ],
            ),
          );
        },

      ));
}