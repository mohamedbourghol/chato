import 'package:built_value/built_value.dart';
import 'package:chato/feature/User/model/add_friend_data.dart';
import 'package:chato/feature/User/model/add_friend_model.dart';
import 'package:chato/feature/User/model/data.dart';
import 'package:chato/feature/User/model/user_data.dart';
import 'package:chato/feature/User/model/user_model.dart';

part 'user_state.g.dart';

abstract class UserState implements Built<UserState, UserStateBuilder> {
  bool? get isSuccess;

  bool?get addFriend;

  String? get age;

  bool? get isLoading;

  String? get error;

  UserModel? get userModel;

  AddFriendModel? get addFriendModel;

  UserState._();

  factory UserState([void Function(UserStateBuilder) updates]) = _$UserState;

  factory UserState.initial() {
    return UserState((b) => b
      ..isLoading = false
      ..isSuccess = false
      ..addFriend = false
      ..error = ''
      ..age='25'
      ..userModel = UserModel(
        data: Data(
          user: UserData(
            id: 0,
            gender: '',
            img: '',
            name: '',
            birth_date: '',
            email: '',
            token: '',
            personal_status: '',
            block: [],
            friend: [],
            giftTransactionRecived: 0,
            giftTransactionSend: 0,
            viewers: '',

          ),
        ),
        message: '',
        error_code: 0,
        status: false,
      )
      ..addFriendModel = AddFriendModel(
          data: AddFriendData(friend_id: 0, id: 0, user_id: 0, status: ''),
          error_code:0 ,
          message: '',
          status: false));
  }
}
