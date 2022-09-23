import 'dart:io';

import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/feature/RoomConversation/widget/setting/show_admin_bottom_sheet.dart';
import 'package:chato/feature/RoomConversation/widget/setting/show_blocked_bottom_sheet.dart';
import 'package:chato/feature/RoomConversation/widget/setting/show_owners_bottom_sheet.dart';
import 'package:chato/feature/RoomConversation/widget/setting/show_user_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../Pages/ProfilePage/widget/crop_page.dart';
import '../../bloc/room_conversation_bloc.dart';
import '../../bloc/room_conversation_state.dart';
import '../background_widget.dart';

class RoomSettings extends StatefulWidget {
  final RoomConversationBloc bloc;
  final int roomId;
  final int? ownerId;

  const RoomSettings(
      {Key? key,
      required this.bloc,
      required this.roomId,
      required this.ownerId})
      : super(key: key);

  @override
  _RoomSettingsState createState() => _RoomSettingsState();
}

class _RoomSettingsState extends State<RoomSettings> {
  bool hideState = false;
  bool lockState = false;
  TextEditingController pinCode = TextEditingController();
   bool first=true;
  @override
  void initState() {

    widget.bloc.onGetAllTypeEvent('user', widget.roomId);
    widget.bloc.onGetAllTypeEvent('owner', widget.roomId);
    widget.bloc.onGetAllTypeEvent('admin', widget.roomId);
    widget.bloc.onGetBlockedEvent(widget.roomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomConversationBloc, RoomConversationState>(
      bloc: widget.bloc,
      listener: (context, state) {


      },
      child: BlocBuilder<RoomConversationBloc, RoomConversationState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios,
                              size: 19.w,
                              color: Theme.of(context).primaryColorDark),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          'Room Settings',
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: Theme.of(context).primaryColorDark),
                          textAlign: TextAlign.center,
                        ).tr(),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    if (false)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Only for members".tr(),
                            style: getRegularStyle(
                                fontSize: 15.sp,
                                color: Global.darkMode
                                    ? ColorManager.backGroundIcon
                                    : ColorManager.textColor),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    width: 1,
                                    color: Global.darkMode
                                        ? ColorManager.hintText
                                        : ColorManager.textColor)),
                            child: FlutterSwitch(
                                toggleSize: 20.h,
                                padding: 0,
                                toggleColor: ColorManager.primaryColor,
                                activeColor: ColorManager.backgroundColor,
                                inactiveColor: ColorManager.backgroundColor,
                                height: 20.h,
                                width: 50.w,
                                value: lockState,
                                onToggle: (val) {
                                  setState(() {
                                    lockState = val;
                                  });
                                }),
                          )
                        ],
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (Global.userId == widget.ownerId!) ...[
                      InkWell(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CropPage(
                                  title: 'Select Image'.tr(),
                                ),
                              )).then((value) {
                            if (value != null) {
                              File file = File(value.path!);
                              widget.bloc
                                  .onChangeRoomImageEvent(file, widget.roomId);
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/change_room_image.svg",
                                  height: 25.h,
                                  width: 25.w,
                                  color: ColorManager.primaryColor,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "change room image".tr(),
                                  style: getRegularStyle(
                                      fontSize: 14.sp,
                                      color: Global.darkMode
                                          ? ColorManager.backGroundIcon
                                          : ColorManager.textColor),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 22.w,
                                  color: ColorManager.primaryColor,
                                )),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BackgroundImagesScreen(
                                  bloc: widget.bloc,
                                  roomId: widget.roomId,
                                ),
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/change_background.svg",
                                  height: 25.h,
                                  width: 25.w,
                                  color: ColorManager.primaryColor,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "change room background".tr(),
                                  style: getRegularStyle(
                                      fontSize: 14.sp,
                                      color: Global.darkMode
                                          ? ColorManager.backGroundIcon
                                          : ColorManager.textColor),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 22.w,
                                  color: ColorManager.primaryColor,
                                )),
                          ],
                        ),
                      ),
                    ],
                    if (Global.userId == widget.ownerId! ||
                        state.userPermission == 'owner') ...[
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          showOwnersBottomSheet(
                              context, widget.bloc,widget.ownerId!,
                         widget.roomId
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/owner.svg",
                                  height: 25.h,
                                  width: 25.w,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "owners".tr(),
                                  style: getRegularStyle(
                                      fontSize: 15.sp,
                                      color: Theme.of(context).hintColor),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                state.allTypeOwner.data != null
                                    ? state.allTypeOwner.data!.length.toString()
                                    : '0',
                                style: getRegularStyle(
                                    fontSize: 15.sp,
                                    color: Theme.of(context).hintColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (Global.userId == widget.ownerId! ||
                        state.userPermission == 'owner' ||
                        state.userPermission == 'admin') ...[
                      SizedBox(
                        height: 15.h,
                      ),
                      InkWell(
                        onTap: () {
                          showAdminBottomSheet(context, widget.bloc,widget.ownerId!,
                              widget.roomId);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/supervisors.svg",
                                  height: 25.h,
                                  width: 25.w,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "supervisors".tr(),
                                  style: getRegularStyle(
                                      fontSize: 15.sp,
                                      color: Theme.of(context).hintColor),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                state.allTypeAdmin.data != null
                                    ? state.allTypeAdmin.data!.length.toString()
                                    : '0',
                                style: getRegularStyle(
                                    fontSize: 15.sp,
                                    color: Theme.of(context).hintColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        showUserBottomSheet(context, widget.bloc);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/profile.svg",
                                height: 25.h,
                                width: 25.w,
                                color: ColorManager.primaryColor,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "members".tr(),
                                style: getRegularStyle(
                                    fontSize: 15.sp,
                                    color: Theme.of(context).hintColor),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              state.allTypeUser.data != null
                                  ? state.allTypeUser.data!.length.toString()
                                  : '0',
                              style: getRegularStyle(
                                  fontSize: 15.sp,
                                  color: Theme.of(context).hintColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    if (Global.userId == widget.ownerId! ||
                        state.userPermission == 'owner' ||
                        state.userPermission == 'admin') ...[
                      InkWell(
                        onTap: () {
                          showBlockedBottomSheet(
                              context, widget.bloc, widget.roomId);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/blocked.svg",
                                  height: 25.h,
                                  width: 25.w,
                                  color: ColorManager.primaryColor,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "blocked".tr(),
                                  style: getRegularStyle(
                                      fontSize: 15.sp,
                                      color: Theme.of(context).hintColor),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                state.allTypeBlock.data != null
                                    ? state.allTypeBlock.data!.length.toString()
                                    : "0",
                                style: getRegularStyle(
                                    fontSize: 15.sp,
                                    color: Theme.of(context).hintColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                    if (false)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/blocked.svg",
                                height: 25.h,
                                width: 25.w,
                                color: ColorManager.primaryColor,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "permanently banned".tr(),
                                style: getRegularStyle(
                                    fontSize: 15.sp,
                                    color: Theme.of(context).hintColor),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              "0",
                              style: getRegularStyle(
                                  fontSize: 15.sp,
                                  color: Theme.of(context).hintColor),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 15.h,
                    ),
                    if (false)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/archive.svg",
                                height: 25.h,
                                width: 25.w,
                                color: ColorManager.primaryColor,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "room archive".tr(),
                                style: getRegularStyle(
                                    fontSize: 14.sp,
                                    color: Global.darkMode
                                        ? ColorManager.backGroundIcon
                                        : ColorManager.textColor),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 22.w,
                                color: ColorManager.primaryColor,
                              )),
                        ],
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
