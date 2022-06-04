import 'package:auction/utils/constants.dart';
import 'package:flutter/material.dart';

import '../auction_screens/car_details.dart';
class CarExteriorPartShape extends CustomClipper<Path> {
  CarExteriorParts carExteriorParts;
  CarExteriorPartShape({required this.carExteriorParts});
  @override
  Path getClip(Size size) {
    switch(carExteriorParts){
      case CarExteriorParts.frontBumper:
       return frontBumperShape(size);
        break;
      case CarExteriorParts.bonnet:
        return bonnetShape(size);
        break;
      case CarExteriorParts.roof:
        return roofShape(size);
        break;
      case CarExteriorParts.rearBumper:
        return rearBumperShape(size);
        break;
      case CarExteriorParts.driverSideFrontWing:
        return driverSideFrontWingShape(size);
        break;
      case CarExteriorParts.driverSideFrontDoor:
        return driverSideFrontDoorShape(size);
        break;
      case CarExteriorParts.driverSideRearDoor:
        return driverSideRearDoorShape(size);
        break;
      case CarExteriorParts.driverSideRearQuarter:
        return driverSideRearQuarterShape(size);
        break;
      case CarExteriorParts.passengerSideFrontWing:
        return passengerSideFrontWingShape(size);
        break;
      case CarExteriorParts.passengerSideFrontDoor:
        return passengerSideFrontDoorShape(size);
        break;
      case CarExteriorParts.passengerSideRearDoor:
        return passengerSideRearDoorShape(size);
        break;
      case CarExteriorParts.passengerSideRearQuarter:
        return passengerSideRearQuarterShape(size);
        break;
      case CarExteriorParts.bootTrunk:
        return bootTrunkShape(size);
        break;
      case CarExteriorParts.driverSideFrontTyre:
        return driverSideFrontTyreShape(size);
        break;
      case CarExteriorParts.driverSideRearTyre:
        return driverSideRearTyreShape(size);
        break;
      case CarExteriorParts.passengerSideFrontTyre:
        return passengerSideFrontTyreShape(size);
        break;
      case CarExteriorParts.passengerSideRearTyre:
        return passengerSideRearTyreShape(size);
        break;
    }
    return frontBumperShape(size);
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
Path noneShape(Size size){
  Path path5 = Path();
  path5.close();
  return path5;
}
Path frontBumperShape(Size size){
  Path path5 = Path();
  path5.moveTo(size.width*0.9212500,size.height*0.3000000);
  path5.cubicTo(size.width*0.9212500,size.height*0.6000000,size.width*0.9212500,size.height*0.6000000,size.width*0.9212500,size.height*0.7000000);
  path5.quadraticBezierTo(size.width*0.9078125,size.height*0.7155600,size.width*0.8675000,size.height*0.7200000);
  path5.quadraticBezierTo(size.width*0.8703125,size.height*0.6420000,size.width*0.8712500,size.height*0.6160000);
  path5.quadraticBezierTo(size.width*0.8675750,size.height*0.5985800,size.width*0.8550000,size.height*0.6060000);
  path5.lineTo(size.width*0.8462500,size.height*0.6160000);
  path5.lineTo(size.width*0.8437500,size.height*0.3900000);
  path5.quadraticBezierTo(size.width*0.8540625,size.height*0.3975000,size.width*0.8575000,size.height*0.4000000);
  path5.quadraticBezierTo(size.width*0.8697750,size.height*0.4090400,size.width*0.8675000,size.height*0.3840000);
  path5.lineTo(size.width*0.8687500,size.height*0.2860000);
  path5.quadraticBezierTo(size.width*0.8885000,size.height*0.2814400,size.width*0.9212500,size.height*0.3000000);
  path5.close();
  return path5;
}
Path bonnetShape(Size size){
  Path path4 = Path();
  path4.moveTo(size.width*0.6775000,size.height*0.3000000);
  path4.cubicTo(size.width*0.7628125,size.height*0.3030000,size.width*0.7815625,size.height*0.3180000,size.width*0.8162500,size.height*0.3240000);
  path4.quadraticBezierTo(size.width*0.8400000,size.height*0.3440000,size.width*0.8425000,size.height*0.3940000);
  path4.quadraticBezierTo(size.width*0.8425000,size.height*0.5545000,size.width*0.8425000,size.height*0.6080000);
  path4.cubicTo(size.width*0.8437500,size.height*0.6557600,size.width*0.8181250,size.height*0.6650000,size.width*0.8100000,size.height*0.6840000);
  path4.quadraticBezierTo(size.width*0.7339125,size.height*0.7075000,size.width*0.6775000,size.height*0.6980000);
  path4.quadraticBezierTo(size.width*0.7101625,size.height*0.6407600,size.width*0.7075000,size.height*0.5100000);
  path4.cubicTo(size.width*0.7000000,size.height*0.4575000,size.width*0.7125000,size.height*0.3662600,size.width*0.6775000,size.height*0.3000000);
  path4.close();
  return path4;
}
Path roofShape(Size size){

  Path path6 = Path();
  path6.moveTo(size.width*0.5812500,size.height*0.3460000);
  path6.quadraticBezierTo(size.width*0.6023875,size.height*0.4924400,size.width*0.5800000,size.height*0.6600000);
  path6.quadraticBezierTo(size.width*0.4992125,size.height*0.6373400,size.width*0.4625000,size.height*0.6380000);
  path6.quadraticBezierTo(size.width*0.3741500,size.height*0.6395800,size.width*0.3462500,size.height*0.6600000);
  path6.quadraticBezierTo(size.width*0.3357125,size.height*0.5612600,size.width*0.3350000,size.height*0.5000000);
  path6.quadraticBezierTo(size.width*0.3335750,size.height*0.4565800,size.width*0.3475000,size.height*0.3420000);
  path6.quadraticBezierTo(size.width*0.3872750,size.height*0.3674600,size.width*0.4525000,size.height*0.3640000);
  path6.cubicTo(size.width*0.4846875,size.height*0.3595000,size.width*0.5032375,size.height*0.3634200,size.width*0.5812500,size.height*0.3460000);
  path6.close();

  return path6;
}
Path rearBumperShape(Size size){
  Path path8 = Path();
  path8.moveTo(size.width*0.1950000,size.height*0.3020000);
  path8.lineTo(size.width*0.1962500,size.height*0.7020000);
  path8.lineTo(size.width*0.1875000,size.height*0.7020000);
  path8.lineTo(size.width*0.1854500,size.height*0.6672800);
  path8.lineTo(size.width*0.1541000,size.height*0.6420000);
  path8.lineTo(size.width*0.1525000,size.height*0.7020000);
  path8.lineTo(size.width*0.1387500,size.height*0.7040000);
  path8.lineTo(size.width*0.1387500,size.height*0.7160000);
  path8.quadraticBezierTo(size.width*0.1033500,size.height*0.7175400,size.width*0.0861500,size.height*0.6980000);
  path8.quadraticBezierTo(size.width*0.0855500,size.height*0.6005000,size.width*0.0837500,size.height*0.3080000);
  path8.quadraticBezierTo(size.width*0.1017250,size.height*0.2930000,size.width*0.1125000,size.height*0.2880000);
  path8.quadraticBezierTo(size.width*0.1187500,size.height*0.2872800,size.width*0.1375000,size.height*0.2880000);
  path8.lineTo(size.width*0.1412500,size.height*0.3040000);
  path8.lineTo(size.width*0.1525000,size.height*0.3020000);
  path8.lineTo(size.width*0.1533000,size.height*0.3651800);
  path8.quadraticBezierTo(size.width*0.1753500,size.height*0.3473800,size.width*0.1837500,size.height*0.3400000);
  path8.quadraticBezierTo(size.width*0.1846875,size.height*0.3310000,size.width*0.1875000,size.height*0.3040000);
  path8.lineTo(size.width*0.1950000,size.height*0.3020000);
  path8.close();
  return path8;
}
/* */Path driverSideFrontWingShape(Size size){

  Path path10 = Path();
  path10.moveTo(size.width*0.7644375,size.height*0.1500800);
  path10.quadraticBezierTo(size.width*0.8045125,size.height*0.1552000,size.width*0.8175000,size.height*0.1540000);
  path10.lineTo(size.width*0.8075000,size.height*0.1900000);
  path10.quadraticBezierTo(size.width*0.7182250,size.height*0.2209600,size.width*0.6875000,size.height*0.2220000);
  path10.cubicTo(size.width*0.6818750,size.height*0.2265000,size.width*0.6717125,size.height*0.2372400,size.width*0.6650000,size.height*0.2400000);
  path10.quadraticBezierTo(size.width*0.6609375,size.height*0.2400000,size.width*0.6487500,size.height*0.2400000);
  path10.lineTo(size.width*0.6525000,size.height*0.2080000);
  path10.quadraticBezierTo(size.width*0.6525000,size.height*0.1225000,size.width*0.6525000,size.height*0.0940000);
  path10.quadraticBezierTo(size.width*0.6554000,size.height*0.0866800,size.width*0.6437500,size.height*0.0740000);
  path10.lineTo(size.width*0.6750000,size.height*0.0740000);
  path10.quadraticBezierTo(size.width*0.6907000,size.height*0.2035200,size.width*0.7644375,size.height*0.1500800);
  path10.close();
  return path10;
}
Path driverSideFrontDoorShape(Size size){

  Path path11 = Path();
  path11.moveTo(size.width*0.4962500,size.height*0.0740000);
  path11.quadraticBezierTo(size.width*0.6059375,size.height*0.0709000,size.width*0.6425000,size.height*0.0740000);
  path11.quadraticBezierTo(size.width*0.6550625,size.height*0.0828000,size.width*0.6537500,size.height*0.0980000);
  path11.cubicTo(size.width*0.6537500,size.height*0.1275000,size.width*0.6537500,size.height*0.1865000,size.width*0.6537500,size.height*0.2160000);
  path11.quadraticBezierTo(size.width*0.6498625,size.height*0.2570400,size.width*0.6207000,size.height*0.2782400);
  path11.quadraticBezierTo(size.width*0.5784500,size.height*0.3164200,size.width*0.5625000,size.height*0.3254000);
  path11.cubicTo(size.width*0.5436500,size.height*0.3416800,size.width*0.5036750,size.height*0.3473200,size.width*0.4840625,size.height*0.3480000);
  path11.quadraticBezierTo(size.width*0.4866719,size.height*0.3190750,size.width*0.4945000,size.height*0.2323000);
  path11.quadraticBezierTo(size.width*0.4992125,size.height*0.1933400,size.width*0.4962500,size.height*0.0740000);
  path11.close();
  return path11;
}
Path driverSideRearDoorShape(Size size){
  Path path13 = Path();
  path13.moveTo(size.width*0.4962500,size.height*0.0720000);
  path13.quadraticBezierTo(size.width*0.4175000,size.height*0.0720000,size.width*0.3912500,size.height*0.0720000);
  path13.quadraticBezierTo(size.width*0.3891875,size.height*0.1251600,size.width*0.3825000,size.height*0.1400000);
  path13.quadraticBezierTo(size.width*0.3733000,size.height*0.1636200,size.width*0.3573750,size.height*0.1812400);
  path13.quadraticBezierTo(size.width*0.3477000,size.height*0.1916800,size.width*0.3487500,size.height*0.2020000);
  path13.cubicTo(size.width*0.3495187,size.height*0.2118200,size.width*0.3486375,size.height*0.2327200,size.width*0.3518250,size.height*0.2412800);
  path13.quadraticBezierTo(size.width*0.3571500,size.height*0.2668400,size.width*0.3737750,size.height*0.3442400);
  path13.quadraticBezierTo(size.width*0.4561375,size.height*0.3486000,size.width*0.4837500,size.height*0.3440000);
  path13.quadraticBezierTo(size.width*0.4900625,size.height*0.3193600,size.width*0.4962500,size.height*0.2400000);
  path13.quadraticBezierTo(size.width*0.5029500,size.height*0.1578000,size.width*0.4962500,size.height*0.0720000);
  path13.close();
  return path13;
}
Path driverSideRearQuarterShape(Size size){
  Path path15 = Path();
  path15.moveTo(size.width*0.3660500,size.height*0.3552200);
  path15.cubicTo(size.width*0.3652625,size.height*0.3378050,size.width*0.3652625,size.height*0.3378050,size.width*0.3650000,size.height*0.3320000);
  path15.quadraticBezierTo(size.width*0.3456250,size.height*0.3211400,size.width*0.3137500,size.height*0.2700000);
  path15.quadraticBezierTo(size.width*0.3003000,size.height*0.2464400,size.width*0.3187500,size.height*0.2440000);
  path15.quadraticBezierTo(size.width*0.3268750,size.height*0.2440000,size.width*0.3512500,size.height*0.2440000);
  path15.lineTo(size.width*0.3487500,size.height*0.2040000);
  path15.quadraticBezierTo(size.width*0.3513875,size.height*0.1844000,size.width*0.3625000,size.height*0.1740000);
  path15.cubicTo(size.width*0.3706250,size.height*0.1485000,size.width*0.3872125,size.height*0.1645000,size.width*0.3950000,size.height*0.0720000);
  path15.quadraticBezierTo(size.width*0.3925000,size.height*0.0725000,size.width*0.3850000,size.height*0.0740000);
  path15.quadraticBezierTo(size.width*0.3869625,size.height*0.1375200,size.width*0.3512500,size.height*0.1680000);
  path15.quadraticBezierTo(size.width*0.3214625,size.height*0.1787800,size.width*0.3050000,size.height*0.1600000);
  path15.lineTo(size.width*0.1983500,size.height*0.1660000);
  path15.lineTo(size.width*0.1980250,size.height*0.2340000);
  path15.quadraticBezierTo(size.width*0.1981250,size.height*0.2646200,size.width*0.2200000,size.height*0.2609000);
  path15.cubicTo(size.width*0.2309500,size.height*0.2608350,size.width*0.2528500,size.height*0.2607050,size.width*0.2638000,size.height*0.2606400);
  path15.quadraticBezierTo(size.width*0.2728500,size.height*0.2605400,size.width*0.2911875,size.height*0.2789800);
  path15.quadraticBezierTo(size.width*0.3073625,size.height*0.3067400,size.width*0.3660500,size.height*0.3552200);
  path15.close();
  return path15;
}
Path passengerSideFrontWingShape(Size size){
  Path path16 = Path();
  path16.moveTo(size.width*0.8187500,size.height*0.8520000);
  path16.cubicTo(size.width*0.7812500,size.height*0.8535000,size.width*0.7812500,size.height*0.8535000,size.width*0.7687500,size.height*0.8540000);
  path16.cubicTo(size.width*0.7521875,size.height*0.8470000,size.width*0.7268750,size.height*0.8245000,size.width*0.7009375,size.height*0.8520000);
  path16.cubicTo(size.width*0.6839375,size.height*0.8663000,size.width*0.6771250,size.height*0.9119000,size.width*0.6757500,size.height*0.9312000);
  path16.quadraticBezierTo(size.width*0.6677500,size.height*0.9309000,size.width*0.6437500,size.height*0.9300000);
  path16.quadraticBezierTo(size.width*0.6531250,size.height*0.9205000,size.width*0.6525000,size.height*0.9080000);
  path16.quadraticBezierTo(size.width*0.6525000,size.height*0.9080000,size.width*0.6525000,size.height*0.9080000);
  path16.lineTo(size.width*0.6525000,size.height*0.7840000);
  path16.lineTo(size.width*0.6475000,size.height*0.7665000);
  path16.lineTo(size.width*0.6662500,size.height*0.7600000);
  path16.quadraticBezierTo(size.width*0.6790625,size.height*0.7760000,size.width*0.6862500,size.height*0.7780000);
  path16.quadraticBezierTo(size.width*0.7165625,size.height*0.7865000,size.width*0.8075000,size.height*0.8120000);
  path16.quadraticBezierTo(size.width*0.8140625,size.height*0.8220000,size.width*0.8187500,size.height*0.8520000);
  path16.close();
  return path16;
}
/* */Path passengerSideFrontDoorShape(Size size){
  Path path3 = Path();
  path3.moveTo(size.width*0.4825000,size.height*0.6580000);
  path3.quadraticBezierTo(size.width*0.5485375,size.height*0.6471000,size.width*0.6400000,size.height*0.7460000);
  path3.quadraticBezierTo(size.width*0.6515875,size.height*0.7643000,size.width*0.6512500,size.height*0.7800000);
  path3.cubicTo(size.width*0.6518750,size.height*0.8095000,size.width*0.6531250,size.height*0.8685000,size.width*0.6537500,size.height*0.8980000);
  path3.quadraticBezierTo(size.width*0.6522500,size.height*0.9362200,size.width*0.6387500,size.height*0.9300000);
  path3.lineTo(size.width*0.4962500,size.height*0.9300000);
  path3.quadraticBezierTo(size.width*0.5076625,size.height*0.8047000,size.width*0.4825000,size.height*0.6580000);
  path3.close();

  return path3;
}
Path passengerSideRearDoorShape(Size size){
  Path path1 = Path();
  path1.moveTo(size.width*0.4825000,size.height*0.6580000);
  path1.quadraticBezierTo(size.width*0.5072750,size.height*0.8094400,size.width*0.4962500,size.height*0.9300000);
  path1.quadraticBezierTo(size.width*0.4703125,size.height*0.9295000,size.width*0.3925000,size.height*0.9280000);
  path1.quadraticBezierTo(size.width*0.3926500,size.height*0.8426800,size.width*0.3512500,size.height*0.8160000);
  path1.cubicTo(size.width*0.3515625,size.height*0.8010000,size.width*0.3488875,size.height*0.7736400,size.width*0.3525000,size.height*0.7560000);
  path1.quadraticBezierTo(size.width*0.3584375,size.height*0.7315000,size.width*0.3762500,size.height*0.6580000);
  path1.lineTo(size.width*0.4825000,size.height*0.6580000);
  path1.close();
  return path1;
}
/* */Path passengerSideRearQuarterShape(Size size){
  Path path10 = Path();
  path10.moveTo(size.width*0.1980625,size.height*0.8422000);
  path10.quadraticBezierTo(size.width*0.2792031,size.height*0.8420500,size.width*0.3062500,size.height*0.8420000);
  path10.cubicTo(size.width*0.3732375,size.height*0.8157000,size.width*0.3892625,size.height*0.9058800,size.width*0.3837500,size.height*0.9280000);
  path10.quadraticBezierTo(size.width*0.3859375,size.height*0.9280000,size.width*0.3925000,size.height*0.9280000);
  path10.quadraticBezierTo(size.width*0.3917875,size.height*0.8455000,size.width*0.3525000,size.height*0.8180000);
  path10.quadraticBezierTo(size.width*0.3476875,size.height*0.8074800,size.width*0.3506875,size.height*0.7560000);
  path10.quadraticBezierTo(size.width*0.3239219,size.height*0.7575000,size.width*0.3150000,size.height*0.7580000);
  path10.cubicTo(size.width*0.3033500,size.height*0.7622200,size.width*0.3103125,size.height*0.7445000,size.width*0.3087500,size.height*0.7400000);
  path10.quadraticBezierTo(size.width*0.3230500,size.height*0.7095200,size.width*0.3675000,size.height*0.6680000);
  path10.quadraticBezierTo(size.width*0.3679875,size.height*0.6557400,size.width*0.3689250,size.height*0.6512400);
  path10.cubicTo(size.width*0.3228750,size.height*0.6701800,size.width*0.2946375,size.height*0.7306600,size.width*0.2925000,size.height*0.7260000);
  path10.quadraticBezierTo(size.width*0.2699250,size.height*0.7456400,size.width*0.2487500,size.height*0.7447600);
  path10.lineTo(size.width*0.2133625,size.height*0.7446200);
  path10.quadraticBezierTo(size.width*0.2001625,size.height*0.7473600,size.width*0.1983625,size.height*0.7600000);
  path10.quadraticBezierTo(size.width*0.1982875,size.height*0.7805500,size.width*0.1980625,size.height*0.8422000);
  path10.close();
  return path10;
}
Path bootTrunkShape(Size size){
  Path path7 = Path();
  path7.moveTo(size.width*0.1962500,size.height*0.3360000);
  path7.cubicTo(size.width*0.1981250,size.height*0.5850000,size.width*0.1981250,size.height*0.5850000,size.width*0.1987500,size.height*0.6680000);
  path7.quadraticBezierTo(size.width*0.2067625,size.height*0.6945800,size.width*0.2200000,size.height*0.6940000);
  path7.lineTo(size.width*0.2850000,size.height*0.6960000);
  path7.lineTo(size.width*0.2850000,size.height*0.3100000);
  path7.lineTo(size.width*0.2200000,size.height*0.3100000);
  path7.quadraticBezierTo(size.width*0.2082125,size.height*0.3107400,size.width*0.1962500,size.height*0.3360000);
  path7.close();
  return path7;
}
/* */Path driverSideFrontTyreShape(Size size){

  Path path18 = Path();
  path18.moveTo(size.width*0.7291750,size.height*0.0089400);
  path18.cubicTo(size.width*0.7472125,size.height*0.0089400,size.width*0.7751125,size.height*0.0293200,size.width*0.7751125,size.height*0.0824400);
  path18.cubicTo(size.width*0.7751125,size.height*0.1113000,size.width*0.7614375,size.height*0.1559400,size.width*0.7291750,size.height*0.1559400);
  path18.cubicTo(size.width*0.7111250,size.height*0.1559400,size.width*0.6832250,size.height*0.1340600,size.width*0.6832250,size.height*0.0824400);
  path18.cubicTo(size.width*0.6832250,size.height*0.0535600,size.width*0.6969000,size.height*0.0089400,size.width*0.7291750,size.height*0.0089400);
  path18.close();
  return path18;
}
/* */Path driverSideRearTyreShape(Size size){

  Path path19 = Path();
  path19.moveTo(size.width*0.3310125,size.height*0.0097400);
  path19.cubicTo(size.width*0.3490500,size.height*0.0091600,size.width*0.3769500,size.height*0.0301200,size.width*0.3769500,size.height*0.0832400);
  path19.cubicTo(size.width*0.3769500,size.height*0.1121000,size.width*0.3632750,size.height*0.1567400,size.width*0.3310125,size.height*0.1567400);
  path19.cubicTo(size.width*0.3129625,size.height*0.1567400,size.width*0.2850625,size.height*0.1348600,size.width*0.2850625,size.height*0.0832400);
  path19.cubicTo(size.width*0.2850625,size.height*0.0543600,size.width*0.2987375,size.height*0.0091600,size.width*0.3310125,size.height*0.0097400);
  path19.close();

  return path19;
}
/* */Path passengerSideFrontTyreShape(Size size){

  Path path20 = Path();
  path20.moveTo(size.width*0.7295125,size.height*0.8495000);
  path20.cubicTo(size.width*0.7475375,size.height*0.8495000,size.width*0.7754500,size.height*0.8698800,size.width*0.7754500,size.height*0.9230000);
  path20.cubicTo(size.width*0.7754500,size.height*0.9518600,size.width*0.7617625,size.height*0.9965000,size.width*0.7295125,size.height*0.9965000);
  path20.cubicTo(size.width*0.7114500,size.height*0.9965000,size.width*0.6835625,size.height*0.9746200,size.width*0.6835625,size.height*0.9230000);
  path20.cubicTo(size.width*0.6835625,size.height*0.8941200,size.width*0.6972250,size.height*0.8495000,size.width*0.7295125,size.height*0.8495000);
  path20.close();
  return path20;
}
/* */Path passengerSideRearTyreShape(Size size){

  Path path21 = Path();
  path21.moveTo(size.width*0.3323125,size.height*0.8494800);
  path21.cubicTo(size.width*0.3498125,size.height*0.8494800,size.width*0.3782500,size.height*0.8698600,size.width*0.3782500,size.height*0.9229800);
  path21.cubicTo(size.width*0.3782500,size.height*0.9518400,size.width*0.3645625,size.height*0.9964800,size.width*0.3323125,size.height*0.9964800);
  path21.cubicTo(size.width*0.3142500,size.height*0.9964800,size.width*0.2863625,size.height*0.9746000,size.width*0.2863625,size.height*0.9229800);
  path21.cubicTo(size.width*0.2863625,size.height*0.8941000,size.width*0.2995000,size.height*0.8494800,size.width*0.3323125,size.height*0.8494800);
  path21.close();
  return path21;
}

