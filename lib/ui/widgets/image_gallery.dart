/*
 *               *                    *
 *              * *                  * *
 *             *   *                *   *
 *            * * * *              * * * *
 *           *        *           *       *
 *         ***        ***       ***       ***
 *       Copyright (c) 2021 ِAhmed Ashour
 *      ahmedflutter5590@gmail.com
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImagesGallery extends StatefulWidget {
  List<String> networkImages;
  int imageIndex;
  ImagesGallery({required this.networkImages, required this.imageIndex});
  @override
  State<StatefulWidget> createState() {
    return _ImagesGalleryState();
  }
}

class _ImagesGalleryState extends State<ImagesGallery> {
  late int _current;
  @override
  void initState() {
    _current = widget.imageIndex;
    super.initState();
  }

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text('Fullscreen sliding carousel demo')),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          final double width = MediaQuery.of(context).size.width;
          return Stack(
            children: [
              if (widget.networkImages.length > 0)
                CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                      initialPage: _current,
                      height: height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                        print("@@@@@@@@@@@@@@ $_current");
                      }
                      // autoPlay: false,
                      ),
                  items: widget.networkImages
                      .map((item) => Container(
                            child: Center(
                                child: PhotoView(
                              imageProvider: NetworkImage(item),
                            )
                                // CachedNetworkImage(
                                //   imageUrl: item ?? '/',
                                //   fit: BoxFit.contain,
                                //   height: height,
                                //   width: width,
                                //   placeholder: (context, url) => Image.asset(
                                //     "assets/images/place.png",
                                //     fit: BoxFit.fill,
                                //   ),
                                //   errorWidget: (context, url, error) =>
                                //   new Icon(Icons.error_outline),
                                // )
                                ),
                          ))
                      .toList(),
                ),
              if (widget.networkImages.length > 1)
                Positioned(
                  bottom: ScreenUtil().setHeight(10),
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.networkImages.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                            width: _current == entry.key
                                ? ScreenUtil().setWidth(60)
                                : ScreenUtil().setWidth(40),
                            height: _current == entry.key
                                ? ScreenUtil().setHeight(60)
                                : ScreenUtil().setHeight(40),
                            margin: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(5),
                                horizontal: ScreenUtil().setWidth(4)),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.white),
                                color: Colors.white.withOpacity(
                                    _current == entry.key ? 1 : 0.4)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: entry.value,
                                  fit: BoxFit.contain,
                                  height: height,
                                  placeholder: (context, url) => Image.asset(
                                    "assets/images/place.png",
                                    fit: BoxFit.fill,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error_outline),
                                ))),
                      );
                    }).toList(),
                  ),
                ),
              Positioned(
                top: ScreenUtil().setHeight(30),
//                right: 0,
                left: ScreenUtil().setWidth(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        // EasyLocalization.of(context).currentLocale ==
                        //     Locale("en", "US")?
                        Icons.arrow_back_ios, color: Colors.white,
                        //: Icons.arrow_forward_ios
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
