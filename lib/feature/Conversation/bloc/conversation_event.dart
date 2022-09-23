import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/private_old_message_data_model.dart';

@immutable
abstract class ConversationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ShowEmojiEvent extends ConversationEvent{
   bool show;
   ShowEmojiEvent(this.show);
}
// ignore: must_be_immutable
class StartRecordEvent extends ConversationEvent{
  bool isRecord;
  StartRecordEvent(this.isRecord);
}

// ignore: must_be_immutable
class GetConversationMessage extends ConversationEvent
{
  String id;
  int page;
  GetConversationMessage({
    required this.id,
    required this.page});
}


// ignore: must_be_immutable
class AddMessageFromPusherEvent extends ConversationEvent
{
  PrivateOldMessageDataModel message;
  AddMessageFromPusherEvent({
    required this.message,

  });
}
// ignore: must_be_immutable
class SendMessageEvent extends ConversationEvent
{
  File? allFile;
  String message;
  int userTwoId;
  SendMessageEvent({
    required this.message,
    required this.userTwoId,
    required this.allFile
  });
}

// ignore: must_be_immutable
class BlockUserEvent extends ConversationEvent
{

  int userId;
  BlockUserEvent({
    required this.userId,
  });
}


// ignore: must_be_immutable
class GetConversationIdEvent extends ConversationEvent
{

  int userId;
  GetConversationIdEvent({
    required this.userId,
  });
}

// ignore: must_be_immutable
class ChangeRecordTimerEvent extends ConversationEvent
{
  int count;
  ChangeRecordTimerEvent({
    required this.count,
  });
}


