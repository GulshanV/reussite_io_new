import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';

class InputLevel extends StatefulWidget {
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

  InputLevel({
    this.hint,
    this.inputFormatters,
    this.atuoFocus = false,
    this.controller,
    this.enable = true,
    this.maxLenth,
    this.onChange,
    this.margin,
    this.prefix,
    this.postfix,
    this.fontStyle,
    this.hideText = false,
    this.inputType,
    this.textCapitalization,
  });

  @override
  _InputLevel createState()=>_InputLevel();
}
class _InputLevel extends State<InputLevel>{
  bool showLable=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ??
          const EdgeInsets.only(top: 15.0, bottom: 0, left: 20, right: 20),
      decoration: BoxDecoration(
          color: PsColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: PsColors.borderlineColor, width: 1)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller == null
                  ? widget.controller
                  : new TextEditingController.fromValue(new TextEditingValue(
                      text: widget.controller.text,
                      selection: new TextSelection.collapsed(
                          offset: widget.controller.text.length))),
              onChanged: (v) {
                if (widget.onChange != null) {
                  widget.onChange(v);
                }
                setState(() {
                  showLable=v.length>0;
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 20, right: 0, top: 15, bottom: 15),
                  hintText: showLable?'':widget.hint ?? '',
                  enabled: widget.enable,
                  prefixIcon: widget.prefix,
                  hintStyle: widget.fontStyle ??
                      TextStyle(
                          fontWeight: FontWeight.w600,
                          color: PsColors.hintColor,
                          fontStyle: FontStyle.normal,
                          fontSize: 15),
                  counterText: ""),
              obscureText: widget.hideText,
              style: widget.fontStyle ??
                  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: PsColors.black,
                      fontSize: 16),
              keyboardType: widget.inputType ?? TextInputType.text,
              textCapitalization: TextCapitalization.words,
              // textCapitalization: textCapitalization ?? TextCapitalization.none,
              inputFormatters: widget.inputFormatters,
              maxLength: widget.maxLenth,
              autofocus: widget.atuoFocus,
            ),
          ),
          Text(
            showLable?widget.hint ?? '':'',
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                color: PsColors.hintColor,
                fontSize: 10),
          ),
          const SizedBox(
            width: 7,
          )
        ],
      ),
    );
  }
}
