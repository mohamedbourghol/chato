import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chato/Globals.dart';
import 'package:chato/Preference.dart';
import 'package:chato/feature/Pages/ProfilePage/api/count_friend_remote.dart';
import 'package:chato/feature/Pages/ProfilePage/api/profile_remote.dart';
import 'package:chato/feature/Pages/ProfilePage/model/blockedUser/blocked_user_model.dart';
import 'package:chato/feature/Pages/ProfilePage/model/countFriend/count_friend_model.dart';
import 'package:chato/feature/Pages/ProfilePage/model/profile/profile_data.dart';
import 'package:chato/feature/Pages/ProfilePage/model/resetPassword/reset_model.dart';
import '../api/blocked_user_remote.dart';
import '../api/country_remote.dart';
import '../api/delete_status_remote.dart';
import '../api/logout_remote.dart';
import '../api/reset_remote.dart';
import '../api/send_coins_remote.dart';
import '../api/unblocked_user_remote.dart';
import '../api/update_user_info_remote.dart';
import '../model/country/country_data_model.dart';
import '../model/country/country_model.dart';
import '../model/profile/profile_model.dart';
import '../model/sendCoins/send_coins_model.dart';
import 'prof_event.dart';
import 'prof_state.dart';

class ProfBloc extends Bloc<ProfEvent, ProfState> {
  UpdateUserInfoDataSource updateUserInfoDataSource;
  LogoutRemoteDataSource logoutRemoteDataSource;
  ProfileDetailsRemoteDataSource profileDetailsRemoteDataSource;
 CountFriendDetailsRemoteDataSource countFriendDetailsRemoteDataSource;
  BlockedUserRemoteDataSource blockedUserRemoteDataSource;
  UnBlockedUserRemoteDataSource unBlockedUserRemoteDataSource;
  ResetPasswordRemoteDataSource resetPasswordRemoteDataSource;
  SendCoinsRemoteDataSource sendCoinsRemoteDataSource;
  CountryRemoteDataSource countryRemoteDataSource;
  DeleteStatusRemoteDataSource deleteStatusRemoteDataSource;
  ProfBloc(
      {required this.profileDetailsRemoteDataSource,
      required this.logoutRemoteDataSource,
      required this.countFriendDetailsRemoteDataSource,
        required this.updateUserInfoDataSource,
        required this.blockedUserRemoteDataSource,
        required this.unBlockedUserRemoteDataSource,
        required this.resetPasswordRemoteDataSource,
        required this.sendCoinsRemoteDataSource,
        required this.countryRemoteDataSource,
        required this.deleteStatusRemoteDataSource
      })
      : super(ProfState.initial()) {
    on<LogoutEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isSuccessLogout = false
        ..isLoadingLogout = true));
      final result = await logoutRemoteDataSource.logout();


      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccessLogout = false
          ..isLoadingLogout = false));
      }, (r) async {
        print('r');
        if (r.message != null) {
          Preferences.saveUserToken('');
          Global.userToken = '';
        }
        emit(state.rebuild((b) => b
          ..isSuccessLogout = true
          ..isLoadingLogout = false));
        emit(state.rebuild((b) => b
          ..isSuccessLogout = false
          ..isLoadingLogout = false));
      });
    });

    on<GetProfileDetailsEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isSuccess = false
        ..isLoading = true
        ..profileModel = ProfileModel(
            data: ProfileData(id: 0,
              email: '', birth_date: '',
              img: '', gender: '', name: '',
              token: '',
              status: '',
              country: null,
              type: '',
              personal_status: '',
              coins: '0',
              diamond:'0'
            ),
            message: '',
            error_code: 0,
            status: false)));
      final result = await profileDetailsRemoteDataSource.profileDetails(
      );


      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess = false
          ..isLoading = false
          ..error = l));
      }, (r) async {
        print('r');
        Global.userCoins=r.data!.coins;
        Global.userDiamond=r.data!.diamond;
        Global.userImage=r.data!.img;
        Preferences.saveUserImage(r.data!.img!);
        emit(state.rebuild((b) => b
          ..isSuccess = true
          ..isLoading = false
          ..profileModel = r));

      });

    });


    //GetCountFriendEvent
    on<GetCountFriendEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isSuccess = false
        ..isLoading = true
        ..countFriendModel =CountFriendModel(data: 0, error_code: 0, message: '', status: false) ));

      final result = await countFriendDetailsRemoteDataSource.countFriendDetails();

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess = false
          ..isLoading = false
          ..error = l));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..isSuccess = true
          ..isLoading = false
          ..countFriendModel = r));
      });

    });

    //GetCountFriendEvent
    on<DeleteStatusEvent>((event, emit) async {


      final result = await deleteStatusRemoteDataSource.
      deleteStatus(statusId: event.statusId);
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..error = l));
      }, (r) async {
        print('r');
        emit(state.rebuild((b) => b
          ..error =''));
      });
    });

    on<UpdateUserInfoEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isSuccess = false
        ..isLoading = true
       ..img=event.image
      ));

      final result = await
      updateUserInfoDataSource.updateUser(
        img: event.image,
        name: event.name,
        country_id:event.country!=null? event.country!.id!:null,
        gender: event.gender,
        birth_date: event.birthDate,
        personalStatus: event.personalStatus,
        online: event.online
      );

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess = false
          ..isLoading = false
          ..error = l));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
          ..isSuccess = true
          ..profileModel!.data!.gender=event.gender??
              state.profileModel!.data!.gender
          ..profileModel!.data!.country=event.country??
              state.profileModel!.data!.country
          ..profileModel!.data!.birth_date=event.birthDate??
              state.profileModel!.data!.birth_date
          ..profileModel!.data!.personal_status=event.personalStatus??
              event.personalStatus
          ..isLoading = false
        ));
        emit(state.rebuild((b) => b

          ..isSuccess = false

        ));
      });

    });


    on<GetBlockedUserEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isLoading=true
          ..isSuccess=false
          ..error=''
          ..blockedUserModel=BlockedUserModel(
              data: [],
              error_code: 0,
              message: '',
              status: false)
      ));

      final result = await
      blockedUserRemoteDataSource.getBlockedUser(

      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isLoading=false
          ..isSuccess=false
          ..error = l));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
          ..isLoading=false
          ..isSuccess=true
            ..blockedUserModel=r
        ));
      });
    });


    on<GetCountriesUserEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isLoading=true
        ..isSuccess=false
        ..error=''
        ..countryModel=CountryModel(
            data: [],
            error_code: 0,
            message: '',
            status: false)
      ));

      final result = await
      countryRemoteDataSource.getCountries(

      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isLoading=false
          ..isSuccess=false
          ..error = l));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
          ..isLoading=false
          ..isSuccess=true
          ..countryModel=r
        ));
      });
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..error=''
          ..isLoadingChange=true
          ..isSuccessChange=false
          ..resetModel=ResetModel(message: '',
              status: false, error_code: 0)
      ));

      final result = await
      resetPasswordRemoteDataSource.resetPassword(
        oldPassword: event.oldPassword,
        password: event.password,
        confirmPassword: event.confirmPassword
      );


      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..error=l
          ..isLoadingChange=false
          ..isSuccessChange=false
        ));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..isLoadingChange=false
          ..isSuccessChange=true
          ..error=''
            ..resetModel=r
        ));
      });
    });

    on<UnBlockedUserEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..error=''
      ));

      final result = await
      unBlockedUserRemoteDataSource.unBlockedUser(
          blockedId:event.blockedId
      );

      print("result");
      print(result);
      print("result");

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..error = l
        ));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
        ));
      });
    });

    on<SendCoinsEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..error=''
          ..isLoadingSendCoins=true
        ..isSuccessSendCoins=false
          ..sendCoinsModel=SendCoinsModel(
            status: false,
            error_code: 0,
            message: ''
          )
      ));

      final result = await
      sendCoinsRemoteDataSource.sendCoins(
          userReceivedId: event.userReceivedId,
          numberOfCoinsOrDiamond: event.numberOfCoinsOrDiamond,
          type: event.type);

      print("result");
      print(result);
      print("result");

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..error = l
            ..isLoadingSendCoins=false
            ..isSuccessSendCoins=false
        ));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
          ..isLoadingSendCoins=false
          ..isSuccessSendCoins=true
            ..sendCoinsModel=r
        ));
      });
    });

    on<ResetParamEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..error=''
          ..resetModel=ResetModel(
              message: '',
              status: false,
              error_code: 0)
      ));});




  }

  void onLogoutEvent() {
    add(LogoutEvent());
  }

  void onUpdateUserInfoEvent({
    File? image, String? gender,
    String? name,
    String? birthDate,
    String? personalStatus,
    String?  online,
    CountryDataModel? country
   }) {
    add(UpdateUserInfoEvent(image: image,
      gender: gender,
      name: name,
      country: country,
      birthDate: birthDate,
      personalStatus: personalStatus,
      online: online

    ));
  }

  void onGetProfileDetailsEvent() {
    add(GetProfileDetailsEvent());
  }

  void onGetCountFriendEvent(){
    add(GetCountFriendEvent());

  }

  void onGetBlockedUserEvent(){
    add(GetBlockedUserEvent());
  }

  void onUnBlockedUserEvent(int blockedId){
    add(UnBlockedUserEvent(blockedId: blockedId));
  }

  void onChangePasswordEvent(String oldPassword,
      String password,String confirmPassword,){
    add(ChangePasswordEvent(
       oldPassword: oldPassword,
      password: password,
      confirmPassword: confirmPassword
    ));
  }

  void onResetParamEvent(){
    add(ResetParamEvent());
  }

  void onGetCountriesUserEvent(){
    add(GetCountriesUserEvent());
  }



  void onSendCoinsEvent(  String type,
      String numberOfCoinsOrDiamond,
      String userReceivedId,
      ){
    add(SendCoinsEvent(type:type,
    numberOfCoinsOrDiamond: numberOfCoinsOrDiamond,
      userReceivedId: userReceivedId

    ));
  }

  void onDeleteStatusEvent(int statusId){

    add(DeleteStatusEvent(statusId:statusId));

  }
}
