import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ForgetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ForgetPasswordEvent extends ForgetEvent {
  String email;

  ForgetPasswordEvent({
    required this.email,
  });
}




// ignore: must_be_immutable
class ChangePasswordEvent extends ForgetEvent {
  String password;
  String email;
  String code;
  ChangePasswordEvent({
    required this.password,
    required this.email,
    required this.code,
  });

}

// ignore: must_be_immutable
class ChangeFirstEvent extends ForgetEvent {
  bool first;

  ChangeFirstEvent({
    required this.first,

  });

}


