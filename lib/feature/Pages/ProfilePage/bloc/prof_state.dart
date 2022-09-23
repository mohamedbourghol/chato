import 'dart:io';
import 'package:built_value/built_value.dart';
import 'package:chato/feature/Pages/ProfilePage/model/countFriend/count_friend_model.dart';
import 'package:chato/feature/Pages/ProfilePage/model/profile/profile_data.dart';
import '../model/blockedUser/blocked_user_model.dart';
import '../model/country/country_model.dart';
import '../model/profile/profile_model.dart';
import '../model/resetPassword/reset_model.dart';
import '../model/sendCoins/send_coins_model.dart';


part 'prof_state.g.dart';

abstract class ProfState implements Built<ProfState, ProfStateBuilder> {
  bool? get isSuccess;

  bool? get isLoading;

  bool? get isSuccessLogout;

  bool? get isLoadingLogout;

  bool? get isSuccessSendCoins;

  bool? get isLoadingSendCoins;

  bool? get isSuccessChange;

  bool? get isLoadingChange;

  String? get error;

  File? get img;

  ProfileModel? get profileModel;

  CountFriendModel? get countFriendModel;

  BlockedUserModel? get blockedUserModel;

  ResetModel get resetModel;

  SendCoinsModel get sendCoinsModel;

  CountryModel get countryModel;

  ProfState._();

  factory ProfState([void Function(ProfStateBuilder) updates]) = _$ProfState;

  factory ProfState.initial() {
    return ProfState((b) => b
      ..isLoading = false
      ..isSuccess = false
      ..isLoadingLogout = false
      ..isSuccessLogout = false
      ..isSuccessChange=false
      ..isLoadingChange=false
      ..isSuccessSendCoins=false
      ..isLoadingSendCoins=false
      ..error = ""
      ..countryModel=CountryModel(message: '',
         status: false,data:[] ,error_code: 0
      )
      ..img=null
      ..blockedUserModel=BlockedUserModel(
        data: [],
        error_code: 0,
        message: '',
        status:false
      )
      ..profileModel = ProfileModel(
        data: ProfileData(
            id: 0,
            gender: '',
            img: '',
            name: '',
            birth_date: '',
            email: '',
            token: '',
            country: null,
            status: '',
             type: '',
          personal_status: '',
          diamond: '0',
          coins: '0'

        ),
        message: '',
        error_code: 0,
        status: false,
      )
      ..countFriendModel = CountFriendModel(
              data: 0, error_code: 0,
              message: '', status: false)
        ..resetModel=ResetModel(message: '',
          error_code: 0,
          status: false


        )
        ..sendCoinsModel=SendCoinsModel(message: '',
            status: false, error_code: 0)

    );
  }
}
