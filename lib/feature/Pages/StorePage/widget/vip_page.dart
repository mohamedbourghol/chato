import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../Globals.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../BuyFeaturedUser/buy_featured_user.dart';
import '../bloc/store_bloc.dart';



  class VipPage extends StatefulWidget {
    final List<ProductDetails> products;
    final InAppPurchase inAppPurchase;
    final StoreBloc bloc;
  const VipPage({Key? key,
    required this.products,
    required this.inAppPurchase,
    required this.bloc

  }) : super(key: key);

  @override
  _VipPageState createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> with AutomaticKeepAliveClientMixin{

    int daysLeft=0;

    @override
  void initState() {
      if(Global.endVip!.compareTo(DateTime.now())!=-1){

        Duration duration=Global.endVip!.difference(DateTime.now());
        print('*');
        daysLeft=duration.inDays;
        print('*');
      }
    super.initState();
  }



    @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: const BouncingScrollPhysics(),
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
                child:daysLeft>0? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Featured User',
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
                        Text(daysLeft.toString()+tr('days left'),
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
                ):const SizedBox(),
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
          height: 60.h,
        ),

        Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 35.w
          ),
          child: Row(

            children: [
              for(var prod in widget.products)
                if(prod.id=='vip_2')
              Expanded(
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                      BuyFeaturedUserScreen(
                        id: 2,
                        prod:prod ,
                        featuresNumber: 5,
                        inAppPurchase: widget.inAppPurchase,
                        storeBloc: widget.bloc,
                      )),
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/Knight.png',
                        width: 50.w,
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
                      ).tr(),
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
                ),
              ),
              for(var prod in widget.products)
                if(prod.id=='vip_1')
              Expanded(
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                       BuyFeaturedUserScreen(
                        id: 1,
                         prod:prod ,
                        featuresNumber: 4,
                         inAppPurchase: widget.inAppPurchase,
                         storeBloc: widget.bloc,
                      )),
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/Warrior.png',
                        width: 50.w,
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
                      ).tr(),
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
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60.h,
        ),
        Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: 35.w
          ),
          child: Row(

            children: [
              for(var prod in widget.products)
                if(prod.id=='vip_4')
              Expanded(
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                       BuyFeaturedUserScreen(
                        id: 5,
                         prod:prod ,
                        featuresNumber: 7,
                         inAppPurchase: widget.inAppPurchase,
                         storeBloc: widget.bloc,
                      )),
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/king.png',
                        width: 50.w,
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
                      ).tr(),
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
                ),
              ),
              for(var prod in widget.products)
                if(prod.id=='vip_3')
              Expanded(
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                       BuyFeaturedUserScreen(
                        id: 3,
                         prod:prod ,
                        featuresNumber: 6,
                         inAppPurchase: widget.inAppPurchase,
                         storeBloc: widget.bloc,
                      )),
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/minister.png',
                        width: 50.w,
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
                      ).tr(),
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
