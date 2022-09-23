import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/color_manager.dart';
import '../../bloc/room_conversation_bloc.dart';
import '../../bloc/room_conversation_state.dart';



class SmileAndSticker extends StatelessWidget {
 final RoomConversationBloc bloc;
 final int roomId;
   const SmileAndSticker({Key? key,required this.bloc,
     required this.roomId
   }) :
         super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomConversationBloc,RoomConversationState>(
      bloc: bloc,
      builder: (context, state) {
      return  Column(
          children: [
            if(state.smileOrSticker)
            Offstage(
              offstage: !state.showEmoji,
              child: SizedBox(
                height: 300.h,
                child: EmojiPicker(
                    onEmojiSelected: (Category category, Emoji emoji) {
                      bloc.onAddSmileEvent( emoji.emoji);
                    },
                    onBackspacePressed: (){
                      bloc.onShowEmojiEvent(false);
                    },
                    config: Config(
                        columns: 7,
                        // Issue: https://github.com/flutter/flutter/issues/28894
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        initCategory: Category.RECENT,
                        bgColor: const Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        progressIndicatorColor: Colors.blue,
                        backspaceColor: Colors.blue,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        noRecentsText: tr('No Recents'),
                        noRecentsStyle:  TextStyle(
                            fontSize: 20.sp, color: Colors.black26),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL)),
              ),
            )else
              Offstage(
                offstage: !state.showEmoji,
                child: Container(
                  color: const Color(0xfff2f2f2),
                  height: 300.h,
                  width: 1.sw,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 12.w
                    ),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/1.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/shy.svg',
                                   width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('shy',style: TextStyle(
                                    fontSize: 14.sp,
                                    color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/2.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/annoyed.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('annoyed',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/3.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/lol.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('lol',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/4.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/angery.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('angery',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/5.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/headache.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('headache',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/6.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/happiness.svg'
                                    ,width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('happiness',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/7.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/laugh.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('laugh',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/8.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/drowsiness.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('drowsiness',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/9.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/some_shyness.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('some shyness',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/10.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/Kiss.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('Kiss',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/11.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/angry_kiss.svg'
                                    ,width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('angry kiss',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/12.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/wink.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('wink',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/13.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/look_at_you.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('look at you',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                bloc.onSendMessageEvent("https://room.tecknick.net/smiles/14.png", roomId,
                                    null, true);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/stickers/fan.svg',
                                    width: 55.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text('fan',style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.textColor
                                  ),).tr(),
                                ],
                              ),
                            ),
                             SizedBox(
                              width: 55.w,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            Visibility(
              visible: state.showEmoji,
              child: Column(
                children: [
                  Divider(
                    height: 1.h,
                    color: ColorManager.darkPrimary,

                  ),
                  Container(
                    color: const Color(0xfff2f2f2),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                          vertical: 8.h
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              if(!state.smileOrSticker)
                                {
                                  bloc.onSwitchSmileStickerEvent(true);
                                }


                            },
                            child: SvgPicture.asset('assets/icons/smile.svg',
                              width: 28.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: 22.w,

                          ),
                          InkWell(
                            onTap: (){
                              if(state.smileOrSticker)
                              {
                                bloc.onSwitchSmileStickerEvent(false);
                              }
                            },
                            child: SvgPicture.asset('assets/icons/sticker.svg',
                              width: 28.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },

    );
  }
}
