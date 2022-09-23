import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? preferences;
  static const String KEY_IS_First_Time = 'key_is_first_time';
  static const String KEY_UserToken = 'key_UserToken';
  static const String KEY_UserId = 'key_UserId';
  static const String KEY_UserName = 'key_UserName';
  static const String KEY_UserImage = 'key_UserImage';
  static const String KEY_Lan = 'KEY_Lan';
  static const String KEY_DarkMode = 'KEY_DarkMode';
  static const String KEY_Diamond = 'KEY_Diamond';
  static const String KEY_Coins = 'KEY_Coins';
  static const String KEY_Vip_Id = 'KEY_Vip_Id';
  static const String KEY_Vip_Date = 'KEY_Vip_Date';



  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void saveIsFirstTime(bool isFirstTime) async {
    preferences!.setBool(KEY_IS_First_Time, isFirstTime);

  }
  static bool? getIsFirstTime() {
    bool? first = preferences!.getBool(KEY_IS_First_Time);
    if(first==null)
    {
      return true;
    }
    else {
      return first;
    }
  }

  static void saveUserToken(String userToken) async {
    preferences!.setString(KEY_UserToken, userToken);
  }

  static String? getUserToken() {
    String? userToken = preferences!.getString(KEY_UserToken);
     if(userToken==null)
       {
         return '';
       }
     else {
       return userToken;
     }
  }

  static void saveUserName(String userName) async {
    preferences!.setString(KEY_UserName, userName);
  }

  static String? getUserName() {
    String? userName = preferences!.getString(KEY_UserName);
    if(userName==null)
    {
      return '';
    }
    else {
      return userName;
    }
  }

  static void saveVipDate(DateTime dateTime) async {
    String timeStamp = dateTime.toIso8601String();
    preferences!.setString(KEY_Vip_Date, timeStamp);
  }

  static DateTime? getVipDate() {

    DateTime? dateTime =DateTime.parse(preferences!.getString(KEY_Vip_Date)??'2020-04-17T11:59:46.405') ;
      return dateTime;
  }

  static void saveUserDiamond(String diamond) async {
    preferences!.setString(KEY_Diamond, diamond);
  }

  static String? getUserDiamond() {
    String? diamond = preferences!.getString(KEY_Diamond);
    if(diamond==null)
    {
      return '0';
    }
    else {
      return diamond;
    }
  }

  static void saveUserCoins(String diamond) async {
    preferences!.setString(KEY_Coins, diamond);
  }

  static String? getUserCoins() {
    String? coins = preferences!.getString(KEY_Coins);
    if(coins==null)
    {
      return '0';
    }
    else {
      return coins;
    }
  }

  static void saveUserId(int userId) async {
    preferences!.setInt(KEY_UserId, userId);
  }

  static int? getUserId() {
    int? userId = preferences!.getInt(KEY_UserId);
    if(userId==null)
    {
      return 0;
    }
    else {
      return userId;
    }
  }

  static void saveUserVipId(int userId) async {
    preferences!.setInt(KEY_Vip_Id, userId);
  }

  static int? getUserVipId() {
    int? userVipId = preferences!.getInt(KEY_Vip_Id);
    if(userVipId==null)
    {
      return 0;
    }
    else {
      return userVipId;
    }
  }

  static void saveUserImage(String image) async {
    preferences!.setString(KEY_UserImage, image);
  }

  static String? getUserImage() {
    String? userImage = preferences!.getString(KEY_UserImage);
    if(userImage==null)
    {
      return 'https://www.room.tecknick.net/WI.jpeg';
    }
    else {
      return userImage;
    }
  }

  static void saveLan(String lan) async {
    preferences!.setString(KEY_Lan, lan);
  }

  static String? getLan() {
    String? lan = preferences!.getString(KEY_Lan);
    if(lan==null)
    {
      return 'ar';
    }
    else {
      return lan;
    }
  }

  static void saveDarkMode(bool darkMode) async {
    preferences!.setBool(KEY_DarkMode, darkMode);
  }

  static bool? getDarkMode() {
    bool? darkMode = preferences!.getBool(KEY_DarkMode);
    if(darkMode==null)
    {
      return false;
    }
    else {
      return darkMode;
    }
  }

}
