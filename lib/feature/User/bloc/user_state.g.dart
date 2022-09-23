// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserState extends UserState {
  @override
  final bool? isSuccess;
  @override
  final bool? addFriend;
  @override
  final String? age;
  @override
  final bool? isLoading;
  @override
  final String? error;
  @override
  final UserModel? userModel;
  @override
  final AddFriendModel? addFriendModel;

  factory _$UserState([void Function(UserStateBuilder)? updates]) =>
      (new UserStateBuilder()..update(updates)).build();

  _$UserState._(
      {this.isSuccess,
      this.addFriend,
      this.age,
      this.isLoading,
      this.error,
      this.userModel,
      this.addFriendModel})
      : super._();

  @override
  UserState rebuild(void Function(UserStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStateBuilder toBuilder() => new UserStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserState &&
        isSuccess == other.isSuccess &&
        addFriend == other.addFriend &&
        age == other.age &&
        isLoading == other.isLoading &&
        error == other.error &&
        userModel == other.userModel &&
        addFriendModel == other.addFriendModel;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, isSuccess.hashCode), addFriend.hashCode),
                        age.hashCode),
                    isLoading.hashCode),
                error.hashCode),
            userModel.hashCode),
        addFriendModel.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserState')
          ..add('isSuccess', isSuccess)
          ..add('addFriend', addFriend)
          ..add('age', age)
          ..add('isLoading', isLoading)
          ..add('error', error)
          ..add('userModel', userModel)
          ..add('addFriendModel', addFriendModel))
        .toString();
  }
}

class UserStateBuilder implements Builder<UserState, UserStateBuilder> {
  _$UserState? _$v;

  bool? _isSuccess;
  bool? get isSuccess => _$this._isSuccess;
  set isSuccess(bool? isSuccess) => _$this._isSuccess = isSuccess;

  bool? _addFriend;
  bool? get addFriend => _$this._addFriend;
  set addFriend(bool? addFriend) => _$this._addFriend = addFriend;

  String? _age;
  String? get age => _$this._age;
  set age(String? age) => _$this._age = age;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  UserModel? _userModel;
  UserModel? get userModel => _$this._userModel;
  set userModel(UserModel? userModel) => _$this._userModel = userModel;

  AddFriendModel? _addFriendModel;
  AddFriendModel? get addFriendModel => _$this._addFriendModel;
  set addFriendModel(AddFriendModel? addFriendModel) =>
      _$this._addFriendModel = addFriendModel;

  UserStateBuilder();

  UserStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isSuccess = $v.isSuccess;
      _addFriend = $v.addFriend;
      _age = $v.age;
      _isLoading = $v.isLoading;
      _error = $v.error;
      _userModel = $v.userModel;
      _addFriendModel = $v.addFriendModel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserState;
  }

  @override
  void update(void Function(UserStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserState build() {
    final _$result = _$v ??
        new _$UserState._(
            isSuccess: isSuccess,
            addFriend: addFriend,
            age: age,
            isLoading: isLoading,
            error: error,
            userModel: userModel,
            addFriendModel: addFriendModel);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
