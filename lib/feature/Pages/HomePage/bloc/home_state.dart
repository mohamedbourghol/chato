import 'package:built_value/built_value.dart';
import '../model/addStatus/add_status_model.dart';
import '../model/allFriend/all_friend_model.dart';
import '../model/friendship/friendship_requests_model.dart';
import '../model/getStatus/get_status_model.dart';
import '../model/search_friend/search_friend_model.dart';




part 'home_state.g.dart';


abstract class HomeState implements Built<HomeState, HomeStateBuilder> {

  bool? get isSuccess;
  bool? get isLoading;
  bool? get isSuccessGetAllFriend;
  bool? get isLoadingGetAllFriend;
  bool? get isSuccessSearch;
  bool? get isLoadingSearch;
  String get error;
  int get selectedPage;
  FriendshipRequestsModel get friendshipRequestsModel;
  SearchFriendModel get searchFriendModel;
  AllFriendModel get allFriendModel;
  AddStatusModel get addStatusModel;
  GetStatusModel get getStatusModel;
  List<int> get seenStatus;

  HomeState._();

  factory HomeState([void Function(HomeStateBuilder) updates]) =
  _$HomeState;

  factory HomeState.initial() {
    return HomeState((b) => b
      ..isLoading = false
      ..isSuccess = false
      ..isLoadingSearch = false
      ..isSuccessSearch  = false
      ..isSuccessGetAllFriend=false
      ..isLoadingGetAllFriend=false
      ..seenStatus=[]
      ..addStatusModel=AddStatusModel(message: '',
         error_code: 0,
        status: false
      )
        ..selectedPage=0
        ..error=''
        ..searchFriendModel=SearchFriendModel(status: false,
         data: [],
        message: '',
        error_code: 0
      )
      ..allFriendModel=AllFriendModel(
        data: [],
        error_code: 0,
        message: '',
        status: false
      )
        ..friendshipRequestsModel= FriendshipRequestsModel(
          status: false,
          error_code: 0,
          message: '',
          data: []
        )
        ..getStatusModel =GetStatusModel(error_code: 0,status: false,
        data: [],message: ''
        )
    );
  }
}


