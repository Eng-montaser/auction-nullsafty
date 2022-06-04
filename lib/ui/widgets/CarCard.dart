import 'package:auction/database/models/car_model.dart';
import 'package:auction/ui/auction_screens/car_details.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CarCard extends StatefulWidget {
  final CarModel carData;
  const CarCard({
    Key? key,
    required this.carData,
  }) : super(key: key);
  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(CarDetailsView(
          carData: widget.carData,
        ));
      },
      child: Card(
        // margin: EdgeInsets.all(20),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.carData.images.length > 0
                        ? "${widget.carData.images[0]}"
                        : "",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(height: ScreenUtil().setWidth(5)),
                  /*  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.carData.start_date}',
                        style: FCITextStyle.bold(14, color: Colors.black),
                      ),
                      Text(
                        '${widget.carData.end_date}',
                        style: FCITextStyle.bold(14, color: Colors.black),
                      ),
                    ],
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.carData.title}',
                              style: FCITextStyle.bold(15, color: Colors.black),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(10),
                                  top: ScreenUtil().setHeight(5)),
                              child: Text(
                                '${widget.carData.desc}',
                                //style: FCITextStyle.normal(12),
                                style: FCITextStyle.normal(12),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: FCIColors.primaryColor(),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                '${widget.carData.miles} ${'miles'.tr}',
                                style: FCITextStyle.normal(13),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(20),
                                  vertical: ScreenUtil().setHeight(8)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.thumb_up_alt_outlined,
                                    size: 35,
                                  ),
                                  Icon(
                                    Icons.thumb_down_alt_outlined,
                                    size: 35,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            if (widget.carData.isFinished)
              Positioned(
                  top: ScreenUtil().setHeight(15),
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(6)),
                    decoration: BoxDecoration(color: FCIColors.finishMark()),
                    child: Text(
                      'Finished',
                      style: FCITextStyle.normal(15, color: Colors.white),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
