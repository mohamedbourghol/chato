// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegisterState extends RegisterState {
  @override
  final bool? isSuccess;
  @override
  final bool? isLoading;
  @override
  final String? error;
  @override
  final int selectedPage;
  @override
  final RegisterModel? registerModel;

  factory _$RegisterState([void Function(RegisterStateBuilder)? updates]) =>
      (new RegisterStateBuilder()..update(updates)).build();

  _$RegisterState._(
      {this.isSuccess,
      this.isLoading,
      this.error,
      required this.selectedPage,
      this.registerModel})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        selectedPage, 'RegisterState', 'selectedPage');
  }

  @override
  RegisterState rebuild(void Function(RegisterStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterStateBuilder toBuilder() => new RegisterStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterState &&
        isSuccess == other.isSuccess &&
        isLoading == other.isLoading &&
        error == other.error &&
        selectedPage == other.selectedPage &&
        registerModel == other.registerModel;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, isSuccess.hashCode), isLoading.hashCode),
                error.hashCode),
            selectedPage.hashCode),
        registerModel.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RegisterState')
          ..add('isSuccess', isSuccess)
          ..add('isLoading', isLoading)
          ..add('error', error)
          ..add('selectedPage', selectedPage)
          ..add('registerModel', registerModel))
        .toString();
  }
}

class RegisterStateBuilder
    implements Builder<RegisterState, RegisterStateBuilder> {
  _$RegisterState? _$v;

  bool? _isSuccess;
  bool? get isSuccess => _$this._isSuccess;
  set isSuccess(bool? isSuccess) => _$this._isSuccess = isSuccess;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  int? _selectedPage;
  int? get selectedPage => _$this._selectedPage;
  set selectedPage(int? selectedPage) => _$this._selectedPage = selectedPage;

  RegisterModel? _registerModel;
  RegisterModel? get registerModel => _$this._registerModel;
  set registerModel(RegisterModel? registerModel) =>
      _$this._registerModel = registerModel;

  RegisterStateBuilder();

  RegisterStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isSuccess = $v.isSuccess;
      _isLoading = $v.isLoading;
      _error = $v.error;
      _selectedPage = $v.selectedPage;
      _registerModel = $v.registerModel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RegisterState;
  }

  @override
  void update(void Function(RegisterStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RegisterState build() {
    final _$result = _$v ??
        new _$RegisterState._(
            isSuccess: isSuccess,
            isLoading: isLoading,
            error: error,
            selectedPage: BuiltValueNullFieldError.checkNotNull(
                selectedPage, 'RegisterState', 'selectedPage'),
            registerModel: registerModel);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
