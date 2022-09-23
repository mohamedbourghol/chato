import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RoomEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ChangeFilterEvent extends RoomEvent{
   int selectFilter;
   ChangeFilterEvent(this.selectFilter);
}

// ignore: must_be_immutable
class CreateRoomEvent extends RoomEvent{
  String roomName;
  CreateRoomEvent({required this.roomName});
}

// ignore: must_be_immutable
class RemoveFavEvent extends RoomEvent{
  int roomId;
  RemoveFavEvent({required this.roomId});
}

// ignore: must_be_immutable
class GetUserRoomEvent extends RoomEvent{
}
// ignore: must_be_immutable
class GetFavRoomEvent extends RoomEvent{
}
// ignore: must_be_immutable
class GetTrendRoomEvent extends RoomEvent{
}
// ignore: must_be_immutable
class GetAllRoomEvent extends RoomEvent{
}

// ignore: must_be_immutable
class SearchEvent extends RoomEvent{
  String se;
  SearchEvent({
    required this.se
});
}