import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
         true ? Container(
            height: 0.6.sh,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 25.sp,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.lock,
                          size: 15.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "End-to-end encrypted",
                          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.person_add_alt_1,
                      color: Colors.white,
                      size: 30.sp,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Aghyad",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "0:03",
                      style: TextStyle(color: Colors.grey, fontSize: 20.sp),
                    ),
                  ],
                ),
                Container(
                  height: 200.h,
                  width: 200.h,
                  decoration:
                      const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                )
              ],
            ),
          )
          :Container(
           width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
            child: Container(
              height: 0.28.sh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 120.h,
                    width: 120.h,
                    decoration:
                    BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  ),
                  Text(
                    "Aghyad",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold),
                  ),

                  Text(
                    "calling",
                    style: TextStyle(color: Colors.grey, fontSize: 20.sp),
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                height: 0.2.sh,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/top.svg",
                      color: Colors.grey,
                      height: 40.h,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.h,
                          child: Icon(Icons.call_end,color: Colors.white,size: 30.sp,),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                        ),Container(
                          height: 50.h,
                          width: 50.h,
                          child: Icon(Icons.mic_off,color: Colors.white,size: 35.sp,),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,),
                        ),Container(
                          height: 50.h,
                          width: 50.h,
                          child: Icon(Icons.videocam,color: Colors.white,size: 30.sp,),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, ),
                        ),Container(
                          height: 50.h,
                          width: 50.h,
                          child: Icon(Icons.volume_up,color: Colors.white,size: 30.sp,),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
