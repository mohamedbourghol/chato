import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class LoginAccountEvent extends LoginEvent {
  String name;
  String password;

  LoginAccountEvent({
    required this.name,
    required this.password,
  });
}
