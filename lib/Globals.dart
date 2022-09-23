

import 'package:flutter/cupertino.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:pusher_client/pusher_client.dart';

import 'feature/Pages/HomePage/model/getStatus/get_status_data_model.dart';
import 'feature/Pages/HomePage/model/getStatus/status_user_model.dart';

class Global{
 static GlobalKey<NavigatorState> navigatorKey=GlobalKey<NavigatorState>();
 static String? userToken='';
 static int? userId=0;
 static List<StatusUserModel>?  myStatus=[];
 static int? vipId=0;
 static DateTime? endVip;
 static String? currentRoomId='0';
 static String? userImage='';
 static String? userName='';
 static String? userCoins='0';
 static String? userDiamond='0';
 static String? lan='ar';
 static double? tax=15;
 static bool darkMode=false;
 static String? pusherAppKey='d42e318047d0f8a6c641';
 static String? pusherAppCluster='mt1';
 static String? host='https://room.tecknick.net/';
 static PusherClient? pusher=PusherClient(
  Global.pusherAppKey!,
  PusherOptions(
   host:  Global.host!,
   encrypted: false,
   cluster: Global.pusherAppCluster!,
  ),
  autoConnect: true,
  enableLogging: true,
 );


}

