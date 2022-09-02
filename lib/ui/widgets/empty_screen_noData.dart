import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyCarsData extends StatefulWidget {
  final String message;
  final Function reloadData;
  const EmptyCarsData({
    Key? key,
    required this.message,
    required this.reloadData,
  }) : super(key: key);
  @override
  _BuyCardState createState() => _BuyCardState();
}

class _BuyCardState extends State<EmptyCarsData> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.message}',
                  style: FCITextStyle.normal(16),
                ),
                IconButton(
                    onPressed: () {
                      widget.reloadData();
                    },
                    icon: Icon(
                      Icons.refresh,
                      size: ScreenUtil().setSp(30),
                      color: FCIColors.iconGrey(),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
