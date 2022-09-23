// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ForgetState extends ForgetState {
  @override
  final bool? isSuccess;
  @override
  final bool? first;
  @override
  final bool? isLoading;
  @override
  final String? error;
  @override
  final ForgetPasswordModel? forgetPasswordModel;
  @override
  final ChangePasswordModel? changePasswordModel;

  factory _$ForgetState([void Function(ForgetStateBuilder)? updates]) =>
      (new ForgetStateBuilder()..update(updates)).build();

  _$ForgetState._(
      {this.isSuccess,
      this.first,
      this.isLoading,
      this.error,
      this.forgetPasswordModel,
      this.changePasswordModel})
      : super._();

  @override
  ForgetState rebuild(void Function(ForgetStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ForgetStateBuilder toBuilder() => new ForgetStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForgetState &&
        isSuccess == other.isSuccess &&
        first == other.first &&
        isLoading == other.isLoading &&
        error == other.error &&
        forgetPasswordModel == other.forgetPasswordModel &&
        changePasswordModel == other.changePasswordModel;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, isSuccess.hashCode), first.hashCode),
                    isLoading.hashCode),
                error.hashCode),
            forgetPasswordModel.hashCode),
        changePasswordModel.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ForgetState')
          ..add('isSuccess', isSuccess)
          ..add('first', first)
          ..add('isLoading', isLoading)
          ..add('error', error)
          ..add('forgetPasswordModel', forgetPasswordModel)
          ..add('changePasswordModel', changePasswordModel))
        .toString();
  }
}

class ForgetStateBuilder implements Builder<ForgetState, ForgetStateBuilder> {
  _$ForgetState? _$v;

  bool? _isSuccess;
  bool? get isSuccess => _$this._isSuccess;
  set isSuccess(bool? isSuccess) => _$this._isSuccess = isSuccess;

  bool? _first;
  bool? get first => _$this._first;
  set first(bool? first) => _$this._first = first;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  ForgetPasswordModel? _forgetPasswordModel;
  ForgetPasswordModel? get forgetPasswordModel => _$this._forgetPasswordModel;
  set forgetPasswordModel(ForgetPasswordModel? forgetPasswordModel) =>
      _$this._forgetPasswordModel = forgetPasswordModel;

  ChangePasswordModel? _changePasswordModel;
  ChangePasswordModel? get changePasswordModel => _$this._changePasswordModel;
  set changePasswordModel(ChangePasswordModel? changePasswordModel) =>
      _$this._changePasswordModel = changePasswordModel;

  ForgetStateBuilder();

  ForgetStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isSuccess = $v.isSuccess;
      _first = $v.first;
      _isLoading = $v.isLoading;
      _error = $v.error;
      _forgetPasswordModel = $v.forgetPasswordModel;
      _changePasswordModel = $v.changePasswordModel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForgetState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ForgetState;
  }

  @override
  void update(void Function(ForgetStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ForgetState build() {
    final _$result = _$v ??
        new _$ForgetState._(
            isSuccess: isSuccess,
            first: first,
            isLoading: isLoading,
            error: error,
            forgetPasswordModel: forgetPasswordModel,
            changePasswordModel: changePasswordModel);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
