
import 'package:bloc/bloc.dart';
import 'package:chato/Preference.dart';
import '../../../../Globals.dart';
import '../api/register_amazing_account_remote.dart';
import '../api/register_remote.dart';
import '../model/register_data_model.dart';
import '../model/register_model.dart';
import 'register_event.dart';
import 'register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterRemoteDataSource registerRemoteDataSource;
  RegisterAmazingAccountRemoteDataSource registerAmazingAccountRemoteDataSource;
  RegisterBloc({
    required this.registerRemoteDataSource,
    required this.registerAmazingAccountRemoteDataSource
    }) : super(RegisterState.initial())
    {
    on<RegisterAccountEvent>((event, emit) async
    {
      emit(state.rebuild((b) => b
        ..isSuccess=false
        ..error=''
        ..isLoading=true
        ..registerModel=RegisterModel(
            data: RegisterDataModel(
                email: '',
                name: '',
                id: 0,
                token: '',
                img: '',
              coins: '0',
              diamond: '0'
            ),
            message: '',
            error_code: 0,
            status: false
        )
      )
      );
      final result = await registerRemoteDataSource.register(
          name: event.name,
        email: event.email,
        password: event.password,
        password_confirmation: event.passwordConfirm
      );
      print("result");
      print(result);
      print("result");

      return  result.fold((l) async {
         print('l');
         emit(state.rebuild((b) => b
           ..isSuccess=false
           ..isLoading=false
           ..error=l
         )
         );
      }, (r) async {
         print('r');
         if(r.data!=null)
           {
             if(r.data!.token!=null)
               {
                 Global.userToken=r.data!.token!;
                 Global.userId=r.data!.id!;
                 Global.userName=r.data!.name!;
                 Global.userImage=r.data!.img??'';
                 Global.userDiamond=r.data!.diamond??'0';
                 Global.userCoins=r.data!.coins??'0';
                 Preferences.saveUserDiamond(r.data!.diamond??'0');
                 Preferences.saveUserCoins(r.data!.coins??'0');
                 Preferences.saveUserToken(r.data!.token!);
                 Preferences.saveUserId(r.data!.id!);
                 Preferences.saveUserImage(r.data!.img??'');
                 Preferences.saveUserName(r.data!.name!);
               }
           }
         emit(state.rebuild((b) => b
           ..isSuccess=true
           ..isLoading=false
           ..registerModel=r
         )
         );



      });

    }
        );

    on<RegisterAmazingAccountEvent>((event, emit) async
    {
      emit(state.rebuild((b) => b
        ..isSuccess=false
        ..isLoading=true
        ..registerModel=RegisterModel(
            data: RegisterDataModel(
                email: '',
                name: '',
                id: 0,
                token: '',
                img: '',
              diamond: '0',
              coins: '0'
            ),
            message: '',
            error_code: 0,
            status: false
        )
      )
      );
      final result = await registerAmazingAccountRemoteDataSource.
      registerAmazingAccount(
          name: event.name,
          email: event.email,
          password: event.password,
          password_confirmation: event.passwordConfirm,
        cost: event.cost
      );

      return  result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess=false
          ..isLoading=false
          ..error=l
        )
        );
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..isSuccess=true
          ..isLoading=false
          ..registerModel=r
        )
        );



      });

    }
    );


  }

  void onRegisterAccountEvent({
       required String name,
       required String email,
       required String password,
       required String passwordConfirm,
      }) {

    add(RegisterAccountEvent(
      name: name,
      password: password,
      email: email,
      passwordConfirm: passwordConfirm

    ));
  }
  void onRegisterAmazingAccountEvent({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
    required int cost,
  }) {

    add(RegisterAmazingAccountEvent(
        name: name,
        password: password,
        email: email,
        passwordConfirm: passwordConfirm,
      cost: cost

    ));
  }

  void onChangePageEvent(int pageNumber) {
    add(ChangePageEvent(pageNumber));
  }



}