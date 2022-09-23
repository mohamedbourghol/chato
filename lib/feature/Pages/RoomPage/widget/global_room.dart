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

class GlobalRoomPage extends StatefulWidget {
  final RoomBloc bloc;

  const GlobalRoomPage({Key? key, required this.bloc}) : super(key: key);

  @override
  _GlobalRoomPageState createState() => _GlobalRoomPageState();
}

class _GlobalRoomPageState extends State<GlobalRoomPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.bloc.onGetUserRoomEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<RoomBloc, RoomState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return state.isLoadingGetUserRoom!
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.userRoomModel.data.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      widget.bloc.onGetUserRoomEvent();
                    },
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      itemCount: state.userRoomModel.data.length,
                      itemBuilder: (context, index) {
                        if (state.search.isEmpty ||
                            state.userRoomModel.data[index].name!
                                .contains(state.search)) {
                          return GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RoomConversationScreen(
                                          roomId: state
                                              .userRoomModel.data[index].id!,
                                          background: state.userRoomModel
                                                      .data[index].background !=
                                                  null
                                              ? state.userRoomModel.data[index]
                                                  .background!.background
                                              : '',
                                          fav: state.userRoomModel.data[index]
                                              .favorite_room_count!,
                                          ownerId: state.userRoomModel
                                              .data[index].user!.id!,
                                          roomName: state
                                              .userRoomModel.data[index].name!,
                                          roomImage: state
                                              .userRoomModel.data[index].img,
                                        )),
                              ).then((value) {
                                widget.bloc.onGetAllRoomEvent();
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
                                              .userRoomModel.data[index].img ??
                                          "https://www.room.tecknick.net/WI.jpeg",
                                      imageBuilder: (context, imageProvider) =>
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
                                              state.userRoomModel.data[index]
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
                      widget.bloc.onGetUserRoomEvent();
                    },
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 0.9.sh,
                          child: Center(
                            child: Text(
                              'No active chats'.tr(),
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
