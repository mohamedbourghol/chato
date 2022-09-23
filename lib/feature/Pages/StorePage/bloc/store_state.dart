



import 'package:built_value/built_value.dart';
import 'package:chato/feature/BuyFeaturedUser/model/vip_data_model.dart';

import '../../../BuyFeaturedUser/model/vip_model.dart';
import '../model/update_coins_model.dart';



part 'store_state.g.dart';


abstract class StoreState implements Built<StoreState, StoreStateBuilder> {


  bool? get isSuccess;
  bool? get isLoading;
   int get selectedPage;
  UpdateCoinsModel get updateCoinsModel;
  String get type;
  String get quantity;
  VipModel get vipModel;
  StoreState._();

  factory StoreState([void Function(StoreStateBuilder) updates]) = _$StoreState;

  factory StoreState.initial() {
    return StoreState((b) => b
      ..isLoading = false
      ..isSuccess = false
        ..selectedPage = 0
      ..type=''
      ..quantity=''
      ..vipModel=VipModel(
        error_code: 0,
      status: false,
        data: VipDataModel(vip_id: 0,
        price: '',
          end_date: null,
          start_date:  null,
          account_vip: null
        ),
        message: '',
      )
        ..updateCoinsModel=UpdateCoinsModel(
            message: '',
            error_code: 0,
            status: false
        )

    );
  }
}


