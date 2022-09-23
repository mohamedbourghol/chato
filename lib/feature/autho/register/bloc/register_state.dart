



import 'package:built_value/built_value.dart';
import 'package:chato/feature/autho/register/model/register_data_model.dart';
import 'package:chato/feature/autho/register/model/register_model.dart';



part 'register_state.g.dart';


abstract class RegisterState implements Built<RegisterState,
    RegisterStateBuilder> {


  bool? get isSuccess;
  bool? get isLoading;
  String? get error;
 int get selectedPage;
 RegisterModel? get registerModel;


  RegisterState._();

  factory RegisterState([void Function(RegisterStateBuilder) updates]) = _$RegisterState;

  factory RegisterState.initial() {
    return RegisterState((b) => b
      ..isLoading = false
      ..isSuccess = false
        ..selectedPage=0
        ..error=''
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

    );
  }
}


