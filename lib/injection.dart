import 'package:chato/feature/Pages/ProfilePage/api/count_friend_remote.dart';
import 'package:chato/feature/Pages/ProfilePage/api/logout_remote.dart';
import 'package:chato/feature/Pages/ProfilePage/api/profile_remote.dart';
import 'package:chato/feature/Pages/StorePage/bloc/store_bloc.dart';
import 'package:chato/feature/RoomConversation/api/get_user_permeation_remote.dart';
import 'package:chato/feature/User/api/user_remote.dart';
import 'package:chato/feature/User/bloc/user_bloc.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'core/utils/constants.dart';
import 'feature/BuyFeaturedUser/api/vip_accounts_transactions_remote.dart';
import 'feature/Conversation/api/block_user_remote.dart';
import 'feature/Conversation/api/get_conversation_id_remote.dart';
import 'feature/Conversation/api/get_conversation_old_message_remote.dart';
import 'feature/Conversation/api/private_send_message_remote.dart';
import 'feature/Pages/ChatPage/api/get_conversation_private_remote.dart';
import 'feature/Conversation/bloc/conversation_bloc.dart';
import 'feature/Pages/ChatPage/bloc/chat_bloc.dart';
import 'feature/Pages/HomePage/api/add_status_remote.dart';
import 'feature/Pages/HomePage/api/all_friend_remote.dart';
import 'feature/Pages/HomePage/api/change-requests-friend_remote.dart';
import 'feature/Pages/HomePage/api/friendship_requests_remote.dart';
import 'feature/Pages/HomePage/api/get_status_remote.dart';
import 'feature/Pages/HomePage/api/search-friend_remote.dart';
import 'feature/Pages/HomePage/api/seen_status_remote.dart';
import 'feature/Pages/HomePage/bloc/home_bloc.dart';
import 'feature/Pages/ProfilePage/api/blocked_user_remote.dart';
import 'feature/Pages/ProfilePage/api/country_remote.dart';
import 'feature/Pages/ProfilePage/api/delete_status_remote.dart';
import 'feature/Pages/ProfilePage/api/reset_remote.dart';
import 'feature/Pages/ProfilePage/api/send_coins_remote.dart';
import 'feature/Pages/ProfilePage/api/unblocked_user_remote.dart';
import 'feature/Pages/ProfilePage/api/update_user_info_remote.dart';
import 'feature/Pages/ProfilePage/bloc/prof_bloc.dart';
import 'feature/Pages/RoomPage/api/create_room_remote.dart';
import 'feature/Pages/RoomPage/api/get_all_room_remote.dart';
import 'feature/Pages/RoomPage/api/get_fav_room_remote.dart';
import 'feature/Pages/RoomPage/api/get_trend_room_remote.dart';
import 'feature/Pages/RoomPage/api/get_user_all_room_remote.dart';
import 'feature/Pages/RoomPage/bloc/room_bloc.dart';
import 'feature/Pages/StorePage/api/update_coins_remote.dart';
import 'feature/RoomConversation/api/add_remove_fav_remote.dart';
import 'feature/RoomConversation/api/add_trend_room_remote.dart';
import 'feature/RoomConversation/api/add_user_remote.dart';
import 'feature/RoomConversation/api/block_user_room_remote.dart';
import 'feature/RoomConversation/api/change-permeation-user-room_remote.dart';
import 'feature/RoomConversation/api/delete_user_room_remote.dart';
import 'feature/RoomConversation/api/get_all_type_message_remote.dart';
import 'feature/RoomConversation/api/get_background_image_remote.dart';
import 'feature/RoomConversation/api/get_blocked_remote.dart';
import 'feature/RoomConversation/api/get_conversation_old_message_remote.dart';
import 'feature/RoomConversation/api/get_gift_remote.dart';
import 'feature/RoomConversation/api/send_gift_room_remote.dart';
import 'feature/RoomConversation/api/send_message_remote.dart';
import 'feature/RoomConversation/api/unblock_user_room_remote.dart';
import 'feature/RoomConversation/api/update_room_remote.dart';
import 'feature/RoomConversation/bloc/room_conversation_bloc.dart';
import 'feature/User/api/add_friend_remote.dart';
import 'feature/autho/forgot/api/change_password_remote.dart';
import 'feature/autho/forgot/api/forget-password_remote.dart';
import 'feature/autho/forgot/bloc/forget_bloc.dart';
import 'feature/autho/login/api/login_remote.dart';
import 'feature/autho/login/bloc/login_bloc.dart';
import 'feature/autho/register/api/register_amazing_account_remote.dart';
import 'feature/autho/register/api/register_remote.dart';
import 'feature/autho/register/bloc/register_bloc.dart';




final sl = GetIt.instance;

///
/// The [init] function is responsible for adding the instances to the graph
///
Future<void> init() async {
  //!External

  /// Adding the [Dio] instance to the graph to be later used by the local data sources
  sl.registerLazySingleton(
    () {
      final dio = Dio(
        BaseOptions(
          connectTimeout: 12000,
          receiveTimeout: 12000,
          sendTimeout: 12000,
          baseUrl: Endpoints.baseURL,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          responseType: ResponseType.plain,
        ),
      );
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          responseHeader: true,
          requestHeader: true,
          request: true,
          error: true
        ),
      );

      return dio;
    },
  );

  sl.registerLazySingleton(() => DataConnectionChecker());

  sl.registerLazySingleton<ProfanityFilter>(
          () => ProfanityFilter()
  );




  //datasource
  sl.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(dio: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(dio: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<LogoutRemoteDataSource>(
    () => LogoutRemoteDataSourceImpl(dio: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<ProfileDetailsRemoteDataSource>(
    () => ProfileDetailsRemoteDataSourceImpl(dio: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<CountFriendDetailsRemoteDataSource>(
    () => CountFriendDetailsRemoteDataSourceImpl(dio: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<UserDetailsRemoteDataSource>(
    () => UserDetailsRemoteDataSourceImpl(dio: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<FriendshipRequestsRemoteDataSource>(
        () => FriendshipRequestsRemoteDataSourceImpl(dio: sl(),
            networkInfo: sl()),
  );
  sl.registerLazySingleton<AddFriendRemoteDataSource>(
        () => AddFriendRemoteDataSourceImpl(dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<ChangeRequestsFriendRemoteDataSource>(
        () => ChangeRequestsFriendRemoteDataSourceImpl(
            dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<SearchFriendRemoteDataSource>(
        () => SearchFriendRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<UpdateUserInfoDataSource>(
        () => UpdateUserInfoDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );

  sl.registerLazySingleton<AllFriendRemoteDataSource>(
        () => AllFriendRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<ForgetPasswordRemoteDataSource>(
        () => ForgetPasswordRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<ChangePasswordRemoteDataSource>(
        () => ChangePasswordRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<CreateRoomRemoteDataSource>(
        () => CreateRoomRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<GetUserRoomRemoteDataSource>(
        () => GetUserRoomRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<GetFavRoomRemoteDataSource>(
        () => GetFavRoomRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );


  sl.registerLazySingleton<GetTrendRoomRemoteDataSource>(
        () => GetTrendRoomRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<GetAllRoomRemoteDataSource>(
        () => GetAllRoomRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );

  sl.registerLazySingleton<ConversationOldMessageDataSource>(
        () => ConversationOldMessageDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<BlockedUserRemoteDataSource>(
        () => BlockedUserRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<UnBlockedUserRemoteDataSource>(
        () => UnBlockedUserRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<AllTypeDataSource>(
        () => AllTypeDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<SendMessageDataSource>(
        () => SendMessageDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );
  sl.registerLazySingleton<AddUserDataSource>(
        () => AddUserDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );

  sl.registerLazySingleton<ResetPasswordRemoteDataSource>(
        () => ResetPasswordRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()),
  );

  sl.registerLazySingleton<SendCoinsRemoteDataSource>(
        () => SendCoinsRemoteDataSourceImpl(
           dio: sl(),
           networkInfo: sl()
        ),
  );
  sl.registerLazySingleton<RegisterAmazingAccountRemoteDataSource>(
        () => RegisterAmazingAccountRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<AddRemoveFavDataSource>(
        () => AddRemoveFavDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<GetConversationPrivateDataSource>(
        () => GetConversationPrivateDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<PrivateOldMessageDataSource>(
        () => PrivateOldMessageDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );
  sl.registerLazySingleton<BlockUserRemoteDataSource>(
        () => BlockUserRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );


  sl.registerLazySingleton<ChangePermeationUserRoomDataSource>(
        () => ChangePermeationUserRoomDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );
  sl.registerLazySingleton<PrivateSendMessageDataSource>(
        () => PrivateSendMessageDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<GetBackgroundImageSource>(
        () => GetBackgroundImageSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<UpdateRoomDataSource>(
        () => UpdateRoomDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<GetGiftSource>(
        () => GetGiftSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );
  sl.registerLazySingleton<SendGiftRoomDataSource>(
        () => SendGiftRoomDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<DeleteUserRoomDataSource>(
        () => DeleteUserRoomDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<BlockUserRoomDataSource>(
        () => BlockUserRoomDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<AddTrendDataSource>(
        () => AddTrendDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<UpdateCoinsRemoteDataSource>(
        () =>   UpdateCoinsRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<VipAccountsTransactionsRemoteDataSource>(
        () =>   VipAccountsTransactionsRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<CountryRemoteDataSource>(
        () =>   CountryRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<AddStatusRemoteDataSource>(
        () =>   AddStatusRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );


  sl.registerLazySingleton<GetStatusRemoteDataSource>(
        () =>   GetStatusRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );
  sl.registerLazySingleton<SeenStatusRemoteDataSource>(
        () =>   SeenStatusRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );
  sl.registerLazySingleton<DeleteStatusRemoteDataSource>(
        () =>   DeleteStatusRemoteDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<BlockedDataSource>(
        () =>   BlockedDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<GetConversationIdDataSource>(
        () =>   GetConversationIdDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );
  sl.registerLazySingleton<UnBlockUserRoomDataSource>(
        () =>   UnBlockUserRoomDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<UserPermeationDataSource>(
        () =>   UserPermeationDataSourceImpl(
        dio: sl(),
        networkInfo: sl()
    ),
  );








  // Bloc
  sl.registerLazySingleton(() => HomeBloc(
    friendshipRequestsRemoteDataSource: sl(),
    changeRequestsFriendRemoteDataSource: sl(),
    searchFriendRemoteDataSource: sl(),
    allFriendRemoteDataSource:  sl(),
    addStatusRemoteDataSource: sl(),
    getStatusRemoteDataSource: sl(),
    seenStatusRemoteDataSource: sl()
  ));

  sl.registerLazySingleton(() => ConversationBloc(
     privateOldMessageDataSource: sl(),
    sendMessageDataSource: sl(),
    blockUserRemoteDataSource: sl(),
    getConversationIdDataSource: sl()

  ));

  sl.registerLazySingleton(() => ChatBloc(
    getConversationPrivateDataSource: sl()
  ));


  sl.registerLazySingleton(() => StoreBloc(
    updateCoinsRemoteDataSource: sl(),
    vipAccountsTransactionsRemoteDataSource: sl()
  ));


  sl.registerLazySingleton(() => RoomConversationBloc(
    sendGiftRoomDataSource: sl(),
    conversationOldMessageDataSource: sl(),
     allTypeDataSource:sl(),
    sendMessageDataSource: sl(),
    addUserDataSource: sl(),
    addRemoveFavDataSource: sl(),
    changePermeationUserRoomDataSource: sl(),
    getBackgroundImageSource: sl(),
    updateRoomDataSource: sl(),
    getGiftSource: sl(),
    deleteUserRoomDataSource: sl(),
    blockUserRoomDataSource: sl(),
    addTrendDataSource: sl(),
    blockedDataSource: sl(),
    unBlockUserRoomDataSource: sl(),
    userPermeationDataSource: sl()
  ));

  sl.registerLazySingleton(() => RegisterBloc(
      registerRemoteDataSource: sl(),
    registerAmazingAccountRemoteDataSource: sl()
  ));

  sl.registerLazySingleton(() => LoginBloc(
      loginRemoteDataSource: sl()));

  sl.registerLazySingleton(() => ProfBloc(
      logoutRemoteDataSource: sl(),
      profileDetailsRemoteDataSource: sl(),
      countFriendDetailsRemoteDataSource: sl(),
      updateUserInfoDataSource: sl(),
      blockedUserRemoteDataSource: sl(),
    unBlockedUserRemoteDataSource: sl(),
    resetPasswordRemoteDataSource: sl(),
      sendCoinsRemoteDataSource: sl(),
    countryRemoteDataSource: sl() ,
    deleteStatusRemoteDataSource: sl()
  ));


  sl.registerLazySingleton(() => UserBloc(
      userRemoteDataSource: sl(),
      addFriendRemoteDataSource: sl()
  ));

  sl.registerLazySingleton(() => ForgetBloc(
      forgetPasswordRemoteDataSource: sl(),
      changePasswordRemoteDataSource: sl()
  ));

  sl.registerLazySingleton(() => RoomBloc(
      createRoomRemoteDataSource: sl(),
      getUserRoomRemoteDataSource: sl(),
      getFavRoomRemoteDataSource: sl(),
      getTrendRoomRemoteDataSource: sl(),
      getAllRoomRemoteDataSource: sl(),
       addRemoveFavDataSource: sl(),
  ));




}
