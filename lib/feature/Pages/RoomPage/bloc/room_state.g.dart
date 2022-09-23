// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RoomState extends RoomState {
  @override
  final bool? isSuccess;
  @override
  final bool? isLoading;
  @override
  final String error;
  @override
  final bool? isSuccessGetUserRoom;
  @override
  final bool? isLoadingGetUserRoom;
  @override
  final String errorGetUserRoom;
  @override
  final int selectedFilter;
  @override
  final bool? isSuccessGetFavRoom;
  @override
  final bool? isLoadingGetFavRoom;
  @override
  final String errorGetFavRoom;
  @override
  final bool? isSuccessGetTrendRoom;
  @override
  final bool? isLoadingGetTrendRoom;
  @override
  final String errorGetTrendRoom;
  @override
  final bool? isSuccessGetAllRoom;
  @override
  final bool? isLoadingGetAllRoom;
  @override
  final String errorGetAllRoom;
  @override
  final CreateRoomModel createRoomModel;
  @override
  final UserRoomModel userRoomModel;
  @override
  final FavRoomModel favRoomModel;
  @override
  final TrendRoomModel trendRoomModel;
  @override
  final AllRoomModel allRoomModel;
  @override
  final String search;

  factory _$RoomState([void Function(RoomStateBuilder)? updates]) =>
      (new RoomStateBuilder()..update(updates)).build();

  _$RoomState._(
      {this.isSuccess,
      this.isLoading,
      required this.error,
      this.isSuccessGetUserRoom,
      this.isLoadingGetUserRoom,
      required this.errorGetUserRoom,
      required this.selectedFilter,
      this.isSuccessGetFavRoom,
      this.isLoadingGetFavRoom,
      required this.errorGetFavRoom,
      this.isSuccessGetTrendRoom,
      this.isLoadingGetTrendRoom,
      required this.errorGetTrendRoom,
      this.isSuccessGetAllRoom,
      this.isLoadingGetAllRoom,
      required this.errorGetAllRoom,
      required this.createRoomModel,
      required this.userRoomModel,
      required this.favRoomModel,
      required this.trendRoomModel,
      required this.allRoomModel,
      required this.search})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(error, 'RoomState', 'error');
    BuiltValueNullFieldError.checkNotNull(
        errorGetUserRoom, 'RoomState', 'errorGetUserRoom');
    BuiltValueNullFieldError.checkNotNull(
        selectedFilter, 'RoomState', 'selectedFilter');
    BuiltValueNullFieldError.checkNotNull(
        errorGetFavRoom, 'RoomState', 'errorGetFavRoom');
    BuiltValueNullFieldError.checkNotNull(
        errorGetTrendRoom, 'RoomState', 'errorGetTrendRoom');
    BuiltValueNullFieldError.checkNotNull(
        errorGetAllRoom, 'RoomState', 'errorGetAllRoom');
    BuiltValueNullFieldError.checkNotNull(
        createRoomModel, 'RoomState', 'createRoomModel');
    BuiltValueNullFieldError.checkNotNull(
        userRoomModel, 'RoomState', 'userRoomModel');
    BuiltValueNullFieldError.checkNotNull(
        favRoomModel, 'RoomState', 'favRoomModel');
    BuiltValueNullFieldError.checkNotNull(
        trendRoomModel, 'RoomState', 'trendRoomModel');
    BuiltValueNullFieldError.checkNotNull(
        allRoomModel, 'RoomState', 'allRoomModel');
    BuiltValueNullFieldError.checkNotNull(search, 'RoomState', 'search');
  }

  @override
  RoomState rebuild(void Function(RoomStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoomStateBuilder toBuilder() => new RoomStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoomState &&
        isSuccess == other.isSuccess &&
        isLoading == other.isLoading &&
        error == other.error &&
        isSuccessGetUserRoom == other.isSuccessGetUserRoom &&
        isLoadingGetUserRoom == other.isLoadingGetUserRoom &&
        errorGetUserRoom == other.errorGetUserRoom &&
        selectedFilter == other.selectedFilter &&
        isSuccessGetFavRoom == other.isSuccessGetFavRoom &&
        isLoadingGetFavRoom == other.isLoadingGetFavRoom &&
        errorGetFavRoom == other.errorGetFavRoom &&
        isSuccessGetTrendRoom == other.isSuccessGetTrendRoom &&
        isLoadingGetTrendRoom == other.isLoadingGetTrendRoom &&
        errorGetTrendRoom == other.errorGetTrendRoom &&
        isSuccessGetAllRoom == other.isSuccessGetAllRoom &&
        isLoadingGetAllRoom == other.isLoadingGetAllRoom &&
        errorGetAllRoom == other.errorGetAllRoom &&
        createRoomModel == other.createRoomModel &&
        userRoomModel == other.userRoomModel &&
        favRoomModel == other.favRoomModel &&
        trendRoomModel == other.trendRoomModel &&
        allRoomModel == other.allRoomModel &&
        search == other.search;
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
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc(0, isSuccess.hashCode), isLoading.hashCode), error.hashCode),
                                                                                isSuccessGetUserRoom.hashCode),
                                                                            isLoadingGetUserRoom.hashCode),
                                                                        errorGetUserRoom.hashCode),
                                                                    selectedFilter.hashCode),
                                                                isSuccessGetFavRoom.hashCode),
                                                            isLoadingGetFavRoom.hashCode),
                                                        errorGetFavRoom.hashCode),
                                                    isSuccessGetTrendRoom.hashCode),
                                                isLoadingGetTrendRoom.hashCode),
                                            errorGetTrendRoom.hashCode),
                                        isSuccessGetAllRoom.hashCode),
                                    isLoadingGetAllRoom.hashCode),
                                errorGetAllRoom.hashCode),
                            createRoomModel.hashCode),
                        userRoomModel.hashCode),
                    favRoomModel.hashCode),
                trendRoomModel.hashCode),
            allRoomModel.hashCode),
        search.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RoomState')
          ..add('isSuccess', isSuccess)
          ..add('isLoading', isLoading)
          ..add('error', error)
          ..add('isSuccessGetUserRoom', isSuccessGetUserRoom)
          ..add('isLoadingGetUserRoom', isLoadingGetUserRoom)
          ..add('errorGetUserRoom', errorGetUserRoom)
          ..add('selectedFilter', selectedFilter)
          ..add('isSuccessGetFavRoom', isSuccessGetFavRoom)
          ..add('isLoadingGetFavRoom', isLoadingGetFavRoom)
          ..add('errorGetFavRoom', errorGetFavRoom)
          ..add('isSuccessGetTrendRoom', isSuccessGetTrendRoom)
          ..add('isLoadingGetTrendRoom', isLoadingGetTrendRoom)
          ..add('errorGetTrendRoom', errorGetTrendRoom)
          ..add('isSuccessGetAllRoom', isSuccessGetAllRoom)
          ..add('isLoadingGetAllRoom', isLoadingGetAllRoom)
          ..add('errorGetAllRoom', errorGetAllRoom)
          ..add('createRoomModel', createRoomModel)
          ..add('userRoomModel', userRoomModel)
          ..add('favRoomModel', favRoomModel)
          ..add('trendRoomModel', trendRoomModel)
          ..add('allRoomModel', allRoomModel)
          ..add('search', search))
        .toString();
  }
}

class RoomStateBuilder implements Builder<RoomState, RoomStateBuilder> {
  _$RoomState? _$v;

  bool? _isSuccess;
  bool? get isSuccess => _$this._isSuccess;
  set isSuccess(bool? isSuccess) => _$this._isSuccess = isSuccess;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  bool? _isSuccessGetUserRoom;
  bool? get isSuccessGetUserRoom => _$this._isSuccessGetUserRoom;
  set isSuccessGetUserRoom(bool? isSuccessGetUserRoom) =>
      _$this._isSuccessGetUserRoom = isSuccessGetUserRoom;

  bool? _isLoadingGetUserRoom;
  bool? get isLoadingGetUserRoom => _$this._isLoadingGetUserRoom;
  set isLoadingGetUserRoom(bool? isLoadingGetUserRoom) =>
      _$this._isLoadingGetUserRoom = isLoadingGetUserRoom;

  String? _errorGetUserRoom;
  String? get errorGetUserRoom => _$this._errorGetUserRoom;
  set errorGetUserRoom(String? errorGetUserRoom) =>
      _$this._errorGetUserRoom = errorGetUserRoom;

  int? _selectedFilter;
  int? get selectedFilter => _$this._selectedFilter;
  set selectedFilter(int? selectedFilter) =>
      _$this._selectedFilter = selectedFilter;

  bool? _isSuccessGetFavRoom;
  bool? get isSuccessGetFavRoom => _$this._isSuccessGetFavRoom;
  set isSuccessGetFavRoom(bool? isSuccessGetFavRoom) =>
      _$this._isSuccessGetFavRoom = isSuccessGetFavRoom;

  bool? _isLoadingGetFavRoom;
  bool? get isLoadingGetFavRoom => _$this._isLoadingGetFavRoom;
  set isLoadingGetFavRoom(bool? isLoadingGetFavRoom) =>
      _$this._isLoadingGetFavRoom = isLoadingGetFavRoom;

  String? _errorGetFavRoom;
  String? get errorGetFavRoom => _$this._errorGetFavRoom;
  set errorGetFavRoom(String? errorGetFavRoom) =>
      _$this._errorGetFavRoom = errorGetFavRoom;

  bool? _isSuccessGetTrendRoom;
  bool? get isSuccessGetTrendRoom => _$this._isSuccessGetTrendRoom;
  set isSuccessGetTrendRoom(bool? isSuccessGetTrendRoom) =>
      _$this._isSuccessGetTrendRoom = isSuccessGetTrendRoom;

  bool? _isLoadingGetTrendRoom;
  bool? get isLoadingGetTrendRoom => _$this._isLoadingGetTrendRoom;
  set isLoadingGetTrendRoom(bool? isLoadingGetTrendRoom) =>
      _$this._isLoadingGetTrendRoom = isLoadingGetTrendRoom;

  String? _errorGetTrendRoom;
  String? get errorGetTrendRoom => _$this._errorGetTrendRoom;
  set errorGetTrendRoom(String? errorGetTrendRoom) =>
      _$this._errorGetTrendRoom = errorGetTrendRoom;

  bool? _isSuccessGetAllRoom;
  bool? get isSuccessGetAllRoom => _$this._isSuccessGetAllRoom;
  set isSuccessGetAllRoom(bool? isSuccessGetAllRoom) =>
      _$this._isSuccessGetAllRoom = isSuccessGetAllRoom;

  bool? _isLoadingGetAllRoom;
  bool? get isLoadingGetAllRoom => _$this._isLoadingGetAllRoom;
  set isLoadingGetAllRoom(bool? isLoadingGetAllRoom) =>
      _$this._isLoadingGetAllRoom = isLoadingGetAllRoom;

  String? _errorGetAllRoom;
  String? get errorGetAllRoom => _$this._errorGetAllRoom;
  set errorGetAllRoom(String? errorGetAllRoom) =>
      _$this._errorGetAllRoom = errorGetAllRoom;

  CreateRoomModel? _createRoomModel;
  CreateRoomModel? get createRoomModel => _$this._createRoomModel;
  set createRoomModel(CreateRoomModel? createRoomModel) =>
      _$this._createRoomModel = createRoomModel;

  UserRoomModel? _userRoomModel;
  UserRoomModel? get userRoomModel => _$this._userRoomModel;
  set userRoomModel(UserRoomModel? userRoomModel) =>
      _$this._userRoomModel = userRoomModel;

  FavRoomModel? _favRoomModel;
  FavRoomModel? get favRoomModel => _$this._favRoomModel;
  set favRoomModel(FavRoomModel? favRoomModel) =>
      _$this._favRoomModel = favRoomModel;

  TrendRoomModel? _trendRoomModel;
  TrendRoomModel? get trendRoomModel => _$this._trendRoomModel;
  set trendRoomModel(TrendRoomModel? trendRoomModel) =>
      _$this._trendRoomModel = trendRoomModel;

  AllRoomModel? _allRoomModel;
  AllRoomModel? get allRoomModel => _$this._allRoomModel;
  set allRoomModel(AllRoomModel? allRoomModel) =>
      _$this._allRoomModel = allRoomModel;

  String? _search;
  String? get search => _$this._search;
  set search(String? search) => _$this._search = search;

  RoomStateBuilder();

  RoomStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isSuccess = $v.isSuccess;
      _isLoading = $v.isLoading;
      _error = $v.error;
      _isSuccessGetUserRoom = $v.isSuccessGetUserRoom;
      _isLoadingGetUserRoom = $v.isLoadingGetUserRoom;
      _errorGetUserRoom = $v.errorGetUserRoom;
      _selectedFilter = $v.selectedFilter;
      _isSuccessGetFavRoom = $v.isSuccessGetFavRoom;
      _isLoadingGetFavRoom = $v.isLoadingGetFavRoom;
      _errorGetFavRoom = $v.errorGetFavRoom;
      _isSuccessGetTrendRoom = $v.isSuccessGetTrendRoom;
      _isLoadingGetTrendRoom = $v.isLoadingGetTrendRoom;
      _errorGetTrendRoom = $v.errorGetTrendRoom;
      _isSuccessGetAllRoom = $v.isSuccessGetAllRoom;
      _isLoadingGetAllRoom = $v.isLoadingGetAllRoom;
      _errorGetAllRoom = $v.errorGetAllRoom;
      _createRoomModel = $v.createRoomModel;
      _userRoomModel = $v.userRoomModel;
      _favRoomModel = $v.favRoomModel;
      _trendRoomModel = $v.trendRoomModel;
      _allRoomModel = $v.allRoomModel;
      _search = $v.search;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RoomState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RoomState;
  }

  @override
  void update(void Function(RoomStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RoomState build() {
    final _$result = _$v ??
        new _$RoomState._(
            isSuccess: isSuccess,
            isLoading: isLoading,
            error: BuiltValueNullFieldError.checkNotNull(
                error, 'RoomState', 'error'),
            isSuccessGetUserRoom: isSuccessGetUserRoom,
            isLoadingGetUserRoom: isLoadingGetUserRoom,
            errorGetUserRoom: BuiltValueNullFieldError.checkNotNull(
                errorGetUserRoom, 'RoomState', 'errorGetUserRoom'),
            selectedFilter: BuiltValueNullFieldError.checkNotNull(
                selectedFilter, 'RoomState', 'selectedFilter'),
            isSuccessGetFavRoom: isSuccessGetFavRoom,
            isLoadingGetFavRoom: isLoadingGetFavRoom,
            errorGetFavRoom: BuiltValueNullFieldError.checkNotNull(
                errorGetFavRoom, 'RoomState', 'errorGetFavRoom'),
            isSuccessGetTrendRoom: isSuccessGetTrendRoom,
            isLoadingGetTrendRoom: isLoadingGetTrendRoom,
            errorGetTrendRoom: BuiltValueNullFieldError.checkNotNull(
                errorGetTrendRoom, 'RoomState', 'errorGetTrendRoom'),
            isSuccessGetAllRoom: isSuccessGetAllRoom,
            isLoadingGetAllRoom: isLoadingGetAllRoom,
            errorGetAllRoom: BuiltValueNullFieldError.checkNotNull(
                errorGetAllRoom, 'RoomState', 'errorGetAllRoom'),
            createRoomModel: BuiltValueNullFieldError.checkNotNull(
                createRoomModel, 'RoomState', 'createRoomModel'),
            userRoomModel: BuiltValueNullFieldError.checkNotNull(
                userRoomModel, 'RoomState', 'userRoomModel'),
            favRoomModel:
                BuiltValueNullFieldError.checkNotNull(favRoomModel, 'RoomState', 'favRoomModel'),
            trendRoomModel: BuiltValueNullFieldError.checkNotNull(trendRoomModel, 'RoomState', 'trendRoomModel'),
            allRoomModel: BuiltValueNullFieldError.checkNotNull(allRoomModel, 'RoomState', 'allRoomModel'),
            search: BuiltValueNullFieldError.checkNotNull(search, 'RoomState', 'search'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
