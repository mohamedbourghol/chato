import 'package:bloc/bloc.dart';
import 'package:chato/feature/BuyFeaturedUser/model/vip_data_model.dart';
import '../../../../Globals.dart';
import '../../../../Preference.dart';
import '../../../BuyFeaturedUser/api/vip_accounts_transactions_remote.dart';
import '../../../BuyFeaturedUser/model/vip_model.dart';
import '../api/update_coins_remote.dart';
import '../model/update_coins_model.dart';
import 'store_event.dart';
import 'store_state.dart';


 class StoreBloc extends Bloc<StoreEvent, StoreState> {
  UpdateCoinsRemoteDataSource updateCoinsRemoteDataSource;
  VipAccountsTransactionsRemoteDataSource vipAccountsTransactionsRemoteDataSource;
  StoreBloc({
   required this.updateCoinsRemoteDataSource,
   required this.vipAccountsTransactionsRemoteDataSource,
   }) : super(StoreState.initial())
  {
    on<ChangePageEvent>((event, emit) =>
        emit(state.rebuild((b) => b
      ..selectedPage=event.pageNumber
     )
    ));


    on<ChangeProductEvent>((event, emit) =>
        emit(state.rebuild((b) => b
          ..quantity=event.quantity
            ..type=event.type
        )
        ));

    on<UpdateCoinsEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isSuccess = false
        ..isLoading = true
        ..updateCoinsModel=UpdateCoinsModel(message: '',
            error_code: 0,status: false
        )
      ));
      final result = await updateCoinsRemoteDataSource.updateCoins(
        quantity: state.quantity,
        type: state.type
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess = false
          ..isLoading = false
        ));
      }, (r) async {
        print('r');
        if(state.type=='coins')
          {
            Global.userCoins=(double.parse(Global.userCoins!)+
                double.parse(state.quantity)).toString();
            Preferences.saveUserCoins(Global.userCoins??'0');
          }
        else{
          Global.userDiamond=(double.parse(Global.userDiamond!)+
              double.parse(state.quantity)).toString();
          Preferences.saveUserDiamond(Global.userDiamond??'0');

        }
        emit(state.rebuild((b) => b
          ..isSuccess = true
          ..isLoading = false
          ..updateCoinsModel = r
        ));
        emit(state.rebuild((b) => b
          ..isSuccess = true
          ..isLoading = false
          ..updateCoinsModel = UpdateCoinsModel(message: '',
              error_code: 0,status: false
          )
        ));

      });

    });

    on<VipAccountsTransactionsEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isSuccess = false
        ..isLoading = true
        ..vipModel=VipModel(message: '',
            error_code: 0,status: false,
            data: VipDataModel(
                start_date: null,
                end_date: null,
                price: '',
                vip_id: 0,
              account_vip: null
            )
        )
      ));
      final result = await vipAccountsTransactionsRemoteDataSource
          .vipAccountsTransactions(
          vipId: event.vipId,
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess = false
          ..isLoading = false
        ));
      }, (r) async {
        print('r');
        if(r.data!=null)
        {
          Global.vipId=r.data!.vip_id;
          Global.endVip=r.data!.end_date;
          Preferences.saveVipDate(r.data!.end_date!);
          Preferences.saveUserVipId(r.data!.vip_id!);
        }
        emit(state.rebuild((b) => b
          ..isSuccess = true
          ..isLoading = false
          ..vipModel = r
        ));
        emit(state.rebuild((b) => b
          ..vipModel = VipModel(message: '',
              error_code: 0,status: false,
               data: VipDataModel(vip_id: 0,
                price: '',
                end_date: null,
                start_date:  null,
                 account_vip: null
            ),
          )
        ));

      });

    });


  }

  void onChangePageEvent(int pageNumber) {
    add(ChangePageEvent(pageNumber));
  }

  void onUpdateCoinsEvent() {
    add(UpdateCoinsEvent());
  }
  void onChangeProductEvent(String type,String quantity) {
    add(ChangeProductEvent(type: type,quantity: quantity));
  }
  void onVipAccountsTransactionsEvent
      ({required int vipId}) {
    add(VipAccountsTransactionsEvent
      (vipId: vipId));
  }

}