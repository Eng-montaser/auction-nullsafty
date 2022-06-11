import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProfileTextField extends StatelessWidget {
  final String hintText;
   IconData? icon;
  final bool obsecure;
  final bool enabled;
  final Widget? suffixicon;
  final TextEditingController? controller;
  final String? initial;
  final int minLines; //Normal textInputField will be displayed
  final int maxLines;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validate;
  final TextInputType inputType;
  final double width;
  final Function onTap;
  final Function onEditingComplete;
    ProfileTextField(
      {Key? key,
        this.hintText='',
        this.icon = null,
        this.validate = null,
        this.suffixicon = null,
        this.obsecure = false,
        this.enabled = true,
        this.onChanged,
        this.inputType = TextInputType.text,
        this.initial = null,
        this.focusNode,
        this.controller,
        this.minLines = 1,
        this.maxLines = 1,
        this.width=0,
        required this.onTap,
        required this.onEditingComplete
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   Container(
      width:width==0? FCISize.width(context):width,
      height: ScreenUtil().setHeight(45),
      padding: EdgeInsets.symmetric(
          horizontal:FCIPadding.textFieldPaddingHorizontal,
          // vertical:FCIPadding.textFieldPaddingVertical
    ),
      margin: EdgeInsets.symmetric(horizontal:FCIPadding.textFieldPaddingHorizontal,
          vertical:FCIPadding.textFieldPaddingVertical ),
      decoration: BoxDecoration(
          color: FCIColors.accentColor(),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: FCIColors.textFieldHintGrey()
          )
      ),
      child:TextFormField(
        onTap: (){
          onTap();
        },
        onEditingComplete: (){
          onEditingComplete();
        },
        enabled: enabled,
        enableInteractiveSelection: true,
        controller: controller,
        keyboardType: inputType,
        validator: validate,
        initialValue: initial,
        obscureText: obsecure,
        onChanged: onChanged,
        maxLines: maxLines,
        minLines: minLines,
        focusNode: focusNode,
        decoration: new InputDecoration(
          hintText: hintText,
          hintStyle: focusNode == null
              ? FCITextStyle.normal(16,color: FCIColors.textFieldHintGrey())
              : FCITextStyle.normal(16,color: Colors.red),
          labelStyle: FCITextStyle.normal(16),
          border: InputBorder.none,
        ),
        // onChanged: onSearchTextChanged,
      ),
    );
  }
}
