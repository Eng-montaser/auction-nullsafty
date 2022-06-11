import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget circleImage(double radius, String network, String filePath) {
  if(filePath==null)
  print('file Null');
  print(network);
  return Container(
    height: ScreenUtil().setWidth(radius),
    width: ScreenUtil().setWidth(radius),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(150),
        child: filePath != ''
            ? Image.file(
          File(filePath),
          fit: BoxFit.fill,
        )
            : network == null
            ?
        Image.asset(
          'assets/images/defult_profile.png',
          fit: BoxFit.fill,
        )
            :
        CachedNetworkImage(
          imageUrl: network,
          fit: BoxFit.fill,
          progressIndicatorBuilder:
              (context, url, downloadProgress) =>
              CircularProgressIndicator(
                  value: downloadProgress.progress),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/defult_profile.png',
            fit: BoxFit.fill,
          ),
        )
    ),
  );
}