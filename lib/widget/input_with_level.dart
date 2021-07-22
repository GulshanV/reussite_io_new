import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';

class InputLevel extends StatelessWidget{
  final String hint;
  final Function(String) onChange;
  final Widget prefix;
  final Widget postfix;
  final FontStyle fontStyle;
  final bool hideText;
  final bool enable;
  final bool atuoFocus;
  final TextInputType inputType;
  final EdgeInsetsGeometry margin;
  final TextCapitalization textCapitalization;
  final int maxLenth;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;

  InputLevel({this.hint,this.inputFormatters,this.atuoFocus=false,this.controller,this.enable=true,this.maxLenth,this.onChange,this.margin,this.prefix,this.postfix,this.fontStyle,this.hideText=false,this.inputType,this.textCapitalization});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: margin??const EdgeInsets.only(top:15.0,bottom: 0,left: 20,right: 20),
      decoration: BoxDecoration(
        color: PsColors.white,
        borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: PsColors.borderlineColor,
              width: 1
          )
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller:controller==null?controller: new TextEditingController.fromValue(new TextEditingValue(text: controller.text,selection: new TextSelection.collapsed(offset:  controller.text.length))),
              onChanged: (v){
                if(onChange!=null){
                  onChange(v);
                }


              },
              decoration: InputDecoration(
                  border:  InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 20,right: 0,top: 15,bottom: 15),
                  hintText: hint??'',
                  enabled: enable,
                  prefixIcon: prefix,
                  hintStyle:  fontStyle??TextStyle(
                      fontWeight: FontWeight.w600,
                      color: PsColors.hintColor,
                      fontStyle: FontStyle.normal,
                      fontSize: 15
                  ),
                  counterText: ""
              ),
              obscureText: hideText,
              style: fontStyle??TextStyle(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: PsColors.black,
                  fontSize: 16
              ),
              keyboardType: inputType??TextInputType.text,
              textCapitalization: textCapitalization??TextCapitalization.none,
              inputFormatters:inputFormatters,
              maxLength: maxLenth ,
              autofocus: atuoFocus,

            ),
          ),
          Text(
            hint??'',
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                color: PsColors.hintColor,
                fontSize: 10
            ),
          ),
          const SizedBox(
            width: 7,
          )
        ],
      ),
    );
  }
}