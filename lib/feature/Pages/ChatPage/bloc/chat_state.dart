import 'package:built_value/built_value.dart';

import '../model/get_conversation_privet_model.dart';

part 'chat_state.g.dart';


abstract class ChatState implements
    Built<ChatState, ChatStateBuilder> {



  bool? get isSuccessGet;
  bool? get isLoadingGet;


  GetConversationPrivateModel get getConversationPrivateModel;
  String get error;

  ChatState._();

  factory ChatState([void Function(ChatStateBuilder) updates]) = _$ChatState;

  factory ChatState.initial() {
    return ChatState((b) => b

      ..isLoadingGet = false
      ..isSuccessGet = false

        ..getConversationPrivateModel=
        GetConversationPrivateModel(
          data: [],
          error_code: 0,
          message: '',
          status: false,

        )

        ..error=''

    );
  }
}


