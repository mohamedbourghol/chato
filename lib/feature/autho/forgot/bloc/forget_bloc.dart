
import 'package:bloc/bloc.dart';
import '../api/change_password_remote.dart';
import '../api/forget-password_remote.dart';
import '../model/change_password_model.dart';
import '../model/forget_password_data_model.dart';
import '../model/forget_password_model.dart';
import 'forget_event.dart';
import 'forget_state.dart';

class ForgetBloc extends Bloc<ForgetEvent, ForgetState> {
  ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource;
  ChangePasswordRemoteDataSource changePasswordRemoteDataSource;
  ForgetBloc({
    required this.forgetPasswordRemoteDataSource,
    required this.changePasswordRemoteDataSource
  }) : super(ForgetState.initial()) {
    on<ForgetPasswordEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isSuccess = false
        ..first=true
        ..isLoading = true
        ..forgetPasswordModel = ForgetPasswordModel(
            data: ForgetPasswordDataModel
              (email: '',code: 0),
            message: '',
            error_code: 0,
            status: false)
      ));
      final result = await forgetPasswordRemoteDataSource.
      forgetPassword(
        email: event.email
      );

       result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess = false
          ..isLoading = false
          ..first=false
          ..error = l));
      }, (r) async {


        emit(state.rebuild((b) => b
          ..isSuccess = true
          ..isLoading = false
          ..first=true
          ..forgetPasswordModel = r));
      });
      emit(state.rebuild((b) => b

        ..first=false
        ));

    });



    on<ChangePasswordEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isSuccess = false
        ..isLoading = true

        ..changePasswordModel = ChangePasswordModel(
            message: '',
            error_code: 0,
            status: null)
      ));
      final result = await changePasswordRemoteDataSource.
      changePassword(
          email: state.forgetPasswordModel!.data!.email!,
        code: state.forgetPasswordModel!.data!.code!.toString(),
        password:event.password ,
       );

      result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess = false
          ..isLoading = false
          ..error = l));
      }, (r) async {
        emit(state.rebuild((b) => b
          ..isSuccess = true
          ..isLoading = false
          ..changePasswordModel = r));
      });


    });




  }

  void onForgetPasswordEvent({
    required String email,
     }) {
    add(ForgetPasswordEvent(
      email: email
    ));
  }


  void onChangePasswordEvent({
    required String password,
    required String code,
    required String email,
  }) {
    add(ChangePasswordEvent(
          password: password,
          code: code,
           email:email

    ));}




}

