import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/feature/Pages/ProfilePage/widget/acount_settings.dart';
import 'package:chato/feature/Pages/ProfilePage/widget/send_coins_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../core/utils/color_manager.dart';
import '../../autho/login/login_screen.dart';
import '../../autho/register/register_amazing_account_screen.dart';
import 'bloc/prof_bloc.dart';
import 'bloc/prof_state.dart';


class ProfileScreen extends StatefulWidget {
 final ProfBloc bloc;
   const ProfileScreen({Key? key, required this.bloc})
       : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
   // widget.bloc.onGetProfileDetailsEvent();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ProfBloc, ProfState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state.isSuccessLogout!) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state.isLoadingLogout!,
          child: GestureDetector(
            onTap: (){},
            child: Scaffold(
              body: SingleChildScrollView(
                child:state.isLoading!?SizedBox(
                  height: 1.sh,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ): Column(
                  children: [
                    //Image Profile
                    Container(
                      width: 1.sw,
                      height: 230.h,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor,
                          ])),
                      child: CachedNetworkImage(
                        imageUrl:
                            state.profileModel!.data!.img??
                            "https://www.room.tecknick.net/WI.jpeg",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
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
                    ),
                    //details
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${state.profileModel!.data!.name}',
                                style: TextStyle(
                                    fontSize: 23.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context).primaryColorDark),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          children: [
                            Text(
                              'ID: ${state.profileModel!.data!.id}',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).disabledColor),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            InkWell(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text:
                                  state.profileModel!.data!.id.toString()));
                                  Fluttertoast.showToast(
                                      msg: "Copy Done".tr(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ColorManager.primaryColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/copy.svg',
                                  width: 26.w,
                                )),
                          ],
                        )),
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                          (context) =>
                                      const RegisterAmazingAccountScreen(),
                                      )
                                  );
                                  // widget.bloc.onLogoutEvent();
                                },
                                child: Container(
                                  height: 80.h,
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFAFAFA),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/amazing_account.svg',
                                        width: 26.w,
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        'Create Amazing Account',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            color:
                                            ColorManager.darkPrimary),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ).tr(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15.w,),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                      (context) =>
                                      AccountSettingsScreen(
                                        bloc: widget.bloc,
                                      ),
                                      ));
                                },
                                child: Container(
                                  height: 80.h,
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFAFAFA),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/setting.svg',
                                        width: 26.w,
                                        color: ColorManager.primaryColor,
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        'Settings',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorManager.darkPrimary),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ).tr(),
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
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  widget.bloc.onUpdateUserInfoEvent(
                                      online: "0"
                                  );
                                  widget.bloc.onLogoutEvent();
                                },
                                child: Container(
                                  height: 80.h,
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFAFAFA),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/log_out.svg',
                                        width: 26.w,
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        'Log out',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            color:
                                            ColorManager.darkPrimary),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ).tr(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox (width: 15.w,),
                            if(state.profileModel!.data!.type !='normal')
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (context) => SendCoinsScreen(
                                    bloc: widget.bloc,
                                  ),
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFAFAFA),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  height: 80.h,
                                  width: 160.w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/send_gift.svg',
                                        width: 26.w,
                                        color: ColorManager.primaryColor,
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        'Send Coins',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorManager.darkPrimary),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ).tr(),
                                    ],
                                  ),
                                ),
                              ),
                            )else const Expanded(child:  SizedBox())

                          ],
                        )),
                    SizedBox(
                      height: 125.h,
                    ),
                  ],
                ),
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
