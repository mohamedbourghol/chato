import 'package:bloc/bloc.dart';
import 'package:chato/feature/User/api/add_friend_remote.dart';
import 'package:chato/feature/User/api/user_remote.dart';
import 'package:chato/feature/User/bloc/user_event.dart';
import 'package:chato/feature/User/bloc/user_state.dart';
import 'package:chato/feature/User/model/add_friend_data.dart';
import 'package:chato/feature/User/model/add_friend_model.dart';
import 'package:chato/feature/User/model/data.dart';
import 'package:chato/feature/User/model/user_data.dart';
import 'package:chato/feature/User/model/user_model.dart';
import 'package:easy_localization/easy_localization.dart';


class UserBloc extends Bloc<UserEvents, UserState> {
  UserDetailsRemoteDataSource userRemoteDataSource;
  AddFriendRemoteDataSource addFriendRemoteDataSource;

  UserBloc({
    required this.userRemoteDataSource,
    required this.addFriendRemoteDataSource
  }) : super(UserState.initial()) {

    on<ChangeStatusEvent>((event, emit) =>
        emit(state.rebuild((b) => b
          ..addFriend=false
          ..addFriendModel=AddFriendModel(error_code: 0,
              data: null,message: '',status: false
          )
        )
        ));
    on<GetUserDetailsEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isSuccess = false
        ..isLoading = true
        ..addFriendModel=AddFriendModel(error_code: 0,
            data: null,message: '',
             status: false
        )
        ..userModel = UserModel(
            data:Data (
              user: UserData(
                id: 0,
                email: '',
                birth_date: '',
                img: '',
                gender: '',
                name: '',
                token: '',
              ),
            ),
            message: '',
            error_code: 0,
            status: false)));
      final result = await userRemoteDataSource.
      userDetails(id: event.id);


      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess = false
          ..isLoading = false
          ..error = l));
      }, (r) async {
        print('r');
           DateTime now=DateTime.now();
           DateFormat format =DateFormat('yyyy/mm/dd',"en");
           String ff=format.format(now);
        String age='25';
           if(r.data!.user!.birth_date!=null)
             {
               int? ag=  int.tryParse(ff.substring(0,4))!-
                   int.tryParse(r.data!.user!.birth_date!.substring(0,4))!;


               age=ag.toString();

             }
        emit(state.rebuild((b) => b
          ..isSuccess = true
          ..isLoading = false
          ..age=age
          ..userModel = r

        ));
      });
    });

    on<AddFriendEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isSuccess = false
        ..isLoading = true
        ..addFriend = true
        ..addFriendModel = AddFriendModel(
            data: AddFriendData(
              id: 0, friend_id: 0, user_id: 0, status: '',
            ),
            message: '',
            error_code: 0,
            status: false)));
      final result = await addFriendRemoteDataSource.addFriend(
        id: event.id
      );
      print("result");
      print(result);
      print("result");

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess = false
          ..isLoading = false
          ..addFriend = false
          ..error = l));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..isSuccess = true
          ..isLoading = false
          ..addFriend = true
          ..addFriendModel = r));
      });
    });
  }

  void onGetDetailsUserEvent(int id) {
    add(GetUserDetailsEvent(id: id));
  }

  void onAddFriendEvent(int id) {
    add(AddFriendEvent(id: id));
  }
  void onChangeStatusEvent(bool status) {
    add(ChangeStatusEvent(status: status));
  }

}
