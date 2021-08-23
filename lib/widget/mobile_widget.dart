import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'input.dart';

class MobileWidget extends StatelessWidget{
  final TextEditingController phoneNumberController;
  final Function(CountryCode) onTapCountry;
  MobileWidget({this.phoneNumberController,this.onTapCountry});

  @override
  Widget build(BuildContext context) {

      return Row(
        children: [
          Container(
            width: 80,
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
                    onChanged: (e) =>  onTapCountry(e),
                    initialSelection: 'TF',
                    showCountryOnly: false,
                    flagWidth: 20,
                    showFlag: false,
                    showFlagDialog: true,
                    showFlagMain: false,
                    padding: const EdgeInsets.all(0),
                    showOnlyCountryWhenClosed: false,
                    favorite: ['+39', 'FR'],
                  )
                ),

                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                )

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
                  controller: phoneNumberController,
                  inputFormatters: [const UpperCaseTextFormatter(),  MaskTextInputFormatter(mask: "(###) ###-##-##")],
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