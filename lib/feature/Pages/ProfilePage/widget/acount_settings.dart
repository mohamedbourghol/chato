import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/Globals.dart';
import 'package:chato/Preference.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/feature/Pages/ProfilePage/bloc/prof_state.dart';
import 'package:chato/feature/Pages/ProfilePage/widget/show_blocked_user_bottom_sheet.dart';
import 'package:chato/feature/Pages/ProfilePage/widget/show_countries_bottom_sheet.dart';
import 'package:chato/feature/Pages/ProfilePage/widget/show_gender_bottom_sheet.dart';
import 'package:chato/feature/Pages/ProfilePage/widget/show_menu_bottom_sheet_edit_status.dart';
import 'package:chato/feature/Pages/ProfilePage/widget/show_menu_bottom_sheet_email_one.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../main.dart';
import '../bloc/prof_bloc.dart';
import 'change_password_bottom_sheet.dart';
import 'dart:io';

import 'crop_page.dart';
import 'my_status_page.dart';



class AccountSettingsScreen extends StatefulWidget {
  final ProfBloc bloc;
  const AccountSettingsScreen({Key? key,required this.bloc}) : super(key: key);

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool hideState = false;
  bool lockState = false;
  TextEditingController pinCode = TextEditingController();
  final formatDate =  DateFormat('yyyy-MM-dd', 'en'
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfBloc,ProfState>(
      bloc: widget.bloc,
      listener: (context, state) {

      },
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          state.img!=null?
                          Container(
                            height: 86.w,
                            width: 86.w,
                            decoration: BoxDecoration(shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(state.img!),
                                fit: BoxFit.fill
                              )


                            ),
                          ):
                          CachedNetworkImage(
                            imageUrl:
                            state.profileModel!.data!.img??
                                "https://www.room.tecknick.net/WI.jpeg",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 86.w,
                              width: 86.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                          if(Global.vipId!>0)
                          Image.asset(
                              Global.vipId==1?
                              'assets/images/solider_frame.png':
                              Global.vipId==2?
                                  'assets/images/knight_frame.png':
                              Global.vipId==3?
                                  'assets/images/minister_frame.png':
                              'assets/images/king_frame.png',
                            fit: BoxFit.fill,
                            height: Global.vipId==1?106.w:Global.vipId==3?147.w: 126.w,
                            width: Global.vipId==1?106.w:Global.vipId==3?147.w: 126.w,
                          ),
                          Positioned(
                            left:Global.vipId!>0?Global.vipId==3?26: 8:4,
                            bottom:Global.vipId!>0?Global.vipId==3?26:8:2,
                            child: InkWell(
                              onTap: ()  async{
                               await Navigator.push(context, MaterialPageRoute(builder:
                                (context) =>  CropPage(title: 'Select Image'.tr(),),
                                )).then((value) {
                                 print('aasdf000');
                                  if(value!=null)
                                    {
                                      print('aasdf000');

                                           File file = File(value.path!);
                                            widget.bloc.onUpdateUserInfoEvent
                                              (image: file);
                                      widget.bloc.onGetProfileDetailsEvent
                                        ();


                                    }
                                });
                             //   FilePickerResult? result = await
                             //   FilePicker.platform.pickFiles(
                             //     type: FileType.image,
                             //   );

                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: ColorManager.primaryColor,
                                    shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding:  const EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 16.w,
                                    color: ColorManager.backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        state.profileModel!.data!.name!,
                        style: getMediumStyle(
                            fontSize: 16.sp,
                            color: Global.darkMode
                                ? ColorManager.backgroundColor
                                : ColorManager.textColor
                        ),
                      ),
                      Text(
                        state.profileModel!.data!.status!,
                        style:
                        getMediumStyle(color: ColorManager.hintText, fontSize: 13.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => MyStatusPage(
                                profBloc: widget.bloc,
                              ),));
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorManager.backGroundIcon,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                "assets/icons/1_state.svg",
                                height: 25.h,
                                width: 25.w,
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "State".tr(),
                              style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: Global.darkMode
                                      ? ColorManager.backGroundIcon
                                      : ColorManager.textColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: (){
                          showMenuBottomSheetEditStatus(context,
                          state.profileModel!.data!.personal_status??'',
                          widget.bloc
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorManager.backGroundIcon,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                "assets/icons/1_state.svg",
                                height: 25.h,
                                width: 25.w,
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "Status".tr(),
                              style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: Global.darkMode
                                      ? ColorManager.backGroundIcon
                                      : ColorManager.textColor),
                            )
                          ],
                        ),
                      ),
                      if(false)
                      Column(
                        children: [
                          Divider(height: 20.h, thickness: 1, color: ColorManager.hintText),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ColorManager.backGroundIcon,
                                    borderRadius: BorderRadius.circular(10)),
                                child: SvgPicture.asset(
                                  "assets/icons/4_lock.svg",
                                  height: 25.h,
                                  width: 25.w,
                                ),
                                height: 40.h,
                                width: 40.w,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "special lock".tr(),
                                style: getRegularStyle(
                                    fontSize: 14.sp,
                                    color: Global.darkMode
                                        ? ColorManager.backGroundIcon
                                        : ColorManager.textColor),
                              ),
                              const Expanded(child: SizedBox()),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 1,
                                        color: Global.darkMode
                                            ? ColorManager.hintText
                                            : ColorManager.textColor)),
                                child: FlutterSwitch(
                                    toggleColor: ColorManager.primaryColor,
                                    activeColor: ColorManager.backgroundColor,
                                    inactiveColor: ColorManager.backgroundColor,
                                    height: 20.h,
                                    width: 50.w,
                                    toggleSize: 20.h,
                                    padding: 0,
                                    value: lockState,
                                    onToggle: (val) {
                                      setState(() {
                                        lockState = val;
                                      });
                                    }),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ColorManager.backGroundIcon,
                                    borderRadius: BorderRadius.circular(10)),
                                child: SvgPicture.asset(
                                  "assets/icons/6_hideAccount.svg",
                                  height: 25.h,
                                  width: 25.w,
                                ),
                                height: 40.h,
                                width: 40.w,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "hide account".tr(),
                                style: getRegularStyle(
                                    fontSize: 14.sp,
                                    color: Global.darkMode
                                        ? ColorManager.backGroundIcon
                                        : ColorManager.textColor),
                              ),
                              const Expanded(child: SizedBox()),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 1,
                                        color: Global.darkMode
                                            ? ColorManager.hintText
                                            : ColorManager.textColor)),
                                child: FlutterSwitch(
                                    toggleColor: ColorManager.primaryColor,
                                    activeColor: ColorManager.backgroundColor,
                                    inactiveColor: ColorManager.backgroundColor,
                                    height: 20.h,
                                    width: 50.w,
                                    toggleSize: 20.h,
                                    padding: 0,
                                    value: hideState,
                                    onToggle: (val) {
                                      setState(() {
                                        hideState = val;
                                      });
                                    }),
                              )
                            ],
                          ),
                          Divider(height: 20.h, thickness: 1, color: ColorManager.hintText),
                        ],
                      ),

                      Divider(height: 20.h, thickness: 1, color: ColorManager.hintText),
                      InkWell(
                        onTap: () {
                           //showMenuBottomSheetEmailThree(context,pinCode);
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorManager.backGroundIcon,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                "assets/icons/5_mail_account.svg",
                                height: 25.h,
                                width: 25.w,
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            if(
                            state.profileModel!.data!=null
                                &&state.profileModel!.data!.email!.length>4
                            )
                            Text(
                              state.profileModel!.data!.email!.substring(0,4)+'********.com',
                              style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: Global.darkMode
                                      ? ColorManager.backGroundIcon
                                      : ColorManager.textColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      InkWell(
                        onTap: (){
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1970, 3, 5),
                              maxTime: DateTime.now(), onChanged: (date) {
                                print('change $date');

                              }, onConfirm: (date) {
                                 String datetime=formatDate.format(date);
                                 widget.bloc.onUpdateUserInfoEvent(
                                   birthDate: datetime
                                 );
                                print('confirm $date');
                              }, currentTime: DateTime.now(), locale:
                                  Global.lan=='ar'?
                              LocaleType.ar:LocaleType.en);
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorManager.backGroundIcon,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                "assets/icons/2_birthday.svg",
                                height: 25.h,
                                width: 25.w,
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              state.profileModel!.data!.birth_date!=null?
                              state.profileModel!.data!.birth_date!
                                  :'undefined'.tr(),
                              style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: Global.darkMode
                                      ? ColorManager.backGroundIcon
                                      : ColorManager.textColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: (){
                          showCountriesBottomSheet(ctx: context,
                          bloc: widget.bloc
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorManager.backGroundIcon,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                "assets/icons/9_user_location.svg",
                                height: 25.h,
                                width: 25.w,
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              state.profileModel!.data!.country!=null?
                                  Global.lan=='ar'?
                              state.profileModel!.data!.country!.name_ar!:
                                  state.profileModel!.data!.country!.name_en!:
                              'undefined'.tr(),
                              style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: Global.darkMode
                                      ? ColorManager.backGroundIcon
                                      : ColorManager.textColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      InkWell(
                        onTap: (){
                          showMenuBottomSheetGender(context,
                              widget.bloc);

                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorManager.backGroundIcon,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                "assets/icons/7_gender.svg",
                                height: 25.h,
                                width: 25.w,
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              state.profileModel!.data!.gender??
                                  'undefined'.tr(),
                              style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: Global.darkMode
                                      ? ColorManager.backGroundIcon
                                      : ColorManager.textColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Divider(height: 20.h, thickness: 1, color: ColorManager.hintText),
                      InkWell(
                        onTap: (){
                          showBottomSheetPassword(
                            context,
                            widget.bloc
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorManager.backGroundIcon,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                "assets/icons/3_key.svg",
                                height: 25.h,
                                width: 25.w,
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "change password".tr(),
                              style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: Global.darkMode
                                      ? ColorManager.backGroundIcon
                                      : ColorManager.textColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: (){
                          showBlockedUserBottomSheet(
                              ctx: context,
                              bloc: widget.bloc);
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorManager.backGroundIcon,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                "assets/icons/8_banned_acount.svg",
                                height: 25.h,
                                width: 25.w,
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "Banned accounts".tr(),
                              style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: Global.darkMode
                                      ? ColorManager.backGroundIcon
                                      : ColorManager.textColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: (){
                          Global.darkMode=!Global.darkMode;
                          Preferences.saveDarkMode(Global.darkMode);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MyApp(),
                            ),
                                (route) => false,
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorManager.backGroundIcon,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                "assets/icons/dark_mode_icon.svg",
                                height: 25.h,
                                width: 25.w,
                                color: ColorManager.primaryColor,
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "dark Mode".tr(),
                              style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: Global.darkMode
                                      ? ColorManager.backGroundIcon
                                      : ColorManager.textColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: ()async{
                          if( EasyLocalization.of(context)!.currentLocale!
                              ==const Locale('ar','AR'))
                          {
                            Preferences.saveLan('en');
                            await EasyLocalization.of(context)!.
                            setLocale(const Locale('en', 'US'));
                            context.setLocale(const Locale('en', 'US'));
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                const MyApp(),
                              ),
                                  (route) => false,
                            );

                          }
                          else{
                            Preferences.saveLan('ar');
                            await EasyLocalization.of(context)!.
                            setLocale(const Locale('ar', 'AR'));
                            context.setLocale(const Locale('ar', 'AR'));
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                const MyApp(),
                              ),
                                  (route) => false,
                            );

                          }
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorManager.backGroundIcon,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                "assets/icons/language_icon.svg",
                                height: 25.h,
                                width: 25.w,
                                color: ColorManager.primaryColor,
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "Change Language".tr(),
                              style: getRegularStyle(
                                  fontSize: 14.sp,
                                  color: Global.darkMode
                                      ? ColorManager.backGroundIcon
                                      : ColorManager.textColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                    ],
                  ),
                ),
              ),
            ));
      },

    );
  }
}
