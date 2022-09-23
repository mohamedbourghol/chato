



import 'package:built_value/built_value.dart';
import 'package:chato/feature/autho/forgot/model/forget_password_data_model.dart';
import '../model/change_password_model.dart';
import '../model/forget_password_model.dart';



part 'forget_state.g.dart';


abstract class ForgetState implements Built<ForgetState,
    ForgetStateBuilder> {


  bool? get isSuccess;
  bool? get first;
  bool? get isLoading;
  String? get error;
  ForgetPasswordModel? get forgetPasswordModel;
  ChangePasswordModel? get changePasswordModel;

  ForgetState._();

  factory ForgetState([void Function(ForgetStateBuilder) updates])
  = _$ForgetState;

  factory ForgetState.initial() {
    return ForgetState((b) => b
      ..isLoading = false
      ..first=true
      ..isSuccess = false
      ..error=''
      ..forgetPasswordModel=ForgetPasswordModel(
          data: ForgetPasswordDataModel(
              email: '',
              code: 0),
          message: '',
          error_code: 0,
          status: false
      )
        ..changePasswordModel=ChangePasswordModel(
          status: null,
          message: '',
          error_code: 0
        )

    );
  }
}


