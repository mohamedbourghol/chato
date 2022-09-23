import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvents extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetUserDetailsEvent extends UserEvents {
 int id;
 GetUserDetailsEvent({required this.id});
}
// ignore: must_be_immutable
class ChangeStatusEvent extends UserEvents {
  bool status;
  ChangeStatusEvent({required this.status});
}

// ignore: must_be_immutable
class AddFriendEvent extends UserEvents{
   int id;
   AddFriendEvent({required this.id});
}
