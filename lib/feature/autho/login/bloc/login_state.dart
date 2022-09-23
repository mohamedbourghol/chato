



import 'package:built_value/built_value.dart';
import 'package:chato/feature/autho/login/model/login_data_model.dart';
import 'package:chato/feature/autho/login/model/login_model.dart';



part 'login_state.g.dart';


abstract class LoginState implements Built<LoginState,
    LoginStateBuilder> {


  bool? get isSuccess;
  bool? get isLoading;
  String? get error;
  LoginModel? get loginModel;


  LoginState._();

  factory LoginState([void Function(LoginStateBuilder) updates]) = _$LoginState;

  factory LoginState.initial() {
    return LoginState((b) => b
      ..isLoading = false
      ..isSuccess = false
      ..error=''
      ..loginModel=LoginModel(
          data: LoginDataModel(
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

    );
  }
}


