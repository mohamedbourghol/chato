import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/feature/Pages/HomePage/bloc/home_bloc.dart';
import 'package:chato/feature/Pages/HomePage/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FriendshipRequests extends StatefulWidget {
  final HomeBloc bloc;
  const FriendshipRequests({Key? key,required this.bloc}) : super(key: key);

  @override
  _FriendshipRequestsState createState() => _FriendshipRequestsState();
}

class _FriendshipRequestsState extends State<FriendshipRequests> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc,HomeState>(
      bloc: widget.bloc,
      listener: (context, state) {
      },
      builder: (context,state){
       return Scaffold(
          appBar: AppBar(
            elevation: 1,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                color:Theme.of(context).primaryColorDark ,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            actions: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Friendship Requests',
                      style: TextStyle(
                          fontSize: 17.sp,

                          fontWeight: FontWeight.w600,
                          color: ColorManager.primaryColor
                      ) ,
                      textAlign: TextAlign.center,
                    ).tr(),
                  ],),
              )
            ],
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: RefreshIndicator(
            onRefresh: ()async{
              widget.bloc.onGetFriendshipRequestsEvent();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()
              ),
              child: Column(
                children: [

                  SizedBox(
                    height: 20.h,
                  ),

                  SizedBox(
                    height: 0.85.sh,
                    child:state.friendshipRequestsModel.data!
                        .isNotEmpty?
                    ListView.separated(
                      physics: const BouncingScrollPhysics(),

                        itemBuilder: (context, index) {
                          return  Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 12.w
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50.h,
                                    height: 50.h,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      state.friendshipRequestsModel.data![index].img ??
                                          "https://www.room.tecknick.net/WI.jpeg",
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,

                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                      const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(width: 6.w,),
                                  Expanded(
                                    child: Text(state.friendshipRequestsModel.data![index].name!,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColorDark
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    widget.bloc.onChangeRequestsFriend(id: state.friendshipRequestsModel.
                                    data![index].id!, status:'approve' );
                                    state.friendshipRequestsModel.data!.removeAt(index);
                                    setState(() {

                                    });
                                  }, icon: SvgPicture.asset('assets/icons/check.svg')),
                                  IconButton(onPressed: (){
                                    widget.bloc.onChangeRequestsFriend(id: state.friendshipRequestsModel.
                                    data![index].id!, status:'reject' );
                                    state.friendshipRequestsModel.data!.removeAt(index);
                                    setState(() {

                                    });
                                  },
                                      icon: SvgPicture.asset('assets/icons/trash.svg')),

                                ],
                              )
                          );
                        }, separatorBuilder: (context, index) {
                      return  Divider(
                        thickness:1,
                        color: Theme.of(context).hintColor,
                      );
                    }, itemCount: state.friendshipRequestsModel.data!.length):
                        state.isLoading!?
                        const Center(
                          child: CircularProgressIndicator(),
                        ):
                     Center(
                       child: Text('There are no new friend requests',
                         style: TextStyle(
                           fontSize: 17.sp,
                           color: Theme.of(context).primaryColorDark,
                         ),

                       ).tr(),
                     ),

                  ),

                  SizedBox(
                    height: 15.h,
                  ),




                ],
              ),
            ),
          ),

        );
      },

    );
  }
}
