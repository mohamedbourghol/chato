import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';



class PhotoViewWidget extends StatefulWidget {
  final  File? file;
  final String? networkImage;
  const PhotoViewWidget({Key? key,required this.file,
    required this.networkImage,
  }) : super(key: key);

  @override
  _PhotoViewWidgetState createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {


  @override
  Widget build(BuildContext context) {
    if(widget.file!=null) {
      return PhotoView(

      imageProvider:
          FileImage(widget.file!)
    );
    }
    else
    {
      return PhotoView(

          imageProvider:
          NetworkImage(widget.networkImage!)
      );
    }
  }
}
