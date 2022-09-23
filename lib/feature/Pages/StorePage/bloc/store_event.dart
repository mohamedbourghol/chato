import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StoreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ChangePageEvent extends StoreEvent{

   int pageNumber;
   ChangePageEvent(this.pageNumber);

}

class UpdateCoinsEvent extends StoreEvent{


}
// ignore: must_be_immutable
class ChangeProductEvent extends StoreEvent{

  String type;
  String quantity;

  ChangeProductEvent({
       required this.type,
       required this.quantity
      });

}

// ignore: must_be_immutable
class VipAccountsTransactionsEvent extends StoreEvent{

  int vipId;


  VipAccountsTransactionsEvent({
    required this.vipId,
  });

}

