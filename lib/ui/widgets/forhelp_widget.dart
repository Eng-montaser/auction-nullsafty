
import 'package:auction/utils/FCIStyle.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
class ForHelpWidget extends StatelessWidget {
    const ForHelpWidget({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: FCISize.height(context)*0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: ()async{
                canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber)).then((bool result) async{
                  print('result ${result}');
                  if(result){
                    await launchUrl(
                      Uri(scheme: 'tel', path: phoneNumber),
                      // mode: LaunchMode.inAppWebView,
                      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
                    );
                  }else{
                    AwesomeDialog(
                        context: context,
                        width: ScreenUtil().setHeight(400),
                        buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                        headerAnimationLoop: false,
                        animType: AnimType.BOTTOMSLIDE,
                        title: '',
                        desc: 'هناك خطا بالاتصال',
                        dialogType: DialogType.ERROR,
                        dismissOnTouchOutside: true
                    )..show();
                  }
                });
              },
              child: data(Icons.phone,FCIColors.primaryColor(),'Phone','(+971)508088648',context)),
          data(Icons.email_outlined,Colors.blue,'Email','booking@tradeinsolutions.ae',context),
          InkWell(
              onTap: ()async{
                var whatsappURl_android = "whatsapp://send?phone=$phoneNumber&text=السلام عليكم";
                var whatsappURL_ios ="https://wa.me/$phoneNumber?text=${Uri.parse("السلام عليكم")}";
                // BotToast.showLoading(align: Alignment.center);
                canLaunchUrl(Uri(scheme: 'whatsapp', path: Platform.isIOS? whatsappURL_ios:whatsappURl_android)).then((bool result) async{
                  print('result ${result}');
                  if(result){
                    await launchUrl(
                      Uri(scheme: 'whatsapp', path: Platform.isIOS? whatsappURL_ios:whatsappURl_android),
                      // mode: LaunchMode.inAppWebView,
                      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
                    );
                  }else{
                    AwesomeDialog(
                        context: context,
                        width: ScreenUtil().setHeight(400),
                        buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                        headerAnimationLoop: false,
                        animType: AnimType.BOTTOMSLIDE,
                        title: '',
                        desc: 'هناك خطا بالاتصال',
                        descTextStyle: FCITextStyle.bold(16,color: Colors.red),
                        dialogType: DialogType.ERROR,
                        dismissOnTouchOutside: true
                    )..show();
                  }
                });
              },
              child: data(Icons.whatsapp,FCIColors.buttonGreen(),'Whatsapp','(+971)508088648',context)),
        ],
      ),
    );
  }
 final String phoneNumber='+971508088648';
  Widget data(icon,color,title,data,context){
    return Container(
      decoration: BoxDecoration(
          color: FCIColors.accentColor(),
          borderRadius: BorderRadius.circular(15)
      ),
      height: FCISize.height(context)*0.18,
      width:  FCISize.width(context)*0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon,color: color,size: ScreenUtil().setSp(40),),
          Text(title,style: FCITextStyle.bold(16),),
          Text(data,style: FCITextStyle.normal(14),),
        ],
      ),
    );
  }
}

