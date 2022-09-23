import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../Globals.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../User/user.dart';
import '../../../model/conversationMessage/conversation_old_message_data_model.dart';





class MessageMapSideTwo extends StatefulWidget {
  final ConversationOldMessageDataModel message;
  const MessageMapSideTwo({Key? key,required this.message}) :
        super(key: key);

  @override
  _MessageMapSideTwoState createState() => _MessageMapSideTwoState();
}

class _MessageMapSideTwoState extends State<MessageMapSideTwo> {
  final Completer<GoogleMapController> _controller = Completer();
  late double lan;
  late double lat;
  late CameraPosition _kGooglePlex ;
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {

    lan=double.parse(widget.message.message!.substring(48,widget.message.message!.indexOf(',')));
    lat=double.parse(widget.message.message!.substring(widget.message.message!.indexOf(',')+1,
        widget.message.message!.length-1));
    _kGooglePlex = CameraPosition(
      target: LatLng(lan, lat),
      zoom: 14.4746,
    );

    MarkerId markerId = MarkerId('orgin');
    Marker marker =
    Marker(markerId: markerId,
        icon: BitmapDescriptor.defaultMarker ,
        position:  LatLng(
            lan,
            lat));
    markers[markerId] = marker;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,


      children: [

        SizedBox(
          width: 50.w,
        ),

        Expanded(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color:  const Color(0xff99AACD),
                  borderRadius: BorderRadius.circular(12.w),
                ),

                child: Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: 12.w
                  ),
                  child: Row(
                    children: [

                      Expanded(
                        child: Text(widget.message.user!.name!,
                          style: TextStyle(
                              color: ColorManager.backgroundColor,
                              fontSize: 13.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.end,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  launch(widget.message.message!);
                },
                child: SizedBox(
                  height: 150.h,

                  child: GoogleMap(
                    onTap: (la){
                      launch(widget.message.message!);
                    },
                    mapType: MapType.normal,
                    markers: Set<Marker>.of(markers.values),
                    myLocationEnabled: false,
                    tiltGesturesEnabled: false,
                    compassEnabled: false,
                    myLocationButtonEnabled: false,
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },


                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 6.w,
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  UserScreen(id: widget.message.user!.id!,)),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50.h,
                height: 50.h,
                child: CachedNetworkImage(
                  imageUrl:widget.message.user!.img??
                      "https://www.room.tecknick.net/WI.jpeg",
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
              if(widget.message.user!.vip_user!=null)
                SizedBox(
                  width:widget.message.user!.vip_user!.vip_id=="1"?64.h: 75.h,
                  height: widget.message.user!.vip_user!.vip_id=="1"?64.h: 75.h,
                  child:Image.asset(
                    widget.message.user!.vip_user!.vip_id=="1"?
                    'assets/images/solider_frame.png':
                    widget.message.user!.vip_user!.vip_id=="2"?
                    'assets/images/knight_frame.png':
                    widget.message.user!.vip_user!.vip_id=="3"?
                    'assets/images/minister_frame.png':
                    'assets/images/king_frame.png',
                    fit: BoxFit.fill,
                  ),
                ),
            ],
          ),
        ),
      ],
    );

  }


}
