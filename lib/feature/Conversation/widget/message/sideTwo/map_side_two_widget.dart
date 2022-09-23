import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../User/user.dart';

import '../../../model/private_old_message_data_model.dart';





class MessageMapSideTwo extends StatefulWidget {
  final PrivateOldMessageDataModel message;
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


      ],
    );

  }


}
