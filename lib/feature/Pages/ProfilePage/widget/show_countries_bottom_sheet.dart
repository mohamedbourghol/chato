import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/Globals.dart';
import 'package:chato/feature/Pages/ProfilePage/bloc/prof_state.dart';
import 'package:chato/feature/Pages/ProfilePage/model/country/country_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../bloc/prof_bloc.dart';



Future<String?> showCountriesBottomSheet({
  required BuildContext ctx,
  required ProfBloc bloc,
  }) async {
  CountryModel countries=CountryModel(error_code: 0,
  message: '',
      data: [],
      status: false
  );
  bool first=true;
  TextEditingController textEditingController=TextEditingController();
  bloc.onGetCountriesUserEvent();
  showModalBottomSheet(
      isScrollControlled: true,
      elevation: 10,
      backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.w),
          topRight: Radius.circular(30.w),
        ),
      ),
      builder: (ctx) => BlocBuilder<ProfBloc,ProfState>(
        bloc: bloc,
        builder: (context, state) {
           if(first&&state.countryModel.data!.isNotEmpty)
             {
               countries.data=state.countryModel.data;
               first=false;
             }
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration:  BoxDecoration(
                  color: Theme.of(ctx).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                alignment: Alignment.center,
                width: 1.sw,
                height: 350.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('Countries',
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(ctx).primaryColorDark
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ).tr(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      height: 45.h,
                      child: TextFormField(

                        style: TextStyle(
                            fontSize: FontSize.s16,
                            color: Global.darkMode
                                ? ColorManager.backgroundColor
                                : ColorManager.textColor),
                        controller: textEditingController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 5.h, bottom: 10.h, right: 5, left: 5),
                          hintText: "Search for a country".tr(),
                          hintStyle: TextStyle(
                            color: ColorManager.hintText,
                            fontSize: 14.sp,
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
                        onChanged: (va){
                          countries.data=[];
                          if(va.isEmpty){

                            countries.data=state.countryModel.data;
                            setState((){});
                          }
                          else{
                             for(var ci in state.countryModel.data!)
                               {
                                    if(ci.name_ar!.contains(va)||ci.name_en!.contains(va))
                                      {
                                        countries.data!.add(ci);
                                      }
                               }
                             setState((){});
                          }
                        },

                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Expanded(
                      child:
                      state.isLoading!?
                      const Center(
                        child: CircularProgressIndicator(),
                      ):
                      countries.data!=null&&
                          countries.data!.isNotEmpty?
                      ListView.separated(

                          itemBuilder: (context, index) {
                            return  Padding(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 12.w
                                ),
                                child: InkWell(
                                  onTap: (){
                                    bloc.onUpdateUserInfoEvent(country:
                                    countries.data![index]
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 50.h,
                                        height: 50.h,
                                        child: CachedNetworkImage(
                                          imageUrl:"https://www.room.tecknick.net/WI.jpeg",
                                          imageBuilder: (context, imageProvider) => Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      SizedBox(width: 6.w,),
                                      Expanded(
                                        child: Text(
                                          Global.lan=='ar'?
                                          countries.data![index].name_ar!:
                                          countries.data![index].name_en!,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).primaryColorDark
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),


                                    ],
                                  ),
                                )
                            );
                          }, separatorBuilder: (context, index) {
                        return  Divider(
                          thickness:1,
                          color: Theme.of(context).hintColor,
                        );
                      }, itemCount: countries.data!.length):

                      Center(
                        child: Text('No countries',
                          style: TextStyle(
                            fontSize: 16.sp,

                          ),
                        ).tr(),
                      )


                      ,
                    ),
                    Divider(
                      thickness:1,
                      color: Theme.of(ctx).hintColor,
                    ),
                    SizedBox(height: 30.h,),

                  ],
                ),
              );
            },

          );
        },


      ));
  return '';
}
