import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/feature/Pages/HomePage/bloc/home_bloc.dart';
import 'package:chato/feature/Pages/HomePage/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../User/user.dart';

class SearchFriendsScreen extends StatefulWidget {
  final HomeBloc bloc;
  const SearchFriendsScreen({Key? key,required this.bloc}) : super(key: key);

  @override
  _SearchFriendsScreenState createState() => _SearchFriendsScreenState();
}

class _SearchFriendsScreenState extends State<SearchFriendsScreen> {
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
                      'search for a person',
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
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()
            ),
            child: Column(
              children: [
                TextField(
                  onChanged: (value){
                  //  searchData(st = value.trim().toLowerCase());
                    // Method For Searching
                  },
                  onSubmitted: (va){
                    widget.bloc.onGetSearchFriendEvent(va);
                  },
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 15.sp
                  ),
                  decoration:  InputDecoration(
                     hintText: tr("User Name"),
                   hintStyle:  TextStyle(
                       color: Theme.of(context).hintColor,
                       fontSize: 15.sp
                   ),
                    prefixIcon: Icon(Icons.search,
                      color: Theme.of(context).hintColor,
                      size: 22.w,

                    ),
                    border: const OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                SizedBox(
                  height: 0.85.sh,
                  child:state.searchFriendModel.data!
                      .isNotEmpty?
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),

                      itemBuilder: (context, index) {
                        return  Padding(
                            padding:  EdgeInsets.symmetric(
                                horizontal: 12.w
                            ),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>  UserScreen(
                                      id: state.searchFriendModel.data![index].id!,
                                    ),));
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50.h,
                                    height: 50.h,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      state.searchFriendModel.data![index].img ??
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
                                      const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(width: 6.w,),
                                  Expanded(
                                    child: Text(state.searchFriendModel.data![index].name!,
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



                                ],
                              ),
                            )
                        );
                      }, separatorBuilder: (context, index) {
                    return  Divider(
                      thickness:1,
                      color: Theme.of(context).hintColor,
                    );
                  }, itemCount: state.searchFriendModel.data!.length):
                      state.isLoadingSearch!?
                      const Center(
                        child: CircularProgressIndicator(),
                      ):
                   Center(
                     child: Text('There are no matching results.',
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

        );
      },

    );
  }
}
