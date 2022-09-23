import 'dart:async';

import 'package:chato/Globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pusher_client/pusher_client.dart';
import '../../core/utils/color_manager.dart';
import '../../injection.dart';
import 'ChatPage/bloc/chat_bloc.dart';
import 'ChatPage/chat_page.dart';
import 'HomePage/bloc/home_bloc.dart';
import 'HomePage/bloc/home_state.dart';
import 'HomePage/home_page.dart';
import 'ProfilePage/bloc/prof_bloc.dart';
import 'ProfilePage/profile_page.dart';
import 'RoomPage/bloc/room_bloc.dart';
import 'RoomPage/room_page.dart';
import 'StorePage/store_page.dart';


class PagesScreen extends StatefulWidget  {
  final int pageNumber;
  const PagesScreen({Key? key,required this.pageNumber}) : super(key: key);

  @override
  _PagesScreenState createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> with WidgetsBindingObserver{

  Channel? channelChat;
   HomeBloc bloc=sl<HomeBloc>();
   ProfBloc profBloc=sl<ProfBloc>();
   RoomBloc roomBloc=sl<RoomBloc>();
  ChatBloc chatBloc=sl<ChatBloc>();
   late PageController pageController;
   int sec=240;


  late Timer timer;
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(sec>0) {

        sec--;
      }
      else{
        sec=240;
        profBloc.onUpdateUserInfoEvent(
            online: "1"
        );

      }
    });
  }

   @override
  void initState() {
     startTimer();
     profBloc.onUpdateUserInfoEvent(
         online: "1"
     );
     WidgetsBinding.instance!.addObserver(this);
     pageController=PageController(initialPage: widget.pageNumber);
     Global.pusher!.connect();

     Global.pusher!.onConnectionStateChange((state) {
       print("previousState: ${state!.previousState}"
           ", currentState: ${state.currentState}");
     });

     Global.pusher!.onConnectionError((error) {
       print("error: ${error!.message}");
     });

     bloc.onChangePageEvent(widget.pageNumber);
     profBloc.onGetProfileDetailsEvent();
     super.initState();
  }


  @override
  void dispose() {
    WidgetsBinding.instance!.addObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    switch (state) {
      case AppLifecycleState.resumed:
        print("AppLifecycleState.resumed");
        profBloc.onUpdateUserInfoEvent(
          online: "1"
        );
        profBloc.onGetProfileDetailsEvent();
        break;
      case AppLifecycleState.paused:
        profBloc.onUpdateUserInfoEvent(
            online: "0"
        );
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer(
      bloc:bloc ,
      listener: (context, state) {

      },
      builder: (BuildContext context, HomeState state) {
        return GestureDetector(
          onTap: (){
            profBloc.onUpdateUserInfoEvent(
                online: "0"
            );
          },
          child: Scaffold(
            body: SafeArea(child:
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children:  [
                  SizedBox(
                    height: 1.sh,
                    width: 1.sw,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (index){
                        bloc.onChangePageEvent(index);
                      },
                      children:  [
                        HomeScreen(bloc: bloc),
                        ChatScreen(bloc: chatBloc),
                        RoomScreen(bloc:roomBloc ),
                        StoreScreen(),
                        ProfileScreen(bloc: profBloc,) ,

                      ],
                    ),
                  ),
                ],
              ),
            )),
            bottomNavigationBar: Theme(
              child: SizedBox(
                height: 65.h,
                child: BottomNavigationBar(


                  currentIndex: state.selectedPage, //New
                  onTap: (int index) {
                    pageController.jumpToPage(index);
                    bloc.onChangePageEvent(index);
                  },
                  items:  <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        width: 20.w,

                        color: state.selectedPage==0?ColorManager.primaryColor:Theme.of(context).hintColor,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon:  SvgPicture.asset('assets/icons/chat.svg',
                        width: 20.w,
                        color: state.selectedPage==1?ColorManager.primaryColor:Theme.of(context).hintColor,
                      ),
                      label: '',

                    ),
                    BottomNavigationBarItem(
                      icon:  SvgPicture.asset('assets/icons/group_chat.svg',
                        width: 20.w,
                        color: state.selectedPage==2?ColorManager.primaryColor:Theme.of(context).hintColor,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon:  SvgPicture.asset(
                        'assets/icons/store.svg',
                        width: 20.w,
                        color: state.selectedPage==3?ColorManager.primaryColor:Theme.of(context).hintColor,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon:  SvgPicture.asset(
                        'assets/icons/profile.svg',
                        width: 20.w,
                        color:state.selectedPage==4?ColorManager.primaryColor:Theme.of(context).hintColor,
                      ),
                      label: '',
                    ),
                  ],
                ),
              ),
              data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                  canvasColor: Theme.of(context).scaffoldBackgroundColor,
                  // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                  ),
            ),
          ),
        );
      },

    );
  }
}
