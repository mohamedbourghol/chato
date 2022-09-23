import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';


class AddMusic extends StatefulWidget {
  const AddMusic({Key? key}) : super(key: key);

  @override
  _AddMusicState createState() => _AddMusicState();
}

class _AddMusicState extends State<AddMusic> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text(
              "Add Music".tr(),
              style: TextStyle(
                  fontSize: 20.h,
                  color: ColorManager.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(itemBuilder: (ind, ctx) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(
                      children: [
                        Text(
                          "aud_14141",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: Global.darkMode
                                  ? ColorManager.backgroundColor
                                  : ColorManager.textColor),
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {},
                          child: SizedBox(
                            height: 35.h,
                            child: false
                                ? SvgPicture.asset("assets/icons/ok.svg")
                                : SvgPicture.asset("assets/icons/add.svg.svg"),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
                height: 38.h,
                width: 160.w,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Add".tr(),
                    style: TextStyle(
                        fontSize: 16.sp, color: ColorManager.backgroundColor),
                  ),
                )),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    ));
  }
}
