// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConversationState extends ConversationState {
  @override
  final bool? isSuccess;
  @override
  final bool? isLoading;
  @override
  final bool? isSuccessBloc;
  @override
  final bool? isLoadingBloc;
  @override
  final bool showEmoji;
  @override
  final bool isRecord;
  @override
  final PrivateOldMessageModel privateOldMessageModel;
  @override
  final String error;
  @override
  final SendMessageModel sendMessageModel;
  @override
  final String smile;
  @override
  final String recordTime;
  @override
  final String blocUser;
  @override
  final GetConversationIdModel getConversationIdModel;

  factory _$ConversationState(
          [void Function(ConversationStateBuilder)? updates]) =>
      (new ConversationStateBuilder()..update(updates)).build();

  _$ConversationState._(
      {this.isSuccess,
      this.isLoading,
      this.isSuccessBloc,
      this.isLoadingBloc,
      required this.showEmoji,
      required this.isRecord,
      required this.privateOldMessageModel,
      required this.error,
      required this.sendMessageModel,
      required this.smile,
      required this.recordTime,
      required this.blocUser,
      required this.getConversationIdModel})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        showEmoji, 'ConversationState', 'showEmoji');
    BuiltValueNullFieldError.checkNotNull(
        isRecord, 'ConversationState', 'isRecord');
    BuiltValueNullFieldError.checkNotNull(
        privateOldMessageModel, 'ConversationState', 'privateOldMessageModel');
    BuiltValueNullFieldError.checkNotNull(error, 'ConversationState', 'error');
    BuiltValueNullFieldError.checkNotNull(
        sendMessageModel, 'ConversationState', 'sendMessageModel');
    BuiltValueNullFieldError.checkNotNull(smile, 'ConversationState', 'smile');
    BuiltValueNullFieldError.checkNotNull(
        recordTime, 'ConversationState', 'recordTime');
    BuiltValueNullFieldError.checkNotNull(
        blocUser, 'ConversationState', 'blocUser');
    BuiltValueNullFieldError.checkNotNull(
        getConversationIdModel, 'ConversationState', 'getConversationIdModel');
  }

  @override
  ConversationState rebuild(void Function(ConversationStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConversationStateBuilder toBuilder() =>
      new ConversationStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConversationState &&
        isSuccess == other.isSuccess &&
        isLoading == other.isLoading &&
        isSuccessBloc == other.isSuccessBloc &&
        isLoadingBloc == other.isLoadingBloc &&
        showEmoji == other.showEmoji &&
        isRecord == other.isRecord &&
        privateOldMessageModel == other.privateOldMessageModel &&
        error == other.error &&
        sendMessageModel == other.sendMessageModel &&
        smile == other.smile &&
        recordTime == other.recordTime &&
        blocUser == other.blocUser &&
        getConversationIdModel == other.getConversationIdModel;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc($jc(0, isSuccess.hashCode),
                                                    isLoading.hashCode),
                                                isSuccessBloc.hashCode),
                                            isLoadingBloc.hashCode),
                                        showEmoji.hashCode),
                                    isRecord.hashCode),
                                privateOldMessageModel.hashCode),
                            error.hashCode),
                        sendMessageModel.hashCode),
                    smile.hashCode),
                recordTime.hashCode),
            blocUser.hashCode),
        getConversationIdModel.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ConversationState')
          ..add('isSuccess', isSuccess)
          ..add('isLoading', isLoading)
          ..add('isSuccessBloc', isSuccessBloc)
          ..add('isLoadingBloc', isLoadingBloc)
          ..add('showEmoji', showEmoji)
          ..add('isRecord', isRecord)
          ..add('privateOldMessageModel', privateOldMessageModel)
          ..add('error', error)
          ..add('sendMessageModel', sendMessageModel)
          ..add('smile', smile)
          ..add('recordTime', recordTime)
          ..add('blocUser', blocUser)
          ..add('getConversationIdModel', getConversationIdModel))
        .toString();
  }
}

class ConversationStateBuilder
    implements Builder<ConversationState, ConversationStateBuilder> {
  _$ConversationState? _$v;

  bool? _isSuccess;
  bool? get isSuccess => _$this._isSuccess;
  set isSuccess(bool? isSuccess) => _$this._isSuccess = isSuccess;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  bool? _isSuccessBloc;
  bool? get isSuccessBloc => _$this._isSuccessBloc;
  set isSuccessBloc(bool? isSuccessBloc) =>
      _$this._isSuccessBloc = isSuccessBloc;

  bool? _isLoadingBloc;
  bool? get isLoadingBloc => _$this._isLoadingBloc;
  set isLoadingBloc(bool? isLoadingBloc) =>
      _$this._isLoadingBloc = isLoadingBloc;

  bool? _showEmoji;
  bool? get showEmoji => _$this._showEmoji;
  set showEmoji(bool? showEmoji) => _$this._showEmoji = showEmoji;

  bool? _isRecord;
  bool? get isRecord => _$this._isRecord;
  set isRecord(bool? isRecord) => _$this._isRecord = isRecord;

  PrivateOldMessageModel? _privateOldMessageModel;
  PrivateOldMessageModel? get privateOldMessageModel =>
      _$this._privateOldMessageModel;
  set privateOldMessageModel(PrivateOldMessageModel? privateOldMessageModel) =>
      _$this._privateOldMessageModel = privateOldMessageModel;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  SendMessageModel? _sendMessageModel;
  SendMessageModel? get sendMessageModel => _$this._sendMessageModel;
  set sendMessageModel(SendMessageModel? sendMessageModel) =>
      _$this._sendMessageModel = sendMessageModel;

  String? _smile;
  String? get smile => _$this._smile;
  set smile(String? smile) => _$this._smile = smile;

  String? _recordTime;
  String? get recordTime => _$this._recordTime;
  set recordTime(String? recordTime) => _$this._recordTime = recordTime;

  String? _blocUser;
  String? get blocUser => _$this._blocUser;
  set blocUser(String? blocUser) => _$this._blocUser = blocUser;

  GetConversationIdModel? _getConversationIdModel;
  GetConversationIdModel? get getConversationIdModel =>
      _$this._getConversationIdModel;
  set getConversationIdModel(GetConversationIdModel? getConversationIdModel) =>
      _$this._getConversationIdModel = getConversationIdModel;

  ConversationStateBuilder();

  ConversationStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isSuccess = $v.isSuccess;
      _isLoading = $v.isLoading;
      _isSuccessBloc = $v.isSuccessBloc;
      _isLoadingBloc = $v.isLoadingBloc;
      _showEmoji = $v.showEmoji;
      _isRecord = $v.isRecord;
      _privateOldMessageModel = $v.privateOldMessageModel;
      _error = $v.error;
      _sendMessageModel = $v.sendMessageModel;
      _smile = $v.smile;
      _recordTime = $v.recordTime;
      _blocUser = $v.blocUser;
      _getConversationIdModel = $v.getConversationIdModel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConversationState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConversationState;
  }

  @override
  void update(void Function(ConversationStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ConversationState build() {
    final _$result = _$v ??
        new _$ConversationState._(
            isSuccess: isSuccess,
            isLoading: isLoading,
            isSuccessBloc: isSuccessBloc,
            isLoadingBloc: isLoadingBloc,
            showEmoji: BuiltValueNullFieldError.checkNotNull(
                showEmoji, 'ConversationState', 'showEmoji'),
            isRecord: BuiltValueNullFieldError.checkNotNull(
                isRecord, 'ConversationState', 'isRecord'),
            privateOldMessageModel: BuiltValueNullFieldError.checkNotNull(
                privateOldMessageModel, 'ConversationState', 'privateOldMessageModel'),
            error: BuiltValueNullFieldError.checkNotNull(
                error, 'ConversationState', 'error'),
            sendMessageModel: BuiltValueNullFieldError.checkNotNull(
                sendMessageModel, 'ConversationState', 'sendMessageModel'),
            smile: BuiltValueNullFieldError.checkNotNull(
                smile, 'ConversationState', 'smile'),
            recordTime: BuiltValueNullFieldError.checkNotNull(
                recordTime, 'ConversationState', 'recordTime'),
            blocUser: BuiltValueNullFieldError.checkNotNull(
                blocUser, 'ConversationState', 'blocUser'),
            getConversationIdModel: BuiltValueNullFieldError.checkNotNull(getConversationIdModel, 'ConversationState', 'getConversationIdModel'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
