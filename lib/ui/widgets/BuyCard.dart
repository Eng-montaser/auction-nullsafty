import 'package:auction/database/models/car_model.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:auction/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../auction_screens/car_details.dart';

class BuyCard extends StatefulWidget {
  final CarModel carData;
  const BuyCard({
    Key? key,
    required this.carData,
  }) : super(key: key);
  @override
  _BuyCardState createState() => _BuyCardState();
}

class _BuyCardState extends State<BuyCard> {
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
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: ScreenUtil().setWidth(150),
                    height: ScreenUtil().setHeight(160),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(5)),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.carData.images.length > 0
                            ? "${widget.carData.images[0]}"
                            : "/",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        //width: ScreenUtil().setWidth(150),
                        //  height: ScreenUtil().setHeight(180),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(180),
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${widget.carData.title}'),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(5),
                                  top: ScreenUtil().setHeight(10)),
                              child: Text(
                                '${widget.carData.desc}',
                                style: FCITextStyle.normal(11),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(10)),
                              child: Text(
                                '${widget.carData.start_date}',
                                style: FCITextStyle.normal(12),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(5)),
                              child: Text(
                                '* * * * *',
                                style: FCITextStyle.normal(35,
                                    color: FCIColors.yellowRate()),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(75),
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(30)),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: FCIColors.borderOrange(), width: 3),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                '${convertFromStringToRange('${widget.carData.bid_price}')}\n AED',
                                style: FCITextStyle.bold(13,
                                    color: FCIColors.primaryColor()),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(0),
                                  vertical: ScreenUtil().setHeight(8)),
                            ),
                            Divider(
                              height: 15,
                              thickness: 1,
                              indent: 3,
                              endIndent: 3,
                              color: Colors.black45,
                            ),
                            Container(
                              // alignment: Alignment.center,
                              child: Text(
                                '  ${widget.carData.members}\n Members',
                                style: FCITextStyle.bold(13,
                                    color: Colors.black54),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(0),
                                  vertical: ScreenUtil().setHeight(8)),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              Divider(
                color: FCIColors.diverOrange(),
                thickness: 1,
                height: ScreenUtil().setHeight(25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
