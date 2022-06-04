import 'package:auction/utils/FCIStyle.dart';
import 'package:auction/utils/constants.dart';
import 'package:flutter/material.dart';

import '../auction_screens/car_details.dart';
import 'car_exterior_parts_clip.dart';


class CarExteriorPartsView extends StatefulWidget {
  final List<CarExteriorPartsData>carExteriorPartsDataList;
  CarExteriorPartsView({required this.carExteriorPartsDataList});
  @override
  _CarExteriorPartsViewState createState() => _CarExteriorPartsViewState();
}

class _CarExteriorPartsViewState extends State<CarExteriorPartsView> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: FCISize.height(context) * 0.25,
      width: FCISize.width(context) * 0.66,
      child: Stack(
        children: List.generate(
            (widget.carExteriorPartsDataList.length+1),
                (index) {
              if(index!=widget.carExteriorPartsDataList.length)
                  return
              ClipPath(
                child: Container(
                  height: FCISize.height(context) * carShapeHeight,
                  width: FCISize.width(context) * carShapeWidth,
                  color: getCarExteriorPartsColor(widget.carExteriorPartsDataList[index].carExteriorPartsDamagedType),
                ),
                clipper: CarExteriorPartShape(
                    carExteriorParts: widget.carExteriorPartsDataList[index].carExteriorParts),
              );
              else
                return
                  Center(
                    child: Image.asset(
                      'assets/images/carshape.png',
                      height: FCISize.height(context) * 0.25,
                      width: FCISize.width(context) * 0.66,
                    ),
                  );
                }),
      ),
    );
  }
}
class CarExteriorPartsData{
  final CarExteriorParts carExteriorParts;
  final CarExteriorPartsDamagedType carExteriorPartsDamagedType;
  final String name;
  CarExteriorPartsData({
    required this.carExteriorParts,
    required this.carExteriorPartsDamagedType,
    required this.name});
}

