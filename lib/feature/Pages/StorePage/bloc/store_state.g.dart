// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StoreState extends StoreState {
  @override
  final bool? isSuccess;
  @override
  final bool? isLoading;
  @override
  final int selectedPage;
  @override
  final UpdateCoinsModel updateCoinsModel;
  @override
  final String type;
  @override
  final String quantity;
  @override
  final VipModel vipModel;

  factory _$StoreState([void Function(StoreStateBuilder)? updates]) =>
      (new StoreStateBuilder()..update(updates)).build();

  _$StoreState._(
      {this.isSuccess,
      this.isLoading,
      required this.selectedPage,
      required this.updateCoinsModel,
      required this.type,
      required this.quantity,
      required this.vipModel})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        selectedPage, 'StoreState', 'selectedPage');
    BuiltValueNullFieldError.checkNotNull(
        updateCoinsModel, 'StoreState', 'updateCoinsModel');
    BuiltValueNullFieldError.checkNotNull(type, 'StoreState', 'type');
    BuiltValueNullFieldError.checkNotNull(quantity, 'StoreState', 'quantity');
    BuiltValueNullFieldError.checkNotNull(vipModel, 'StoreState', 'vipModel');
  }

  @override
  StoreState rebuild(void Function(StoreStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StoreStateBuilder toBuilder() => new StoreStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StoreState &&
        isSuccess == other.isSuccess &&
        isLoading == other.isLoading &&
        selectedPage == other.selectedPage &&
        updateCoinsModel == other.updateCoinsModel &&
        type == other.type &&
        quantity == other.quantity &&
        vipModel == other.vipModel;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, isSuccess.hashCode), isLoading.hashCode),
                        selectedPage.hashCode),
                    updateCoinsModel.hashCode),
                type.hashCode),
            quantity.hashCode),
        vipModel.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StoreState')
          ..add('isSuccess', isSuccess)
          ..add('isLoading', isLoading)
          ..add('selectedPage', selectedPage)
          ..add('updateCoinsModel', updateCoinsModel)
          ..add('type', type)
          ..add('quantity', quantity)
          ..add('vipModel', vipModel))
        .toString();
  }
}

class StoreStateBuilder implements Builder<StoreState, StoreStateBuilder> {
  _$StoreState? _$v;

  bool? _isSuccess;
  bool? get isSuccess => _$this._isSuccess;
  set isSuccess(bool? isSuccess) => _$this._isSuccess = isSuccess;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  int? _selectedPage;
  int? get selectedPage => _$this._selectedPage;
  set selectedPage(int? selectedPage) => _$this._selectedPage = selectedPage;

  UpdateCoinsModel? _updateCoinsModel;
  UpdateCoinsModel? get updateCoinsModel => _$this._updateCoinsModel;
  set updateCoinsModel(UpdateCoinsModel? updateCoinsModel) =>
      _$this._updateCoinsModel = updateCoinsModel;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  VipModel? _vipModel;
  VipModel? get vipModel => _$this._vipModel;
  set vipModel(VipModel? vipModel) => _$this._vipModel = vipModel;

  StoreStateBuilder();

  StoreStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isSuccess = $v.isSuccess;
      _isLoading = $v.isLoading;
      _selectedPage = $v.selectedPage;
      _updateCoinsModel = $v.updateCoinsModel;
      _type = $v.type;
      _quantity = $v.quantity;
      _vipModel = $v.vipModel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StoreState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$StoreState;
  }

  @override
  void update(void Function(StoreStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StoreState build() {
    final _$result = _$v ??
        new _$StoreState._(
            isSuccess: isSuccess,
            isLoading: isLoading,
            selectedPage: BuiltValueNullFieldError.checkNotNull(
                selectedPage, 'StoreState', 'selectedPage'),
            updateCoinsModel: BuiltValueNullFieldError.checkNotNull(
                updateCoinsModel, 'StoreState', 'updateCoinsModel'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, 'StoreState', 'type'),
            quantity: BuiltValueNullFieldError.checkNotNull(
                quantity, 'StoreState', 'quantity'),
            vipModel: BuiltValueNullFieldError.checkNotNull(
                vipModel, 'StoreState', 'vipModel'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
