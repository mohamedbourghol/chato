import 'dart:io';

import 'package:chato/feature/Pages/StorePage/bloc/store_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../../../Globals.dart';
import '../../../../core/utils/color_manager.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';




class CoinsPage extends StatefulWidget {
  final InAppPurchase inAppPurchase;
 final List<ProductDetails> products;
  final StoreBloc bloc;
  const CoinsPage(
      {Key? key,
        required this.products,
        required this.inAppPurchase,
        required this.bloc}) : super(key: key);


  @override
  _CoinsPageState createState() => _CoinsPageState();
}

class _CoinsPageState extends State<CoinsPage>
       with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: 12.w
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Current currency balance',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'DIN',
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColorDark
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ).tr(),
                      ],
                    ),
                    Row(
                      children: [
                        Text(Global.userCoins!,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'DIN',
                              fontWeight: FontWeight.w500,
                              color:ColorManager.primaryColor
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 80.h,
                height: 80.h,
                child: Image.asset('assets/images/store.png'),
              ),

            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),

        Expanded(
          child: Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: 12.w
            ),
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const
                SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.42,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                ),
                itemCount: 7,
                itemBuilder: (BuildContext ctx, index) {
                  for(var prod in widget.products)
                    {
                      print(prod.id);
                      if(prod.id=='1'&&index==0) {
                        return InkWell(
                          onTap: () async{
                            widget.bloc.onChangeProductEvent('coins',
                                '50');

                            late PurchaseParam purchaseParam;

                            if (Platform.isAndroid) {
                              purchaseParam = GooglePlayPurchaseParam(
                                  productDetails: prod,
                                  applicationUserName: null,
                                  changeSubscriptionParam: null);

                            }
                            else {
                              purchaseParam = PurchaseParam(
                                productDetails: prod,
                                applicationUserName: null,
                              );
                            }
                            if (Platform.isAndroid) {

                              await widget.inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
                            } else if (Platform.isIOS) {
                              await widget.inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
                            }
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset('assets/icons/coins.svg'),
                              SizedBox(height: 6.h,),
                              Text(prod.description,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: 'DIN',
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColorDark
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 6.h,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.w),
                                  border: Border.all(
                                      color: Theme.of(context).cursorColor
                                  ),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      vertical: 2.h,
                                      horizontal: 28.w
                                  ),
                                  child: Text(prod.price,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'DIN',
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).hintColor
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        );
                      }
                      if(prod.id=='coins_1'&&index==1) {

                        return InkWell(
                          onTap: ()async{
                            widget.bloc.onChangeProductEvent('coins',
                                '1500');

                            late PurchaseParam purchaseParam;

                            if (Platform.isAndroid) {
                              purchaseParam = GooglePlayPurchaseParam(
                                  productDetails: prod,
                                  applicationUserName: null,
                                  changeSubscriptionParam: null);

                            }
                            else {
                              purchaseParam = PurchaseParam(
                                productDetails: prod,
                                applicationUserName: null,
                              );
                            }
                            if (Platform.isAndroid) {

                              await widget.inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
                            } else if (Platform.isIOS) {
                              await widget.inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
                            }
                          },
                          child: Column(
                          children: [
                            SvgPicture.asset('assets/icons/coins.svg'),
                            SizedBox(height: 6.h,),
                            Text(prod.description,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'DIN',
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColorDark
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 6.h,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.w),
                                border: Border.all(
                                    color: Theme.of(context).cursorColor
                                ),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(
                                    vertical: 2.h,
                                    horizontal: 28.w
                                ),
                                child: Text(prod.price,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'DIN',
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).hintColor
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),

                          ],
                      ),
                        );
                      }
                      if(prod.id=='2_coins'&&index==2) {
                        return InkWell(
                          onTap: ()async{
                            widget.bloc.onChangeProductEvent('coins',
                                '12000');

                            late PurchaseParam purchaseParam;

                            if (Platform.isAndroid) {
                              purchaseParam = GooglePlayPurchaseParam(
                                  productDetails: prod,
                                  applicationUserName: null,
                                  changeSubscriptionParam: null);

                            }
                            else {
                              purchaseParam = PurchaseParam(
                                productDetails: prod,
                                applicationUserName: null,
                              );
                            }
                            if (Platform.isAndroid) {

                              await widget.inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
                            } else if (Platform.isIOS) {
                              await widget.inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
                            }
                          },
                          child: Column(
                            children: [
                              Image.asset('assets/icons/coins1.png',

                                height: 60.w,
                                width: 60.w,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(height: 6.h,),
                              Text(prod.description,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: 'DIN',
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColorDark
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 6.h,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.w),
                                  border: Border.all(
                                      color: Theme.of(context).cursorColor
                                  ),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      vertical: 2.h,
                                      horizontal: 28.w
                                  ),
                                  child: Text(prod.price,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'DIN',
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).hintColor
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        );
                      }
                      if(prod.id=='coins_3'&&index==3) {
                        return InkWell(
                          onTap: ()async{
                            widget.bloc.onChangeProductEvent('coins',
                                '20000');

                            late PurchaseParam purchaseParam;

                            if (Platform.isAndroid) {
                              purchaseParam = GooglePlayPurchaseParam(
                                  productDetails: prod,
                                  applicationUserName: null,
                                  changeSubscriptionParam: null);

                            }
                            else {
                              purchaseParam = PurchaseParam(
                                productDetails: prod,
                                applicationUserName: null,
                              );
                            }
                            if (Platform.isAndroid) {

                              await widget.inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
                            } else if (Platform.isIOS) {
                              await widget.inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
                            }
                          },
                          child: Column(
                            children: [
                              Image.asset('assets/icons/coins2.png',

                              height: 60.w,
                                width: 60.w,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(height: 6.h,),
                              Text(prod.description,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: 'DIN',
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColorDark
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 6.h,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.w),
                                  border: Border.all(
                                      color: Theme.of(context).cursorColor
                                  ),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      vertical: 2.h,
                                      horizontal: 28.w
                                  ),
                                  child: Text(prod.price,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'DIN',
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).hintColor
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        );
                      }
                      if(prod.id=='coins_4'&&index==4) {
                        return InkWell(
                          onTap: () async {
                            widget.bloc.onChangeProductEvent('coins',
                                '30000');

                            late PurchaseParam purchaseParam;

                            if (Platform.isAndroid) {
                              purchaseParam = GooglePlayPurchaseParam(
                                  productDetails: prod,
                                  applicationUserName: null,
                                  changeSubscriptionParam: null);

                            }
                            else {
                              purchaseParam = PurchaseParam(
                                productDetails: prod,
                                applicationUserName: null,
                              );
                            }
                            if (Platform.isAndroid) {

                              await widget.inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
                            } else if (Platform.isIOS) {
                              await widget.inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
                            }
                          },
                          child: Column(
                            children: [
                              Image.asset('assets/icons/coins3.png',

                                height: 60.w,
                                width: 60.w,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(height: 6.h,),
                              Text(prod.description,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: 'DIN',
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColorDark
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 6.h,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.w),
                                  border: Border.all(
                                      color: Theme.of(context).cursorColor
                                  ),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      vertical: 2.h,
                                      horizontal: 28.w
                                  ),
                                  child: Text(prod.price,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'DIN',
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).hintColor
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        );
                      }
                      if(prod.id=='5_coins'&&index==5) {
                        return InkWell(
                          onTap: () async {
                            widget.bloc.onChangeProductEvent('coins',
                                '50000');

                            late PurchaseParam purchaseParam;

                            if (Platform.isAndroid) {
                              purchaseParam = GooglePlayPurchaseParam(
                                  productDetails: prod,
                                  applicationUserName: null,
                                  changeSubscriptionParam: null);

                            }
                            else {
                              purchaseParam = PurchaseParam(
                                productDetails: prod,
                                applicationUserName: null,
                              );
                            }
                            if (Platform.isAndroid) {

                              await widget.inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
                            } else if (Platform.isIOS) {
                              await widget.inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
                            }
                          },
                          child: Column(
                            children: [
                              Image.asset('assets/icons/coins4.png',

                                height: 60.w,
                                width: 60.w,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(height: 6.h,),
                              Text(prod.description,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: 'DIN',
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColorDark
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 6.h,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.w),
                                  border: Border.all(
                                      color: Theme.of(context).cursorColor
                                  ),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      vertical: 2.h,
                                      horizontal: 28.w
                                  ),
                                  child: Text(prod.price,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'DIN',
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).hintColor
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        );
                      }
                      if(prod.id=='6_coins'&&index==6) {
                        return InkWell(
                          onTap: () async {
                            widget.bloc.onChangeProductEvent('coins',
                                '100000');

                            late PurchaseParam purchaseParam;

                            if (Platform.isAndroid) {
                              purchaseParam = GooglePlayPurchaseParam(
                                  productDetails: prod,
                                  applicationUserName: null,
                                  changeSubscriptionParam: null);

                            }
                            else {
                              purchaseParam = PurchaseParam(
                                productDetails: prod,
                                applicationUserName: null,
                              );
                            }
                            if (Platform.isAndroid) {

                              await widget.inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
                            }
                            else if (Platform.isIOS) {
                              await widget.inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
                            }
                          },
                          child: Column(
                            children: [
                              Image.asset('assets/icons/coins5.png',

                                height: 60.w,
                                width: 60.w,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(height: 6.h,),
                              Text(prod.description,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: 'DIN',
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColorDark
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 6.h,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.w),
                                  border: Border.all(
                                      color: Theme.of(context).cursorColor
                                  ),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      vertical: 2.h,
                                      horizontal: 28.w
                                  ),
                                  child: Text(prod.price,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'DIN',
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).hintColor
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        );
                      }
                    }
                  return const SizedBox();

                }),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
