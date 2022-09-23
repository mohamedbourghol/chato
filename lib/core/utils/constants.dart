import 'package:easy_localization/easy_localization.dart';

class Endpoints {
  static const baseURL = 'https://www.room.tecknick.net/api/';
  static const register = 'auth/register';
  static const registerAmazingAccount = 'auth/register_account_arabic';
  static const login = 'auth/login';
  static const createDevice = 'create_device';
  static const friendShipRequests = 'friendship-requests';
  static const searchFriend = 'search-friend';
  static const logout = 'auth/logout';
  static const profileDetails = 'auth/user';
  static const friendsDetails =  'details-friend';
  static const viewerUser =  'viewer-user';
  static const countFriend = 'count-friend';
  static const changeRequestsFriend = 'change-requests-friend';
  static const addFriend = 'add-friend';
  static const updateUserInfo = 'auth/update/user/info';
  static const getAllFriend = 'get-all-friend';
  static const forgetPassword = 'auth/forgetPassword';
  static const changePassword = 'auth/change_password';
  static const createRoom = 'room/create-room';
  static const getUserAllRoom = 'room/get-user-all-room';
  static const getFavRoom = 'room/get-favorite-room';
  static const getTrendRoom = 'room/get-all-trend';
  static const getAllRoom = 'room/get-all-room';
  static const getAllUserVipRoom= 'room/all-user-vip-room';
  static const getConversationOldMessage = 'room/get-conversation-old-message';
  static const getConversationPrivet = 'room/get-conversation-privet';
  static const getAllBlockUser = 'get-all-block-user';
  static const unblockUser = 'unblock-user';
  static const blockUser = 'block-user';
  static const allTypeRoom = 'room/all-type-room';
  static const sendMessage = 'room/send-message';
  static const addUserRoom = 'room/add-user-room';
  static const restPassword = 'auth/rest_password';
  static const sendCoins = 'send_coins';
  static const addDeleteFavoriteRoom = 'room/add-delete-favorite-room';
  static const changePermeationUserRoom = 'room/change-permeation-user-room';
  static const getBackgroundImage = '/room/get-background-room';
  static const updateRoom = '/room/update-room';
  static const getGiftRoom = '/room/git-gift-room';
  static const sendGiftRoom = '/room/send-gift-room';
  static const deleteUserRoom = '/room/delete-user-room';
  static const userDeleteRoom = '/room/user-delete-room';
  static const blockUserRoom = '/room/block-user-room';
  static const addTrend = '/room/add-room-trend';
  static const updateCoins = '/update_coins';
  static const vipAccountsTransactions = '/vipaccounts_transactions';
  static const getCountries = '/countries';
  static const addStatus = '/room/add-status';
  static const getStatus = '/room/get-status-friend';
  static const seenStatus = '/room/seen-status';
  static const deleteStatus = '/room/delete-status';
  static const getRoomBlocked = '/room/get-block-user-room';
  static const getConversationId = '/room/get-conversation';
  static const unblockUserRoom = '/room/unblock-user-room';
  static const roomPermeation = '/room/user-room-permeation';

}

class AgoraKeys{
  String get appId {
    return const String.fromEnvironment('APP_ID',
        defaultValue: 'ef11cd8f9ce5442c9516060a0f754d65');
  }


}

class Er {
  static String error = tr("Something went wrong");
  static String networkError = tr("Check your internet connection");
}
