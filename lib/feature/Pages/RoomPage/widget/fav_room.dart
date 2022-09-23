import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../RoomConversation/room_conversation.dart';
import '../bloc/room_bloc.dart';
import '../bloc/room_state.dart';

class FavRoomPage extends StatefulWidget {
  final RoomBloc bloc;

  const FavRoomPage({Key? key, required this.bloc}) : super(key: key);

  @override
  _FavRoomPageState createState() => _FavRoomPageState();
}

class _FavRoomPageState extends State<FavRoomPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.bloc.onGetFavRoomEvent();
    super.initState();
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<RoomBloc, RoomState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return state.isLoadingGetFavRoom!
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.favRoomModel.data.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      widget.bloc.onGetFavRoomEvent();
                    },
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      itemCount: state.favRoomModel.data.length,
                      itemBuilder: (context, index) {
                        if (state.search.isEmpty ||
                            state.favRoomModel.data[index].name!
                                .contains(state.search)) {
                          return Dismissible(
                            key: Key(generateRandomString(25)),
                            background: Container(
                              color: Colors.red,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 22.w,
                                    color: Colors.grey.shade50,
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (dis) {
                              widget.bloc.onRemoveFavEvent(
                                  state.favRoomModel.data[index].id!);
                            },
                            child: GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RoomConversationScreen(
                                            roomId: state
                                                .favRoomModel.data[index].id!,
                                            background: state
                                                        .favRoomModel
                                                        .data[index]
                                                        .background !=
                                                    null
                                                ? state.favRoomModel.data[index]
                                                    .background!.background
                                                : '',
                                            fav: state.favRoomModel.data[index]
                                                .favorite_room_count!,
                                            ownerId: state.favRoomModel
                                                .data[index].user!.id!,
                                            roomName: state
                                                .favRoomModel.data[index].name!,
                                            roomImage: state
                                                .favRoomModel.data[index].img,
                                          )),
                                ).then((value) {
                                  widget.bloc.onGetFavRoomEvent();
                                });
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: SizedBox(
                                      width: 50.w,
                                      height: 50.w,
                                      child: CachedNetworkImage(
                                        imageUrl: state
                                                .favRoomModel.data[index].img ??
                                            "https://www.room.tecknick.net/WI.jpeg",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                state.favRoomModel.data[index]
                                                    .name!,
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontFamily: 'DIN',
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context)
                                                        .disabledColor),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Column(
                                    children: [
                                      if (index < 5)
                                        SvgPicture.asset(
                                            'assets/icons/awesome-crown.svg'),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffFCAF65)),
                                            child: Padding(
                                              padding: EdgeInsets.all(14.0.w),
                                              child: Text(
                                                (index + 1).toString(),
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontFamily: 'DIN',
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorManager
                                                        .backgroundColor),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                      separatorBuilder: (context, i) {
                        return SizedBox(
                          height: 5.h,
                        );
                      },
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      widget.bloc.onGetFavRoomEvent();
                    },
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 0.8.sh,
                          child: Center(
                            child: Text(
                              'No Fav chats'.tr(),
                              style: TextStyle(
                                  fontSize: 19.sp,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
      },
      listener: (context, state) {},
    );
  }

  @override
  bool get wantKeepAlive => true;
}
