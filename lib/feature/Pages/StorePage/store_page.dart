
import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chato/feature/Pages/StorePage/bloc/store_bloc.dart';
import 'package:chato/feature/Pages/StorePage/bloc/store_state.dart';
import 'package:chato/feature/Pages/StorePage/widget/coins_page.dart';
import 'package:chato/feature/Pages/StorePage/widget/diamonds_page.dart';
import 'package:chato/feature/Pages/StorePage/widget/vip_page.dart';
import 'package:chato/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import '../../../core/utils/color_manager.dart';




const List<String> _kProductIds = <String>[
  '1',
  'coins_1',
  '2_coins',
  'coins_3',
  'coins_4',
  '5_coins',
  '6_coins',
  '1_diamonds',
  '2_diamonds',
  '3_diamonds',
  '4_diamonds',
  '5_diamonds',
  '6_diamonds',
  'vip_1',
  'vip_2',
  'vip_3',
  'vip_4'
];

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> with AutomaticKeepAliveClientMixin{


  StoreBloc storeBloc=sl<StoreBloc>();
  PageController pageController=PageController(
    initialPage: 0,
     keepPage: true,
  );

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;
  Map<String, PurchaseDetails> purchases = {};
  late DateTime dateTime;

  @override
  void initState() {
    //storeBloc.onChangeProductEvent('diamond','221500');
    //storeBloc.onUpdateCoinsEvent();
    purchases =  Map<String, PurchaseDetails>.fromEntries(
        _purchases.map((PurchaseDetails purchase) {
          if (purchase.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchase);
          }
          return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
        }));
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((List<PurchaseDetails>
        purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
        }, onError: (Object error) {

        });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();

    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;

        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;

        _purchasePending = false;
        _loading = false;
      });
      return;
    }


    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;

      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {

    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      }
      else {



        if(purchaseDetails.status == PurchaseStatus.purchased)
        {
          if(purchaseDetails.productID=='vip_1')
            {
              storeBloc.onVipAccountsTransactionsEvent(vipId: 1);
            }
          else if(purchaseDetails.productID=='vip_2')
          {
            storeBloc.onVipAccountsTransactionsEvent(vipId: 2);
          }
          else if(purchaseDetails.productID=='vip_3')
          {
            storeBloc.onVipAccountsTransactionsEvent(vipId: 3);
          }
          else if(purchaseDetails.productID=='vip_4')
          {
            storeBloc.onVipAccountsTransactionsEvent(vipId: 4);
          }
          else{
            storeBloc.onUpdateCoinsEvent();
          }

          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.WARNING,
            body: const Center(child: Text(
              'نم شراءه',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),),

            btnOkText: 'تم',
            btnOkColor: ColorManager.primaryColor,


            btnOkOnPress: () {},

          ).show();
        }


      }
    }
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final BillingResultWrapper priceChangeConfirmationResult =
      await androidAddition.launchPriceChangeConfirmationFlow(
        sku: 'purchaseId',
      );
      if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Price change accepted'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            priceChangeConfirmationResult.debugMessage ??
                'Price change failed with code ${priceChangeConfirmationResult.responseCode}',
          ),
        ));
      }
    }
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition
      iapStoreKitPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }




  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<StoreBloc,StoreState>(
      bloc: storeBloc,
      listener: (context, state) {
        if(state.updateCoinsModel.message!.isNotEmpty)
        {
          Fluttertoast.showToast(
              msg: state.updateCoinsModel.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0.sp
          );
        }
      },
      builder:(context, state) {
       return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: 1.sh,
              child: Column(
                children: [
                  //appBar
                  SizedBox(
                    width: 1.sw,

                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 24.h
                      ),
                      child:   Row(
                        children: [
                          SvgPicture.asset('assets/icons/store2.svg',
                            width: 24.w,
                            color: ColorManager.primaryColor,
                          ),
                          SizedBox(width: 12.w,),
                          Expanded(child:
                           Text('Store',
                            style: TextStyle(
                                color: ColorManager.primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 19.sp,
                            ),
                          ).tr(),),


                        ],
                      ),
                    ),



                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 0.8.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.w),
                        border: Border.all(
                            color: const Color(0xffD6D6D6)
                        )
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(

                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                if(state.selectedPage!=0)
                                  {
                                    storeBloc.onChangePageEvent(0);
                                    pageController.jumpToPage(0);
                                  }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.w),
                                    color:state.selectedPage==0? ColorManager.primaryColor:
                                    Colors.transparent
                                ),

                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                    vertical: 7.h,

                                  ),
                                  child: Text('Coins',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'DIN',
                                        fontWeight: FontWeight.w500,
                                        color:state.selectedPage==0?
                                        ColorManager.backgroundColor:
                                        Theme.of(context).disabledColor
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ).tr(),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                if(state.selectedPage!=1)
                                {
                                  storeBloc.onChangePageEvent(1);
                                  pageController.jumpToPage(1);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.w),
                                    color:state.selectedPage==1? ColorManager.primaryColor:
                                    Colors.transparent
                                ),

                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                    vertical: 7.h,

                                  ),
                                  child: Text('Diamonds',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'DIN',
                                        fontWeight: FontWeight.w500,
                                        color:state.selectedPage==1?
                                        ColorManager.backgroundColor:
                                        Theme.of(context).disabledColor
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ).tr(),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                if(state.selectedPage!=2)
                                {
                                  storeBloc.onChangePageEvent(2);
                                  pageController.jumpToPage(2);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.w),
                                    color:state.selectedPage==2? ColorManager.primaryColor:
                                        Colors.transparent
                                ),

                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                    vertical: 7.h,

                                  ),
                                  child: Text('VIP',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'DIN',
                                        fontWeight: FontWeight.w500,
                                        color:state.selectedPage==2? ColorManager.backgroundColor:
                                        Theme.of(context).disabledColor
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ).tr(),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),


                  //رصيد
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children:  [

                        CoinsPage(
                          products: _products,
                          inAppPurchase: _inAppPurchase,
                          bloc: storeBloc,
                        ),

                        DiamondsPage(
                          products: _products,
                          bloc: storeBloc,
                          inAppPurchase: _inAppPurchase,
                        ),

                        VipPage(
                          products: _products,
                          bloc: storeBloc,
                          inAppPurchase: _inAppPurchase,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 95.h,
                  ),

                ],
              ),
            ),
          ),

        );
      },

    );
  }

  @override
  bool get wantKeepAlive => true;
}
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {

  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront)
  {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }

}