import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'input.dart';

class MobileWidget extends StatefulWidget{
final TextEditingController phoneNumberController;
final Function(CountryCode) onTapCountry;
MobileWidget({this.phoneNumberController,this.onTapCountry});

@override
  _MobileWidget createState()=>_MobileWidget();

}

class _MobileWidget extends State<MobileWidget>{

  @override
  void initState() {
    super.initState();
    updatePlaceholderHint();
  }


  var globalPhoneType = PhoneNumberType.mobile;
  var globalPhoneFormat = PhoneNumberFormat.international;
  var currentSelectedCountry = CountryWithPhoneCode.us();

  var placeholderHint = '';


  void updatePlaceholderHint() {
    String newPlaceholder;

    if (globalPhoneType == PhoneNumberType.mobile) {
      if (globalPhoneFormat == PhoneNumberFormat.international) {
        newPlaceholder = currentSelectedCountry.exampleNumberMobileInternational ?? '';
      } else {
        newPlaceholder = currentSelectedCountry.exampleNumberMobileNational ?? '';
      }
    } else {
      if (globalPhoneFormat == PhoneNumberFormat.international) {
        newPlaceholder = currentSelectedCountry.exampleNumberFixedLineInternational ?? '';
      } else {
        newPlaceholder = currentSelectedCountry.exampleNumberFixedLineNational ?? '';
      }
    }
    setState(() => placeholderHint = newPlaceholder);
  }


  @override
  Widget build(BuildContext context) {

      return Row(
        children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: PsColors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              children: [
                Expanded(
                  child: CountryCodePicker(
                    onChanged: (e){
                    updatePlaceholderHint();
                    widget.onTapCountry(e);
                    } ,
                    initialSelection: 'TF',
                    showCountryOnly: false,
                    flagWidth: 20,
                    showFlag: true,
                    padding: const EdgeInsets.all(0),
                    showOnlyCountryWhenClosed: false,
                    favorite: ['+39', 'FR'],
                  )
                ),

              ],
            ),
          ),

          Expanded(child:Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                  controller: widget.phoneNumberController,
                  inputFormatters: [
                    LibPhonenumberTextFormatter(
                      phoneNumberType: globalPhoneType,
                      phoneNumberFormat: globalPhoneFormat,
                      country: currentSelectedCountry,
                      hideCountryCode: true,
                      additionalDigits: 3,
                    ),
                  ],
                  autocorrect: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: PsColors.black,
                      fontSize: 16
                  ),
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                      hintText:'mobile_number'.tr,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: PsColors.hintColor,
                          fontStyle: FontStyle.normal,
                          fontSize: 15
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border:InputBorder.none,
                      errorMaxLines: 1
                  )
              ),
            ),
          )

          )
        ],
      );
  }
}

class UpperCaseTextFormatter implements TextInputFormatter {

  const UpperCaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text?.toUpperCase(), selection: newValue.selection);
  }

}