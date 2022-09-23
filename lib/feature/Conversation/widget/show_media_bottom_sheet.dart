
import 'dart:io';
import 'package:chato/feature/Conversation/widget/show_image_video_before_send.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../../RoomConversation/widget/contact/flutter_contact.dart';
import '../bloc/conversation_bloc.dart';


void showMediaBottomSheet({
 required BuildContext ctx,
  required ConversationBloc bloc,
  required int userIdTwo,

}) {

  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.w),
          topRight: Radius.circular(30.w),
        ),
      ),

      builder: (ctx) => Container(

        width: 1.sw,
        height: 300.h,

        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            SizedBox(
              width: 75.w,

              child: const Divider(

                thickness: 4.5,
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    FilePickerResult? result = await
                    FilePicker.platform.pickFiles(
                      type: FileType.media,
                    );
                    if (result != null) {
                      File file = File(result.files.single.path!);
                     await   Navigator.push(ctx,
                          MaterialPageRoute(builder:
                              (context) => ShowImageVideoBeforeSendCon
                                (file: file,roomId: userIdTwo,bloc: bloc, )
                            ,)).then((value) {
                             Navigator.pop(ctx);
                     });
                    //  widget.bloc.onChangeImageEvent(file);
                     // bloc.onSendMessageEvent('', userIdTwo, file);


                    }
                    else {
                      // User canceled the picker
                    }
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/gallery.svg'),
                      SizedBox(height: 10.h,),
                      Text('Gallery',style: TextStyle(
                        color: Theme.of(ctx).disabledColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600
                      ),).tr()

                    ],
                  ),
                ),
                SizedBox(width: 30.w,),
                InkWell(
                  onTap: ()async{
                    final ImagePicker _picker = ImagePicker();
                    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                   if(photo!=null)
                     {
                       File file = File(photo.path);
                       //  widget.bloc.onChangeImageEvent(file);
                       await   Navigator.push(ctx,
                           MaterialPageRoute(builder:
                               (context) => ShowImageVideoBeforeSendCon
                             (file: file,roomId: userIdTwo,bloc: bloc, )
                             ,)).then((value) {
                         Navigator.pop(ctx);
                       });
                      // bloc.onSendMessageEvent('', userIdTwo, file);
                     //  Navigator.pop(ctx);
                     }

                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/camera.svg'),
                      SizedBox(height: 10.h,),
                      Text('Camera',style: TextStyle(
                          color: Theme.of(ctx).disabledColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600
                      ),).tr()

                    ],
                  ),
                ),
                SizedBox(width: 30.w,),
                InkWell(
                  onTap: () async {
                    FilePickerResult? result = await
                    FilePicker.platform.pickFiles(
                    );
                    if (result != null) {
                      File file = File(result.files.single.path!);
                      //  widget.bloc.onChangeImageEvent(file);
                      bloc.onSendMessageEvent('', userIdTwo, file);
                      Navigator.pop(ctx);

                    }
                    else {
                      // User canceled the picker
                    }
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/doc.svg'),
                      SizedBox(height: 10.h,),
                      Text('Document',style: TextStyle(
                          color: Theme.of(ctx).disabledColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600
                      ),).tr()

                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()async{
                   await Navigator.push(ctx, MaterialPageRoute(builder:
                        (context) => const Contacts(),)).then((value) {
                          if(value is Contact?)
                            {
                              bloc.onSendMessageEvent(value!.name.first
                                  +' '+value.name.last+'\n '+value.phones[0].number
                                  , userIdTwo, null);
                              Navigator.pop(ctx);
                            }
                   });
                   // List<Contact> contacts = await ContactsService.getContacts();
                 //   await ContactsService.openContactForm();


                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/contact.svg'),
                      SizedBox(height: 10.h,),
                      Text('Contact',style: TextStyle(
                          color: Theme.of(ctx).disabledColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600
                      ),).tr()

                    ],
                  ),
                ),
                SizedBox(width: 30.w,),
                InkWell(
                  onTap: () async {
                    Location location =  Location();

                    bool _serviceEnabled;
                    PermissionStatus _permissionGranted;
                    LocationData _locationData;

                    _serviceEnabled = await location.serviceEnabled();
                    if (!_serviceEnabled) {
                      _serviceEnabled = await location.requestService();
                      if (!_serviceEnabled) {

                      }
                    }

                    _permissionGranted = await location.hasPermission();
                    if (_permissionGranted == PermissionStatus.denied) {
                      _permissionGranted = await location.requestPermission();
                      if (_permissionGranted != PermissionStatus.granted) {

                      }
                    }

                   try{
                     _locationData = await location.getLocation();
                     bloc.onSendMessageEvent('https://www.google.com/maps/search/?api=1&query=${_locationData.latitude},${_locationData.longitude}'
                         , userIdTwo, null);
                     Navigator.pop(ctx);
                   }
                    catch (e)
                    // ignore: empty_catches
                    {

                    }
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/location.svg'),
                      SizedBox(height: 10.h,),
                      Text('Location',style: TextStyle(
                          color: Theme.of(ctx).disabledColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600
                      ),).tr()

                    ],
                  ),
                ),
                SizedBox(width: 30.w,),
                InkWell(
                  onTap: () async {
                    FilePickerResult? result = await
                    FilePicker.platform.pickFiles(
                      type: FileType.audio,

                    );

                    if (result != null) {
                      File file = File(result.files.single.path!);
                      //  widget.bloc.onChangeImageEvent(file);
                      bloc.onSendMessageEvent('', userIdTwo, file);
                      Navigator.pop(ctx);

                    }
                    else {
                      // User canceled the picker
                    }
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/sound_clip.svg'),
                      SizedBox(height: 10.h,),
                      Text('Sound Clip',style: TextStyle(
                          color: Theme.of(ctx).disabledColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600
                      ),).tr()

                    ],
                  ),
                ),

              ],
            ),

          ],
        ),
      ));
}