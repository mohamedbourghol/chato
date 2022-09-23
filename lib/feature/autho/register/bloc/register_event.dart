import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ChangePageEvent extends RegisterEvent{
   int pageNumber;
   ChangePageEvent(this.pageNumber);
}
// ignore: must_be_immutable
class RegisterAccountEvent extends RegisterEvent{
  String name;
  String email;
  String password;
  String passwordConfirm;
  RegisterAccountEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirm,
});
}
// ignore: must_be_immutable
class RegisterAmazingAccountEvent extends RegisterEvent{
  String name;
  String email;
  String password;
  String passwordConfirm;
  int cost;
  RegisterAmazingAccountEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.cost
  });
}

