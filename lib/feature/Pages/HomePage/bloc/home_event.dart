import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ChangePageEvent extends HomeEvent{
   int pageNumber;
   ChangePageEvent(this.pageNumber);
}


class GetFriendshipRequestsEvent extends HomeEvent{

}
class GetAllFriendEvent extends HomeEvent{

}

class GetStatusEvent extends HomeEvent{

}




// ignore: must_be_immutable
class SeenStatusEvent extends HomeEvent{
  int statusId;
  int seenNumber;
  int index;
  SeenStatusEvent({ required this.statusId,
  required this.index,
    required this.seenNumber
  });
}

// ignore: must_be_immutable
class GetSearchFriendEvent extends HomeEvent{
  String search;
  GetSearchFriendEvent({
    required this.search,
   });
}

// ignore: must_be_immutable
class AddStatusEvent extends HomeEvent{
  File file;
  AddStatusEvent({
    required this.file,
  });
}

// ignore: must_be_immutable
class ChangeRequestsFriend extends HomeEvent{
  int id;
  String status;
  ChangeRequestsFriend({
    required this.id,
    required this.status,
  });
}
