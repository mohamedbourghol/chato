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

class TrendRoomPage extends StatefulWidget {
  final RoomBloc bloc;

  const TrendRoomPage({Key? key, required this.bloc}) : super(key: key);

  @override
  _TrendRoomPageState createState() => _TrendRoomPageState();
}

class _TrendRoomPageState extends State<TrendRoomPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.bloc.onGetTrendRoomEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<RoomBloc, RoomState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return state.isLoadingGetTrendRoom!
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.trendRoomModel.data.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      widget.bloc.onGetTrendRoomEvent();
                    },
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: state.trendRoomModel.data.length,
                      itemBuilder: (context, index) {
                        if (state.search.isEmpty ||
                            state.trendRoomModel.data[index].name!
                                .contains(state.search)) {
                          return GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RoomConversationScreen(
                                          roomId: state
                                              .trendRoomModel.data[index].id!,
                                          background: state.trendRoomModel
                                                      .data[index].background !=
                                                  null
                                              ? state.trendRoomModel.data[index]
                                                  .background!.background
                                              : '',
                                          fav: state.trendRoomModel.data[index]
                                              .favorite_room_count!,
                                          ownerId: state.trendRoomModel
                                              .data[index].user!.id!,
                                          roomName: state
                                              .trendRoomModel.data[index].name!,
                                          roomImage: state
                                              .trendRoomModel.data[index].img,
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
                                        imageUrl: state.trendRoomModel
                                                .data[index].img ??
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
                                      )),
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
                                              state.trendRoomModel.data[index]
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
                          return const SizedBox();
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
                      widget.bloc.onGetTrendRoomEvent();
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
