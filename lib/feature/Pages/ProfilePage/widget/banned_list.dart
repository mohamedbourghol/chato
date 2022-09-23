import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Globals.dart';

class BannedList extends StatefulWidget {
  const BannedList({Key? key}) : super(key: key);

  @override
  _BannedListState createState() => _BannedListState();
}

class _BannedListState extends State<BannedList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text(
                "Banned List".tr(),
                style: getRegularStyle(
                    color: ColorManager.primaryColor, fontSize: 19.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 600.h,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (ctx, idx) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorManager.backGroundIcon,
                                ),
                                child: Image.asset(
                                  "assets/images/alghadab.png",
                                  fit: BoxFit.cover,
                                ),
                                height: 40.h,
                                width: 40.h,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "الصكر".tr(),
                                style: getRegularStyle(
                                    fontSize: 19.sp,
                                    color: Global.darkMode
                                        ? ColorManager.backGroundIcon
                                        : ColorManager.textColor),
                              ),
                              Expanded(child: SizedBox()),
                              InkWell(
                                onTap: (){},
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35.h,
                                  width: 35.h,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle,
                                        color: ColorManager.backGroundIcon
                                      ),
                                  child: SvgPicture.asset("assets/icons/basket.svg",height:20.h ,),

                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                            height: 40.h,
                            thickness: 1,
                            color: ColorManager.hintText),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
