// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prof_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProfState extends ProfState {
  @override
  final bool? isSuccess;
  @override
  final bool? isLoading;
  @override
  final bool? isSuccessLogout;
  @override
  final bool? isLoadingLogout;
  @override
  final bool? isSuccessSendCoins;
  @override
  final bool? isLoadingSendCoins;
  @override
  final bool? isSuccessChange;
  @override
  final bool? isLoadingChange;
  @override
  final String? error;
  @override
  final File? img;
  @override
  final ProfileModel? profileModel;
  @override
  final CountFriendModel? countFriendModel;
  @override
  final BlockedUserModel? blockedUserModel;
  @override
  final ResetModel resetModel;
  @override
  final SendCoinsModel sendCoinsModel;
  @override
  final CountryModel countryModel;

  factory _$ProfState([void Function(ProfStateBuilder)? updates]) =>
      (new ProfStateBuilder()..update(updates)).build();

  _$ProfState._(
      {this.isSuccess,
      this.isLoading,
      this.isSuccessLogout,
      this.isLoadingLogout,
      this.isSuccessSendCoins,
      this.isLoadingSendCoins,
      this.isSuccessChange,
      this.isLoadingChange,
      this.error,
      this.img,
      this.profileModel,
      this.countFriendModel,
      this.blockedUserModel,
      required this.resetModel,
      required this.sendCoinsModel,
      required this.countryModel})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        resetModel, 'ProfState', 'resetModel');
    BuiltValueNullFieldError.checkNotNull(
        sendCoinsModel, 'ProfState', 'sendCoinsModel');
    BuiltValueNullFieldError.checkNotNull(
        countryModel, 'ProfState', 'countryModel');
  }

  @override
  ProfState rebuild(void Function(ProfStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfStateBuilder toBuilder() => new ProfStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfState &&
        isSuccess == other.isSuccess &&
        isLoading == other.isLoading &&
        isSuccessLogout == other.isSuccessLogout &&
        isLoadingLogout == other.isLoadingLogout &&
        isSuccessSendCoins == other.isSuccessSendCoins &&
        isLoadingSendCoins == other.isLoadingSendCoins &&
        isSuccessChange == other.isSuccessChange &&
        isLoadingChange == other.isLoadingChange &&
        error == other.error &&
        img == other.img &&
        profileModel == other.profileModel &&
        countFriendModel == other.countFriendModel &&
        blockedUserModel == other.blockedUserModel &&
        resetModel == other.resetModel &&
        sendCoinsModel == other.sendCoinsModel &&
        countryModel == other.countryModel;
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
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    0,
                                                                    isSuccess
                                                                        .hashCode),
                                                                isLoading
                                                                    .hashCode),
                                                            isSuccessLogout
                                                                .hashCode),
                                                        isLoadingLogout
                                                            .hashCode),
                                                    isSuccessSendCoins
                                                        .hashCode),
                                                isLoadingSendCoins.hashCode),
                                            isSuccessChange.hashCode),
                                        isLoadingChange.hashCode),
                                    error.hashCode),
                                img.hashCode),
                            profileModel.hashCode),
                        countFriendModel.hashCode),
                    blockedUserModel.hashCode),
                resetModel.hashCode),
            sendCoinsModel.hashCode),
        countryModel.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProfState')
          ..add('isSuccess', isSuccess)
          ..add('isLoading', isLoading)
          ..add('isSuccessLogout', isSuccessLogout)
          ..add('isLoadingLogout', isLoadingLogout)
          ..add('isSuccessSendCoins', isSuccessSendCoins)
          ..add('isLoadingSendCoins', isLoadingSendCoins)
          ..add('isSuccessChange', isSuccessChange)
          ..add('isLoadingChange', isLoadingChange)
          ..add('error', error)
          ..add('img', img)
          ..add('profileModel', profileModel)
          ..add('countFriendModel', countFriendModel)
          ..add('blockedUserModel', blockedUserModel)
          ..add('resetModel', resetModel)
          ..add('sendCoinsModel', sendCoinsModel)
          ..add('countryModel', countryModel))
        .toString();
  }
}

class ProfStateBuilder implements Builder<ProfState, ProfStateBuilder> {
  _$ProfState? _$v;

  bool? _isSuccess;
  bool? get isSuccess => _$this._isSuccess;
  set isSuccess(bool? isSuccess) => _$this._isSuccess = isSuccess;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  bool? _isSuccessLogout;
  bool? get isSuccessLogout => _$this._isSuccessLogout;
  set isSuccessLogout(bool? isSuccessLogout) =>
      _$this._isSuccessLogout = isSuccessLogout;

  bool? _isLoadingLogout;
  bool? get isLoadingLogout => _$this._isLoadingLogout;
  set isLoadingLogout(bool? isLoadingLogout) =>
      _$this._isLoadingLogout = isLoadingLogout;

  bool? _isSuccessSendCoins;
  bool? get isSuccessSendCoins => _$this._isSuccessSendCoins;
  set isSuccessSendCoins(bool? isSuccessSendCoins) =>
      _$this._isSuccessSendCoins = isSuccessSendCoins;

  bool? _isLoadingSendCoins;
  bool? get isLoadingSendCoins => _$this._isLoadingSendCoins;
  set isLoadingSendCoins(bool? isLoadingSendCoins) =>
      _$this._isLoadingSendCoins = isLoadingSendCoins;

  bool? _isSuccessChange;
  bool? get isSuccessChange => _$this._isSuccessChange;
  set isSuccessChange(bool? isSuccessChange) =>
      _$this._isSuccessChange = isSuccessChange;

  bool? _isLoadingChange;
  bool? get isLoadingChange => _$this._isLoadingChange;
  set isLoadingChange(bool? isLoadingChange) =>
      _$this._isLoadingChange = isLoadingChange;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  File? _img;
  File? get img => _$this._img;
  set img(File? img) => _$this._img = img;

  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _$this._profileModel;
  set profileModel(ProfileModel? profileModel) =>
      _$this._profileModel = profileModel;

  CountFriendModel? _countFriendModel;
  CountFriendModel? get countFriendModel => _$this._countFriendModel;
  set countFriendModel(CountFriendModel? countFriendModel) =>
      _$this._countFriendModel = countFriendModel;

  BlockedUserModel? _blockedUserModel;
  BlockedUserModel? get blockedUserModel => _$this._blockedUserModel;
  set blockedUserModel(BlockedUserModel? blockedUserModel) =>
      _$this._blockedUserModel = blockedUserModel;

  ResetModel? _resetModel;
  ResetModel? get resetModel => _$this._resetModel;
  set resetModel(ResetModel? resetModel) => _$this._resetModel = resetModel;

  SendCoinsModel? _sendCoinsModel;
  SendCoinsModel? get sendCoinsModel => _$this._sendCoinsModel;
  set sendCoinsModel(SendCoinsModel? sendCoinsModel) =>
      _$this._sendCoinsModel = sendCoinsModel;

  CountryModel? _countryModel;
  CountryModel? get countryModel => _$this._countryModel;
  set countryModel(CountryModel? countryModel) =>
      _$this._countryModel = countryModel;

  ProfStateBuilder();

  ProfStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isSuccess = $v.isSuccess;
      _isLoading = $v.isLoading;
      _isSuccessLogout = $v.isSuccessLogout;
      _isLoadingLogout = $v.isLoadingLogout;
      _isSuccessSendCoins = $v.isSuccessSendCoins;
      _isLoadingSendCoins = $v.isLoadingSendCoins;
      _isSuccessChange = $v.isSuccessChange;
      _isLoadingChange = $v.isLoadingChange;
      _error = $v.error;
      _img = $v.img;
      _profileModel = $v.profileModel;
      _countFriendModel = $v.countFriendModel;
      _blockedUserModel = $v.blockedUserModel;
      _resetModel = $v.resetModel;
      _sendCoinsModel = $v.sendCoinsModel;
      _countryModel = $v.countryModel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProfState;
  }

  @override
  void update(void Function(ProfStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProfState build() {
    final _$result = _$v ??
        new _$ProfState._(
            isSuccess: isSuccess,
            isLoading: isLoading,
            isSuccessLogout: isSuccessLogout,
            isLoadingLogout: isLoadingLogout,
            isSuccessSendCoins: isSuccessSendCoins,
            isLoadingSendCoins: isLoadingSendCoins,
            isSuccessChange: isSuccessChange,
            isLoadingChange: isLoadingChange,
            error: error,
            img: img,
            profileModel: profileModel,
            countFriendModel: countFriendModel,
            blockedUserModel: blockedUserModel,
            resetModel: BuiltValueNullFieldError.checkNotNull(
                resetModel, 'ProfState', 'resetModel'),
            sendCoinsModel: BuiltValueNullFieldError.checkNotNull(
                sendCoinsModel, 'ProfState', 'sendCoinsModel'),
            countryModel: BuiltValueNullFieldError.checkNotNull(
                countryModel, 'ProfState', 'countryModel'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
