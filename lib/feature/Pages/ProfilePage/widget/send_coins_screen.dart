import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../Globals.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../bloc/prof_bloc.dart';
import '../bloc/prof_state.dart';


class SendCoinsScreen extends StatefulWidget {
 final ProfBloc bloc;


   const SendCoinsScreen({Key? key, required this.bloc})
       : super(key: key);

  @override
  State<SendCoinsScreen> createState() => _SendCoinsScreenState();
}

class _SendCoinsScreenState extends State<SendCoinsScreen>
     {
       final _formKey = GlobalKey<FormState>();
       TextEditingController idController = TextEditingController();
       TextEditingController coinsController = TextEditingController();
       List<String> coinsType=[
         'coins','diamond'
       ];
       late String typeSelected;

  @override
  void initState() {
    typeSelected=coinsType[0];
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ProfBloc, ProfState>(
      bloc: widget.bloc,
      listener: (context, state) {
          if(state.isSuccessSendCoins!)
            {
              Fluttertoast.showToast(
                  msg: state.sendCoinsModel.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: ColorManager.primaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              if(state.sendCoinsModel.status!)
                {
                  idController.clear();
                  coinsController.clear();
                }
            }
          else if(state.error!.isNotEmpty){
            Fluttertoast.showToast(
                msg: state.error!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.primaryColor,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }

      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state.isLoadingSendCoins!,
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [

                   


                    SizedBox(
                      height: 15.h,
                    ),

                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).hoverColor,
                                    borderRadius: BorderRadius.circular(15)
                                ),


                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                    vertical: 18.h
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/Gift.png',
                                        width: 80.w,

                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Text(
                                        'Send Coins',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).primaryColorDark),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ).tr(),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Text(
                                        'Enter the recipients id and the amount sent',
                                        style: TextStyle(
                                            fontSize: 14.sp,

                                            color: Theme.of(context).primaryColorDark),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ).tr(),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        )),
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: AppPadding.p16.w,
                          horizontal: AppPadding.p20.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "ID".tr(),
                                  style: TextStyle(
                                      color: Global.darkMode
                                          ? ColorManager.backgroundColor
                                          : ColorManager.textColor,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4.h),
                              height: 45.h,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: TextStyle(
                                    fontSize: FontSize.s16,
                                    color: Global.darkMode
                                        ? ColorManager.backgroundColor
                                        : ColorManager.textColor),
                                controller: idController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: 5.h, bottom: 10.h, right: 5, left: 5),
                                  hintText: "The recipient's unique number".tr(),
                                  hintStyle: TextStyle(
                                    color: ColorManager.hintText,
                                    fontSize: 14.sp,
                                  ),
                                  icon: Icon(
                                    Icons.format_list_numbered_rtl_sharp,
                                    size: 23.w,
                                    color: ColorManager.hintText,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Global.darkMode
                                              ? ColorManager.backgroundColor
                                              : ColorManager.textColor)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorManager.hintText)),
                                  disabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: ColorManager.hintText),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return tr(
                                      'Enter a valid id'.tr(),
                                    );
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Coins".tr(),
                                  style: TextStyle(
                                      color: Global.darkMode
                                          ? ColorManager.backgroundColor
                                          : ColorManager.textColor,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4.h),
                              height: 45.h,
                              child: TextFormField(
                                keyboardType:const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                                ],
                                style: TextStyle(
                                    fontSize: FontSize.s16,
                                    color: Global.darkMode
                                        ? ColorManager.backgroundColor
                                        : ColorManager.textColor),
                                controller: coinsController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: 5.h, bottom: 10.h, right: 5, left: 5),
                                  hintText: "Coins".tr(),
                                  hintStyle: TextStyle(
                                    color: ColorManager.hintText,
                                    fontSize: 14.sp,
                                  ),
                                  icon: Icon(
                                    Icons.money,
                                    size: 18.w,
                                    color: ColorManager.hintText,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Global.darkMode
                                              ? ColorManager.backgroundColor
                                              : ColorManager.textColor)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorManager.hintText)),
                                  disabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: ColorManager.hintText),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return tr('Enter a Coins');
                                  }

                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 0.5.sw,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.w),
                                  border: Border.all(
                                      color:  ColorManager.primaryColor
                                  )
                              ),
                              child: DropdownButton(
                                isExpanded: true,


                                underline: const SizedBox(),

                                value: typeSelected,

                                // Down Arrow Icon
                                icon:   Icon(Icons.arrow_drop_down,
                                  size: 26.w,
                                  color: ColorManager.primaryColor,
                                ),
                                iconSize: 25.w,
                                dropdownColor: Theme.of(context).scaffoldBackgroundColor,

                                // Array list of items
                                items: coinsType.map((String items) {
                                  return DropdownMenuItem(

                                    value: items,
                                    child: Row(

                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if(items=='coins')
                                        SvgPicture.asset('assets/icons/coins.svg',
                                          width: 16.w,


                                        )else
                                          SvgPicture.asset('assets/icons/diamonds.svg',
                                            width: 16.w,


                                          ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(items
                                          , style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Theme.of(context).primaryColorDark,
                                              fontWeight:FontWeight.w300


                                          ),
                                          textAlign: TextAlign.center,
                                        ),


                                      ],
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (newValue) {
                                  typeSelected=newValue.toString();
                                   setState(() {

                                   });


                                },
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            SizedBox(
                                height: 45.h,
                                width: 335.w,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      widget.bloc.onSendCoinsEvent
                                        (typeSelected,
                                          coinsController.text,
                                          idController.text);

                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: const Text('incomplete data')
                                                .tr()),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Send".tr(),
                                    style: getRegularStyle(
                                        color: ColorManager.lightTextColor,
                                        fontSize: 15.sp),
                                  ),
                                )),
                            SizedBox(
                              height: 40.h,
                            )
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}
