import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/Globals.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideOne/file_chat_side_one_widget.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideOne/image_side_one_widget.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideOne/map_side_one_widget.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideOne/message_chat_side_one_widget.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideOne/message_video_side_one_widget.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideOne/music_side_one_widget.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideTwo/image_side_two_widget.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideTwo/map_side_two_widget.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideTwo/message_chat_side_two_widget.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideTwo/message_video_side_two_widget.dart';
import 'package:chato/feature/RoomConversation/widget/message/sideTwo/music_side_two_widget.dart';
import 'package:chato/feature/RoomConversation/widget/send_gift_bottom_sheet.dart';
import 'package:chato/feature/RoomConversation/widget/setting/room_settings.dart';
import 'package:chato/feature/RoomConversation/widget/setting/show_vip_bottom_sheet.dart';
import 'package:chato/feature/RoomConversation/widget/show_menu_bottom_sheet_rocket.dart';
import 'package:chato/feature/RoomConversation/widget/smile&sticker/smile_and_sticker.dart';
import 'package:chato/feature/User/model/user_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_utils/keyboard_aware/keyboard_aware.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pusher_client/pusher_client.dart';
import '../../../core/utils/color_manager.dart';
import '../../injection.dart';
import '../Pages/pages_screen.dart';
import 'model/conversationMessage/message_pusher_model.dart';
import 'bloc/room_conversation_bloc.dart';
import 'bloc/room_conversation_state.dart';
import 'widget/show_media_bottom_sheet.dart';
import 'dart:io' as io;

// ignore: must_be_immutable
class RoomConversationScreen extends StatefulWidget {
  final int roomId;
  final String? background;
  final String? roomImage;
  final String? roomName;
  String? fav;
  final int? ownerId;

  RoomConversationScreen(
      {Key? key,
      required this.roomId,
      required this.background,
      required this.fav,
      required this.ownerId,
      required this.roomName,
      required this.roomImage})
      : super(key: key);

  @override
  _RoomConversationScreenState createState() => _RoomConversationScreenState();
}

class _RoomConversationScreenState extends State<RoomConversationScreen> {
  ScrollController scrollController = ScrollController();
  ScrollController singleScrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  RoomConversationBloc bloc = sl<RoomConversationBloc>();
  Channel? channelChat;
  bool showProgress = false;
  FlutterAudioRecorder2? _recorder;
  Recording? _current;
  late RecordingStatus _currentStatus;
  late Timer timer;
  bool update = false;
  bool down = false;

  @override
  void initState() {
    _init();
    Global.currentRoomId = widget.roomId.toString();
    _currentStatus = RecordingStatus.Unset;
    //   bloc.onGetConversationMessage(widget.roomId);
    bloc.onGetPermeationEvent(widget.roomId);
    bloc.onGetAllTypeEvent('', widget.roomId);
    channelChat = Global.pusher!.subscribe("chat.${widget.roomId}");

    channelChat!.bind('App\\Events\\ChatEvent', (event) {
      log("event.toString()");

      Map<String, dynamic> arguments =
          (json.decode(event!.data!) ?? {}) as Map<String, dynamic>;

      MessagePusherModel message = MessagePusherModel.fromJson(arguments);

      scrollController.addListener(() {
        if (scrollController.offset + 3 <=
            scrollController.position.maxScrollExtent) {
          if (!down) {
            down = true;
            setState(() {});
          }
        } else {
          if (down) {
            down = false;
            setState(() {});
          }
        }
      });

      ///receiveMassage
      ///
      if (message.msg.user_send != null) {
        int roomIdPusher = arguments['room_id'];

        if (roomIdPusher.toString() == Global.currentRoomId) {
          UserData user = UserData.fromJson(arguments['user']);

          bloc.onAddGiftEvent(
              true,
              message.msg.user_send! + " Send to".tr() + '\n' + user.name!,
              message.msg.gift!.img!,
              message.msg.gift!.name!.contains('rich'));

          Future.delayed(const Duration(seconds: 3)).then((value) {
            bloc.onAddGiftEvent(
                false, message.msg.name!, message.msg.gift!.img!, false);
          });
        }
      }

      else if (message.msg.type == null) {
        UserData user = UserData.fromJson(arguments['user']);
        message.msg.user = user;
        String roomIdPusher = arguments['room_id'];
        if (user.id != Global.userId && roomIdPusher == Global.currentRoomId) {
          bloc.onAddMessageFromPusherEvent(message.msg);
          if (!(scrollController.offset + 3 <=
              scrollController.position.maxScrollExtent)){
            Future.delayed(Duration(milliseconds: 1500)).then((value) {
              scrollController.animateTo(scrollController.position.maxScrollExtent,
                  duration: Duration(seconds: 1), curve: Curves.linearToEaseOut);
            });
          }
        }
      }

      ///rocket
      else if (message.msg.type == 'add_room_trend') {
        if (message.msg.room_id.toString() == Global.currentRoomId) {
          UserData user = UserData.fromJson(arguments['user']);
          bloc.onChangeRocketEvent(true, user.name!, message.msg.x_number ?? 1);
          Future.delayed(const Duration(seconds: 3)).then((value) {
            bloc.onChangeRocketEvent(false, '', message.msg.x_number ?? 1);
          });
        }
      } else if (message.msg.type == 'remove_from_room') {
        if (message.msg.room_id.toString() == Global.currentRoomId) {
          UserData user = UserData.fromJson(arguments['user']);

          if (user.id == Global.userId) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const PagesScreen(
                  pageNumber: 2,
                ),
              ),
              (route) => false,
            );
          } else {
            bloc.onGetAllTypeEvent('', widget.roomId);
          }
        }
      } else if (message.msg.type == 'vip user') {
        if (message.msg.room_id.toString() == Global.currentRoomId) {
          UserData user = UserData.fromJson(arguments['user']);

          bloc.onSendMessageEvent('message.msg.text' + message.msg.text!,
              widget.roomId, null, false);
          bloc.onEnterVipEvent(message.msg.text!, user.img!, true);
          bloc.onGetAllTypeEvent('', widget.roomId);

          Future.delayed(const Duration(seconds: 3)).then((value) {
            bloc.onEnterVipEvent(message.msg.text!, null, false);
          });
        }
      } else if (message.msg.type == 'user') {
        if (message.msg.room_id.toString() == Global.currentRoomId) {
          UserData user = UserData.fromJson(arguments['user']);
          if (user.vip_user != null) {
            bloc.onSendMessageEvent('message.msg.text' + message.msg.text!,
                widget.roomId, null, false);
            bloc.onEnterVipEvent(
                message.msg.text!, user.vip_user!.account_vip!.img!, true);
            bloc.onGetAllTypeEvent('', widget.roomId);
          } else {
            bloc.onSendMessageEvent('message.msg.text' + message.msg.text!,
                widget.roomId, null, false);
            bloc.onEnterVipEvent(message.msg.text!, null, true);
            bloc.onGetAllTypeEvent('', widget.roomId);
          }

          Future.delayed(const Duration(seconds: 5)).then((value) {
            bloc.onEnterVipEvent(message.msg.text!, null, false);
          });
        }
      }
    });

    super.initState();
  }

  _init() async {
    try {
      bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;

      if (hasPermission) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
        //io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = (await getExternalStorageDirectory())!;
        }

        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        _recorder =
            FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.AAC);

        await _recorder!.initialized;

        var current = await _recorder!.current(channel: 0);
        print(current);
        setState(() {
          _current = current;
          _currentStatus = current!.status!;
          print(_currentStatus);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder!.start();
      var recording = await _recorder!.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = Duration(milliseconds: 50);
      Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder!.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current!.status!;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _stop() async {
    var result = await _recorder!.stop();

    setState(() {
      _current = result;
      _currentStatus = _current!.status!;
    });
  }

  bool checkIsVideo(String? endUrl, String? localFile) {
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
    if (localFile != null) {
      if (localFile.contains('mp4') ||
          localFile.contains('mov') ||
          localFile.contains('wmv') ||
          localFile.contains('avi') ||
          localFile.contains('3gp') ||
          localFile.contains('flv')) {
        return true;
      }
    }

    return false;
  }

  bool checkIsImage(String? endUrl, String? localFile) {
    if (endUrl != null) {
      endUrl = endUrl.substring(endUrl.length - 4, endUrl.length);
      if (endUrl.contains('jpeg') ||
          endUrl.contains('jpg') ||
          endUrl.contains('png') ||
          endUrl.contains('gif')) {
        return true;
      }
    }
    if (localFile != null) {
      if (localFile.contains('jpeg') ||
          localFile.contains('jpg') ||
          localFile.contains('png') ||
          localFile.contains('gif')) {
        return true;
      }
    }

    return false;
  }

  bool checkIsMusic(String? endUrl, String? localFile) {
    if (endUrl != null) {
      endUrl = endUrl.substring(endUrl.length - 4, endUrl.length);
      if (endUrl.contains('mp3') ||
          endUrl.contains('wav') ||
          endUrl.contains('m4a') ||
          endUrl.contains('aac')) {
        return true;
      }
    }
    if (localFile != null) {
      if (localFile.contains('mp3') ||
          localFile.contains('wav') ||
          localFile.contains('m4a') ||
          localFile.contains('aac')) {
        return true;
      }
    }

    return false;
  }

  bool checkIsFile(String? endUrl, String? localFile) {
    if (endUrl != null) {
      endUrl = endUrl.substring(endUrl.length - 4, endUrl.length);
      if (endUrl.contains('pdf') ||
          endUrl.contains('ppt') ||
          endUrl.contains('docx')) {
        return true;
      }
    }
    if (localFile != null) {
      if (localFile.contains('pdf') ||
          localFile.contains('ppt') ||
          localFile.contains('docx')) {
        return true;
      }
    }

    return false;
  }

  bool checkIsMap(String? endUrl) {
    if (endUrl != null) {
      if (endUrl.contains('google.com/maps')) {
        return true;
      }
    }

    return false;
  }

  int countSecond = 0;

  void startTimer() {
    countSecond = 0;
    bloc.onChangeRecordTimerEvent(countSecond);
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        countSecond++;
        bloc.onChangeRecordTimerEvent(countSecond);
      },
    );
  }

  void closeTimer() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomConversationBloc, RoomConversationState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.smile.isNotEmpty) {
          textEditingController
            ..text += state.smile
            ..selection = TextSelection.fromPosition(
                TextPosition(offset: textEditingController.text.length));
        }
        if (state.isSuccessAllType!) {
          bloc.onGetAllTypeEvent('', widget.roomId);
        }
        if (state.sendGiftModel.message!.isNotEmpty) {
          Fluttertoast.showToast(
              msg: state.sendGiftModel.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return KeyboardAware(
          builder: (context, keyboardConfig) {
            return KeyboardVisibilityBuilder(
              builder: (context, bool isKeyboardVisible) {
                if (isKeyboardVisible) {
                  bloc.onShowEmojiEvent(false);
                }
                return SafeArea(
                  child: WillPopScope(
                    onWillPop: () async {
                      if (state.showEmoji) {
                        bloc.onShowEmojiEvent(false);

                        return false;
                      } else {
                        // Navigator.pop(context, update);
                        bloc.onWantToExitEvent(true);
                        return false;
                      }
                      return true;
                    },
                    child: GestureDetector(
                      onTap: () {
                        if (keyboardConfig.isKeyboardOpen) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        }
                      },
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              if (state
                                  .primaryBackground.background!.isNotEmpty)
                                Expanded(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        state.primaryBackground.background!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                )
                              else if (widget.background!.isNotEmpty)
                                Expanded(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.background!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                )
                              else
                                Expanded(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://www.room.tecknick.net/uploads/backgroundRoom/1653439556.jpg',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                )
                            ],
                          ),
                          Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              leading: const SizedBox(),
                              toolbarHeight: 80.h,
                              actions: [
                                SizedBox(
                                  width: 1.sw,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 12.h),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.w),
                                                    color:
                                                        const Color(0xff1F4B88),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      if (state.roomImage !=
                                                          null)
                                                        GestureDetector(
                                                          onTap: state.userPermission !=
                                                                      'user' ||
                                                                  Global.userId ==
                                                                      widget
                                                                          .ownerId
                                                              ? () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RoomSettings(
                                                                          bloc:
                                                                              bloc,
                                                                          roomId:
                                                                              widget.roomId,
                                                                          ownerId:
                                                                              widget.ownerId,
                                                                        ),
                                                                      ));
                                                                }
                                                              : null,
                                                          child: Container(
                                                            width: 50.h,
                                                            height: 50.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image:
                                                                  DecorationImage(
                                                                image: FileImage(
                                                                    state
                                                                        .roomImage!),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      else
                                                        GestureDetector(
                                                          onTap: state.userPermission !=
                                                                      'user' ||
                                                                  Global.userId ==
                                                                      widget
                                                                          .ownerId
                                                              ? () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RoomSettings(
                                                                          bloc:
                                                                              bloc,
                                                                          roomId:
                                                                              widget.roomId,
                                                                          ownerId:
                                                                              widget.ownerId,
                                                                        ),
                                                                      ));
                                                                }
                                                              : null,
                                                          child: SizedBox(
                                                            width: 50.h,
                                                            height: 50.h,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: widget
                                                                      .roomImage ??
                                                                  "https://www.room.tecknick.net/WI.jpeg",
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const Center(
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                        ),
                                                      SizedBox(
                                                        width: 6.w,
                                                      ),
                                                      Text(
                                                        widget.roomName!,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 17.sp,
                                                            color: ColorManager
                                                                .backgroundColor,
                                                            fontFamily:
                                                                'Roboto'),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        width: 7.w,
                                                      ),
                                                      if (widget.fav == '0')
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              widget.fav = '1';
                                                              update = true;
                                                              setState(() {});
                                                              bloc.onAddRemoveFavRoomEvent(
                                                                  widget
                                                                      .roomId);
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/icons/love.svg',
                                                              width: 35.w,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await showMenuBottomSheetRocket(
                                                            context,
                                                            bloc,
                                                            widget.roomId)
                                                        .then((value) {});
                                                  },
                                                  child: SvgPicture.asset(
                                                    'assets/icons/Rocket.svg',
                                                    width: 19.w,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 25.w,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    bloc.onWantToExitEvent(
                                                        true);
                                                  },
                                                  icon: SvgPicture.asset(
                                                    'assets/icons/menu.svg',
                                                    width: 4.5.w,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (state.allTypeModel.data != null)
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (state
                                                    .allTypeModel.data!.length >
                                                1) {
                                              showVipBottomSheet(
                                                  context,
                                                  bloc,
                                                  widget.roomId,
                                                  widget.ownerId!);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "لا يوجد اشخاص أخرين بالغرفة",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      ColorManager.primaryColor,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff1E3859)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.5.h,
                                                  horizontal: 12.5.h),
                                              child: Text(
                                                state.allTypeModel.data!.length
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: ColorManager
                                                        .backgroundColor,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        for (var item
                                            in state.allTypeModel.data!)
                                          if (item.vip_user != null)
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 40.h,
                                                    height: 40.h,
                                                    child: CachedNetworkImage(
                                                      imageUrl: item.img ??
                                                          "https://www.room.tecknick.net/WI.jpeg",
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          const Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                  if (item.vip_user != null)
                                                    SizedBox(
                                                      width: item.vip_user!
                                                                  .vip_id ==
                                                              '1'
                                                          ? 53.h
                                                          : 65.h,
                                                      height: item.vip_user!
                                                                  .vip_id ==
                                                              '1'
                                                          ? 53.h
                                                          : 65.h,
                                                      child: Image.asset(
                                                        item.vip_user!.vip_id ==
                                                                '1'
                                                            ? 'assets/images/solider_frame.png'
                                                            : item.vip_user!
                                                                        .vip_id ==
                                                                    '2'
                                                                ? 'assets/images/knight_frame.png'
                                                                : item.vip_user!
                                                                            .vip_id ==
                                                                        '3'
                                                                    ? 'assets/images/minister_frame.png'
                                                                    : 'assets/images/king_frame.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                //voice_call
                                if (!keyboardConfig.isKeyboardOpen &&
                                    !state.showEmoji)
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg: "coming soon".tr(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      ColorManager.primaryColor,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .backgroundColor)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.5.h,
                                                    horizontal: 20.5.h),
                                                child: SvgPicture.asset(
                                                  'assets/icons/plus.svg',
                                                  width: 16.w,
                                                  height: 16.w,
                                                  color: ColorManager
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg: "coming soon".tr(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      ColorManager.primaryColor,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .backgroundColor)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.5.h,
                                                    horizontal: 20.5.h),
                                                child: SvgPicture.asset(
                                                  'assets/icons/plus.svg',
                                                  width: 16.w,
                                                  height: 16.w,
                                                  color: ColorManager
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg: "coming soon".tr(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      ColorManager.primaryColor,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .backgroundColor)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.5.h,
                                                    horizontal: 20.5.h),
                                                child: SvgPicture.asset(
                                                  'assets/icons/plus.svg',
                                                  width: 16.w,
                                                  height: 16.w,
                                                  color: ColorManager
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg: "coming soon".tr(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      ColorManager.primaryColor,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .backgroundColor)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.5.h,
                                                    horizontal: 20.5.h),
                                                child: SvgPicture.asset(
                                                  'assets/icons/plus.svg',
                                                  width: 16.w,
                                                  height: 16.w,
                                                  color: ColorManager
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg: "coming soon".tr(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      ColorManager.primaryColor,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .backgroundColor)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.5.h,
                                                    horizontal: 20.5.h),
                                                child: SvgPicture.asset(
                                                  'assets/icons/plus.svg',
                                                  width: 16.w,
                                                  height: 16.w,
                                                  color: ColorManager
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg: "coming soon".tr(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      ColorManager.primaryColor,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .backgroundColor)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.5.h,
                                                    horizontal: 20.5.h),
                                                child: SvgPicture.asset(
                                                  'assets/icons/plus.svg',
                                                  width: 16.w,
                                                  height: 16.w,
                                                  color: ColorManager
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg: "coming soon".tr(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      ColorManager.primaryColor,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .backgroundColor)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.5.h,
                                                    horizontal: 20.5.h),
                                                child: SvgPicture.asset(
                                                  'assets/icons/plus.svg',
                                                  width: 16.w,
                                                  height: 16.w,
                                                  color: ColorManager
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg: "coming soon".tr(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      ColorManager.primaryColor,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .backgroundColor)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.5.h,
                                                    horizontal: 20.5.h),
                                                child: SvgPicture.asset(
                                                  'assets/icons/plus.svg',
                                                  width: 16.w,
                                                  height: 16.w,
                                                  color: ColorManager
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                //المحادثة
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: state.isLoading!
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ListView.separated(
                                            controller: scrollController,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(
                                                    parent:
                                                        BouncingScrollPhysics()),
                                            itemCount: state
                                                .conversationOldMessageModel
                                                .data!
                                                .length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              if (state
                                                      .conversationOldMessageModel
                                                      .data![index]
                                                      .user !=
                                                  null) {
                                                //me
                                                if (Global.userId ==
                                                    state
                                                        .conversationOldMessageModel
                                                        .data![index]
                                                        .user!
                                                        .id) {
                                                  if (checkIsVideo(
                                                      state
                                                                  .conversationOldMessageModel
                                                                  .data![index]
                                                                  .all_file !=
                                                              null
                                                          ? state
                                                              .conversationOldMessageModel
                                                              .data![index]
                                                              .all_file!
                                                              .substring(
                                                                  state
                                                                          .conversationOldMessageModel
                                                                          .data![
                                                                              index]
                                                                          .all_file!
                                                                          .length -
                                                                      4,
                                                                  state
                                                                      .conversationOldMessageModel
                                                                      .data![
                                                                          index]
                                                                      .all_file!
                                                                      .length)
                                                          : null,
                                                      state
                                                          .conversationOldMessageModel
                                                          .data![index]
                                                          .localFile)) {
                                                    return SizedBox(
                                                      height: 170.h,
                                                      child:
                                                          MessageVideoSideOne(
                                                        message: state
                                                            .conversationOldMessageModel
                                                            .data![index],
                                                      ),
                                                    );
                                                  } else if (checkIsImage(
                                                      state
                                                          .conversationOldMessageModel
                                                          .data![index]
                                                          .all_file,
                                                      state
                                                          .conversationOldMessageModel
                                                          .data![index]
                                                          .localFile)) {
                                                    return SizedBox(
                                                      height: 170.h,
                                                      child:
                                                          MessageImageSideOne(
                                                        message: state
                                                            .conversationOldMessageModel
                                                            .data![index],
                                                      ),
                                                    );
                                                  } else if (checkIsFile(
                                                      state
                                                          .conversationOldMessageModel
                                                          .data![index]
                                                          .all_file,
                                                      state
                                                          .conversationOldMessageModel
                                                          .data![index]
                                                          .localFile)) {
                                                    return MessageFileSideOne(
                                                      message: state
                                                          .conversationOldMessageModel
                                                          .data![index],
                                                    );
                                                  } else if (checkIsMusic(
                                                      state
                                                          .conversationOldMessageModel
                                                          .data![index]
                                                          .all_file,
                                                      state
                                                          .conversationOldMessageModel
                                                          .data![index]
                                                          .localFile)) {
                                                    return SizedBox(
                                                      height: 100.h,
                                                      child:
                                                          MessageMusicSideOne(
                                                        message: state
                                                            .conversationOldMessageModel
                                                            .data![index],
                                                      ),
                                                    );
                                                  } else if (checkIsMap(
                                                    state
                                                        .conversationOldMessageModel
                                                        .data![index]
                                                        .message,
                                                  )) {
                                                    return MessageMapSideOne(
                                                      message: state
                                                          .conversationOldMessageModel
                                                          .data![index],
                                                    );
                                                  }
                                                  return MessageChatSideOne(
                                                    message: state
                                                        .conversationOldMessageModel
                                                        .data![index],
                                                  );
                                                } else if (checkIsVideo(
                                                    state
                                                        .conversationOldMessageModel
                                                        .data![index]
                                                        .all_file,
                                                    state
                                                        .conversationOldMessageModel
                                                        .data![index]
                                                        .localFile)) {
                                                  return SizedBox(
                                                    height: 170.h,
                                                    child: MessageVideoSideTwo(
                                                      message: state
                                                          .conversationOldMessageModel
                                                          .data![index],
                                                    ),
                                                  );
                                                } else if (checkIsImage(
                                                    state
                                                        .conversationOldMessageModel
                                                        .data![index]
                                                        .all_file,
                                                    state
                                                        .conversationOldMessageModel
                                                        .data![index]
                                                        .localFile)) {
                                                  return SizedBox(
                                                    height: 170.h,
                                                    child: MessageImageSideTwo(
                                                      message: state
                                                          .conversationOldMessageModel
                                                          .data![index],
                                                    ),
                                                  );
                                                } else if (checkIsMusic(
                                                    state
                                                        .conversationOldMessageModel
                                                        .data![index]
                                                        .all_file,
                                                    state
                                                        .conversationOldMessageModel
                                                        .data![index]
                                                        .localFile)) {
                                                  return SizedBox(
                                                    height: 100.h,
                                                    child: MessageMusicSideTwo(
                                                      message: state
                                                          .conversationOldMessageModel
                                                          .data![index],
                                                    ),
                                                  );
                                                } else if (checkIsMap(
                                                  state
                                                      .conversationOldMessageModel
                                                      .data![index]
                                                      .message,
                                                )) {
                                                  return MessageMapSideTwo(
                                                    message: state
                                                        .conversationOldMessageModel
                                                        .data![index],
                                                  );
                                                }

                                                return MessageChatSideTwo(
                                                  message: state
                                                      .conversationOldMessageModel
                                                      .data![index],
                                                );
                                              }

                                              return const SizedBox();
                                            },
                                            separatorBuilder: (context, i) {
                                              return SizedBox(
                                                height: 12.h,
                                              );
                                            },
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),

                                //write message
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25.w),
                                              color: Colors.white10),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              //record_not_enable
                                              if (!state.isRecord)
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.w),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            if (FocusScope.of(
                                                                    context)
                                                                .hasFocus) {
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus!
                                                                  .unfocus();
                                                            }
                                                            Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            300))
                                                                .then((value) {
                                                              bloc.onShowEmojiEvent(
                                                                  true);
                                                              //installFromAssets();
                                                              singleScrollController.jumpTo(
                                                                  singleScrollController
                                                                      .position
                                                                      .maxScrollExtent);
                                                            });
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/smile.svg',
                                                            width: 19.w,
                                                            color: ColorManager
                                                                .backgroundColor,
                                                          ),
                                                        ),
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
                                                                      context)
                                                                  .unfocus();
                                                              bloc.onShowEmojiEvent(
                                                                  false);
                                                            },
                                                            onSubmitted: (st) {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              bloc.onShowEmojiEvent(
                                                                  false);
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
                                                                fontSize: 15.sp,
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
                                                        InkWell(
                                                          onTap: () {
                                                            showMediaBottomSheet(
                                                                bloc: bloc,
                                                                ctx: context,
                                                                roomId: widget
                                                                    .roomId);
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/media.svg',
                                                            width: 19.w,
                                                            color: ColorManager
                                                                .backgroundColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              else
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () async {
                                                            bloc.onStartRecord(
                                                                false);
                                                            closeTimer();
                                                            await _stop();
                                                            bloc.onSendMessageEvent(
                                                                '',
                                                                widget.roomId,
                                                                io.File(
                                                                    _current!
                                                                        .path!),
                                                                true);
                                                          },
                                                          icon:
                                                              SvgPicture.asset(
                                                            'assets/icons/send.svg',
                                                            color: ColorManager
                                                                .primaryColor,
                                                          )),
                                                      Expanded(
                                                        child: DragTarget(
                                                          builder: (context,
                                                              candidateData,
                                                              rejectedData) {
                                                            return Center(
                                                                child: Text(
                                                              'Slide to cancel    ${state.recordTime}',
                                                              style: TextStyle(
                                                                  color: ColorManager
                                                                      .backgroundColor,
                                                                  fontSize:
                                                                      15.sp),
                                                            ));
                                                          },
                                                          onWillAccept: (data) {
                                                            return true;
                                                          },
                                                          onAccept: (data) {
                                                            bloc.onStartRecord(
                                                                false);
                                                            closeTimer();
                                                            _stop();
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (isKeyboardVisible ||
                                                  state.showEmoji)
                                                IconButton(
                                                    onPressed: () {
                                                      if (textEditingController
                                                          .text.isNotEmpty) {
                                                        bloc.onSendMessageEvent(
                                                            textEditingController
                                                                .text,
                                                            widget.roomId,
                                                            null,
                                                            true);
                                                      }

                                                      if (FocusScope.of(context)
                                                          .hasFocus) {
                                                        textEditingController
                                                            .clear();
                                                      }
                                                      bloc.onStartRecord(false);
                                                     Future.delayed(const Duration(milliseconds: 1500)).then((value) {
                                                       scrollController
                                                           .animateTo(scrollController.position.maxScrollExtent,
                                                         curve: Curves.linearToEaseOut,
                                                         duration: const Duration(seconds: 1)
                                                       );

                                                     });
                                                    },
                                                    icon: Icon(
                                                      Icons.send,
                                                      color: ColorManager
                                                          .backgroundColor,
                                                      size: 22.w,
                                                    ))
                                              else
                                                GestureDetector(
                                                  onTap: () {
                                                    bloc.onStartRecord(true);
                                                    _start();
                                                    startTimer();
                                                  },
                                                  child: Draggable(
                                                    ignoringFeedbackSemantics:
                                                        false,
                                                    data: 5,
                                                    axis: Axis.horizontal,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: state.isRecord
                                                              ? ColorManager
                                                                  .primaryColor
                                                              : Colors
                                                                  .transparent,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: SvgPicture.asset(
                                                          'assets/icons/micro.svg',
                                                          width: 17.w,
                                                          color: ColorManager
                                                              .backgroundColor,
                                                        ),
                                                      ),
                                                    ),
                                                    feedback: state.isRecord
                                                        ? Container(
                                                            decoration: const BoxDecoration(
                                                                color: ColorManager
                                                                    .primaryColor,
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: SvgPicture.asset(
                                                                  'assets/icons/micro.svg',
                                                                  width: 17.w,
                                                                  color: ColorManager
                                                                      .backgroundColor),
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                  ),
                                                ),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          sendGiftBottomSheet(
                                              context, bloc, widget.roomId);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  ColorManager.primaryColor,
                                                  ColorManager
                                                      .primaryColorLight,
                                                ]),
                                            borderRadius:
                                                BorderRadius.circular(7.w),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/icons/gift_three.svg',
                                              width: 17.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Color(0xff32415D),
                                                  Color(0xff32415D),
                                                ]),
                                            borderRadius:
                                                BorderRadius.circular(7.w),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/icons/heart.svg',
                                              width: 17.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),

                                SmileAndSticker(
                                  roomId: widget.roomId,
                                  bloc: bloc,
                                ),
                              ],
                            ),
                          ),
                          if (down)
                            Positioned(
                              bottom: 80.h,
                              left: 5.w,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    scrollController.jumpTo(
                                      scrollController.position.maxScrollExtent,
                                    );
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.keyboard_double_arrow_down,
                                        size: 22.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (state.wantToExit)
                            GestureDetector(
                              onTap: () {
                                bloc.onWantToExitEvent(false);
                              },
                              child: Material(
                                color: Colors.transparent.withOpacity(0.8),
                                child: SizedBox(
                                  height: 1.sh,
                                  width: 1.sw,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 0.1.sh,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              bloc.onWantToExitEvent(false);
                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              ColorManager
                                                                  .primaryColor,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(15.0.w),
                                                    child: Icon(
                                                      Icons.check,
                                                      color: ColorManager
                                                          .backgroundColor,
                                                      size: 36.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                SizedBox(
                                                  width: 0.4.sw,
                                                  child: Text(
                                                    'Stay in Background',
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: ColorManager
                                                            .backgroundColor),
                                                    textAlign: TextAlign.center,
                                                  ).tr(),
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              bloc.onDeleteUserEvent(
                                                  0, widget.roomId);
                                              bloc.onWantToExitEvent(false);
                                              Global.pusher!.unsubscribe(
                                                  "chat.${widget.roomId}");
                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              ColorManager
                                                                  .primaryColor,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(15.0.w),
                                                    child: Icon(
                                                      Icons.exit_to_app,
                                                      color: ColorManager
                                                          .backgroundColor,
                                                      size: 36.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                SizedBox(
                                                  width: 0.4.sw,
                                                  child: Text(
                                                    'Exit',
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: ColorManager
                                                            .backgroundColor),
                                                    textAlign: TextAlign.center,
                                                  ).tr(),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if (state.showRocket)
                            GestureDetector(
                              onTap: () {
                                bloc.onWantToExitEvent(false);
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 0.2.sh,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: Container(
                                            width: 0.4.sw,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    ColorManager.primaryColor,
                                                    ColorManager
                                                        .primaryColorLight,
                                                  ]),
                                              borderRadius: BorderRadius.only(
                                                topLeft: context.locale ==
                                                        const Locale('ar', 'AR')
                                                    ? Radius.circular(0.w)
                                                    : Radius.circular(20.w),
                                                bottomLeft: context.locale ==
                                                        const Locale('ar', 'AR')
                                                    ? Radius.circular(0.w)
                                                    : Radius.circular(20.w),
                                                topRight: context.locale ==
                                                        const Locale('ar', 'AR')
                                                    ? Radius.circular(20.w)
                                                    : Radius.circular(0.w),
                                                bottomRight: context.locale ==
                                                        const Locale('ar', 'AR')
                                                    ? Radius.circular(20.w)
                                                    : Radius.circular(0.w),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Color(
                                                                0xffFE9F61),
                                                            shape: BoxShape
                                                                .circle),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          16.0.w),
                                                      child: Image.asset(
                                                        "assets/icons/rocket.png",
                                                        width: 16.w,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          state
                                                              .showRocketUserName,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 15.sp,
                                                              color: ColorManager
                                                                  .backgroundColor,
                                                              fontFamily:
                                                                  'Roboto'),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Text(
                                                          "x " +
                                                              state.xNumber
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 15.sp,
                                                            color: ColorManager
                                                                .backgroundColor,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
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
                                  ),
                                ],
                              ),
                            ),
                          if (state.showGift)
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 0.2.sh,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: Container(
                                            width: 0.4.sw,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    ColorManager.primaryColor,
                                                    ColorManager
                                                        .primaryColorLight,
                                                  ]),
                                              borderRadius: BorderRadius.only(
                                                topLeft: context.locale ==
                                                        const Locale('ar', 'AR')
                                                    ? Radius.circular(0.w)
                                                    : Radius.circular(20.w),
                                                bottomLeft: context.locale ==
                                                        const Locale('ar', 'AR')
                                                    ? Radius.circular(0.w)
                                                    : Radius.circular(20.w),
                                                topRight: context.locale ==
                                                        const Locale('ar', 'AR')
                                                    ? Radius.circular(20.w)
                                                    : Radius.circular(0.w),
                                                bottomRight: context.locale ==
                                                        const Locale('ar', 'AR')
                                                    ? Radius.circular(20.w)
                                                    : Radius.circular(0.w),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                  vertical: 8.h),
                                              child: Row(
                                                children: [
                                                  CachedNetworkImage(
                                                    width: 42.w,
                                                    height: 42.w,
                                                    imageUrl: state.imgGift,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          state.txtGift,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 15.sp,
                                                              color: ColorManager
                                                                  .backgroundColor,
                                                              fontFamily:
                                                                  'Roboto'),
                                                          textAlign:
                                                              TextAlign.center,
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
                                  ),
                                ],
                              ),
                            ),
                          if (state.showGiftCenter)
                            Material(
                              color: Colors.transparent,
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: state.imgGift,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          if (state.enable)
                            Material(
                              color: Colors.transparent,
                              child: state.img != null
                                  ? Center(
                                      child: CachedNetworkImage(
                                        imageUrl: state.img!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
