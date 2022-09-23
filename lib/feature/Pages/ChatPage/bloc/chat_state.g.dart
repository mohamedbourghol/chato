// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatState extends ChatState {
  @override
  final bool? isSuccessGet;
  @override
  final bool? isLoadingGet;
  @override
  final GetConversationPrivateModel getConversationPrivateModel;
  @override
  final String error;

  factory _$ChatState([void Function(ChatStateBuilder)? updates]) =>
      (new ChatStateBuilder()..update(updates)).build();

  _$ChatState._(
      {this.isSuccessGet,
      this.isLoadingGet,
      required this.getConversationPrivateModel,
      required this.error})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(getConversationPrivateModel,
        'ChatState', 'getConversationPrivateModel');
    BuiltValueNullFieldError.checkNotNull(error, 'ChatState', 'error');
  }

  @override
  ChatState rebuild(void Function(ChatStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatStateBuilder toBuilder() => new ChatStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatState &&
        isSuccessGet == other.isSuccessGet &&
        isLoadingGet == other.isLoadingGet &&
        getConversationPrivateModel == other.getConversationPrivateModel &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, isSuccessGet.hashCode), isLoadingGet.hashCode),
            getConversationPrivateModel.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChatState')
          ..add('isSuccessGet', isSuccessGet)
          ..add('isLoadingGet', isLoadingGet)
          ..add('getConversationPrivateModel', getConversationPrivateModel)
          ..add('error', error))
        .toString();
  }
}

class ChatStateBuilder implements Builder<ChatState, ChatStateBuilder> {
  _$ChatState? _$v;

  bool? _isSuccessGet;
  bool? get isSuccessGet => _$this._isSuccessGet;
  set isSuccessGet(bool? isSuccessGet) => _$this._isSuccessGet = isSuccessGet;

  bool? _isLoadingGet;
  bool? get isLoadingGet => _$this._isLoadingGet;
  set isLoadingGet(bool? isLoadingGet) => _$this._isLoadingGet = isLoadingGet;

  GetConversationPrivateModel? _getConversationPrivateModel;
  GetConversationPrivateModel? get getConversationPrivateModel =>
      _$this._getConversationPrivateModel;
  set getConversationPrivateModel(
          GetConversationPrivateModel? getConversationPrivateModel) =>
      _$this._getConversationPrivateModel = getConversationPrivateModel;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  ChatStateBuilder();

  ChatStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isSuccessGet = $v.isSuccessGet;
      _isLoadingGet = $v.isLoadingGet;
      _getConversationPrivateModel = $v.getConversationPrivateModel;
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatState;
  }

  @override
  void update(void Function(ChatStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ChatState build() {
    final _$result = _$v ??
        new _$ChatState._(
            isSuccessGet: isSuccessGet,
            isLoadingGet: isLoadingGet,
            getConversationPrivateModel: BuiltValueNullFieldError.checkNotNull(
                getConversationPrivateModel,
                'ChatState',
                'getConversationPrivateModel'),
            error: BuiltValueNullFieldError.checkNotNull(
                error, 'ChatState', 'error'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
