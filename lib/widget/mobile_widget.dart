import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/config/ps_color.dart';

class MobileWidget extends StatefulWidget {
  final TextEditingController phoneNumberController;
  final Function(CountryCode) onTapCountry;
  final String countryCodeInitil;
  MobileWidget({this.phoneNumberController, this.onTapCountry,this.countryCodeInitil});

  @override
  _MobileWidget createState() => _MobileWidget();
}

class _MobileWidget extends State<MobileWidget> {
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
        newPlaceholder =
            currentSelectedCountry.exampleNumberMobileInternational ?? '';
      } else {
        newPlaceholder =
            currentSelectedCountry.exampleNumberMobileNational ?? '';
      }
    } else {
      if (globalPhoneFormat == PhoneNumberFormat.international) {
        newPlaceholder =
            currentSelectedCountry.exampleNumberFixedLineInternational ?? '';
      } else {
        newPlaceholder =
            currentSelectedCountry.exampleNumberFixedLineNational ?? '';
      }
    }
    setState(() => placeholderHint = newPlaceholder);
  }

  _NumberTextInputFormatter _phoneNumberFormatter =
      _NumberTextInputFormatter(1);

  String selectedCountry = '1';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          decoration: BoxDecoration(
              color: PsColors.white, borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.only(right: 5),
          child: Row(
            children: [
              Expanded(
                  child: CountryCodePicker(
                onChanged: (e) {
                  selectedCountry = e.toString().replaceAll(new RegExp(r'[^\w\s]+'), '');
                  _phoneNumberFormatter =
                      _NumberTextInputFormatter(int.parse(selectedCountry));
                  print("country code ==========> $selectedCountry");
                  updatePlaceholderHint();
                  widget.onTapCountry(e);
                },
                initialSelection: widget.countryCodeInitil??'US',
                showCountryOnly: false,
                flagWidth: 20,
                showFlag: true,
                padding: const EdgeInsets.all(0),
                showOnlyCountryWhenClosed: false,
                favorite: ['+1', 'US', '+246', 'IO', '+52', 'MX'],
              )),
            ],
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextFormField(
                controller: widget.phoneNumberController,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  _phoneNumberFormatter,
                  // LengthLimitingTextInputFormatter(10),
                  // LibPhonenumberTextFormatter(
                  //   phoneNumberType: globalPhoneType,
                  //   phoneNumberFormat: globalPhoneFormat,
                  //   country: currentSelectedCountry,
                  //   hideCountryCode: true,
                  //   additionalDigits: 3,
                  // ),
                ],
                autocorrect: false,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: PsColors.black,
                    fontSize: 16),
                keyboardType: const TextInputType.numberWithOptions(signed: true),
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                    hintText: 'mobile_number'.tr,
                    counterText: '',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: PsColors.hintColor,
                        fontStyle: FontStyle.normal,
                        fontSize: 15),
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                    errorMaxLines: 1)),
          ),
        ))
      ],
    );
  }
}

class UpperCaseTextFormatter implements TextInputFormatter {
  const UpperCaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text?.toUpperCase(), selection: newValue.selection);
  }
}

class _NumberTextInputFormatter extends TextInputFormatter {
  int _whichNumber;
  _NumberTextInputFormatter(this._whichNumber);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    switch (_whichNumber) {
      case 1:
        {
          if (newTextLength >= 1) {
            newText.write('(');
            if (newValue.selection.end >= 1) selectionIndex++;
          }
          if (newTextLength >= 4) {
            newText.write(
                newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
            if (newValue.selection.end >= 3) selectionIndex += 2;
          }
          if (newTextLength >= 7) {
            newText.write(
                newValue.text.substring(3, usedSubstringIndex = 6) + '-');
            if (newValue.selection.end >= 6) selectionIndex++;
          }
          if (newTextLength >= 11) {
            newText.write(
                newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
            if (newValue.selection.end >= 10) selectionIndex++;
          }
          break;
        }
      case 91:
        {
          if (newTextLength >= 5) {
            newText.write(
                newValue.text.substring(0, usedSubstringIndex = 5) + ' ');
            if (newValue.selection.end >= 6) selectionIndex++;
          }
          break;
        }
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
