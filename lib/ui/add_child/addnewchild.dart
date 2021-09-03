import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/widget/button_green.dart';
import 'package:reussite_io_new/widget/input_with_level.dart';
import 'package:reussite_io_new/widget/mobile_widget.dart';
import 'package:reussite_io_new/widget/selection_dropdown.dart';

class AddNewChild extends StatefulWidget {
  @override
  _AddNewChild createState() => _AddNewChild();
}

class _AddNewChild extends State<AddNewChild> {
  final AuthController controller = Get.put(AuthController());

  String fullName = '';
  String school = '';
  String board = '';
  String phone = '';
  String email = '';
  String level;

  @override
  void initState() {
    super.initState();
  }


  CountryCode country=CountryCode(
      code: 'IO',
      dialCode: '+246'
  );


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
    return Scaffold(
      backgroundColor: PsColors.white,
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 45, left: 15, right: 15, bottom: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: PsColors.mainColor,
                      )),
                ),
                Expanded(child: const SizedBox()),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'add_you_child'.tr,
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 33,
                          color: PsColors.mainColor),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: PsColors.mainColor),
                            padding: const EdgeInsets.all(2),
                            child: _pickImage == null
                                ? Image.asset(
                                    'assets/icons/profile_pic_icon.png',
                                    height: 50,
                                    width: 50,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.file(
                                      _pickImage,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                          ),
                        ),
                        Text(
                          'add_child_avater'.tr,
                          style: GoogleFonts.notoSans(
                              color: PsColors.toolTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InputLevel(
                      margin: const EdgeInsets.all(0),
                      hint: 'full_name'.tr,
                      onChange: (v) {
                        fullName = v;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputLevel(
                      margin: const EdgeInsets.all(0),
                      hint: 'school_name'.tr,
                      onChange: (v) {
                        school = v;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputLevel(
                      margin: const EdgeInsets.all(0),
                      hint: 'school_board'.tr,
                      onChange: (v) {
                        board = v;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SelectionDropdown(
                      hint: 'level_of_study'.tr,
                      levelValue: level,
                      onTap: () async {
                        var ind = await showModalBottomSheet(
                            context: context,
                            builder: (context) => ListView(
                                  padding: const EdgeInsets.all(15),
                                  children: [
                                    Text(
                                      'Select your Study Level',
                                      style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                    Wrap(
                                      children: List.generate(
                                          12,
                                          (index) => InkWell(
                                                onTap: () {
                                                  Navigator.pop(context, index);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: PsColors
                                                                  .light_grey,
                                                              width: 1))),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${index + 1}',
                                                        style: GoogleFonts
                                                            .notoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                    )
                                  ],
                                ));
                        if (ind != null) {
                          setState(() {
                            level = '${ind + 1}';
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: PsColors.white,
                              borderRadius:
                              BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              right: 7,
                              left: 7),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CountryCodePicker(
                                    onChanged: (e) {
                                      selectedCountry = e.toString().replaceAll(new RegExp(r'[^\w\s]+'), '');
                                      _phoneNumberFormatter =
                                          _NumberTextInputFormatter(int.parse(selectedCountry));
                                      updatePlaceholderHint();
                                      setState(() {
                                        country=e;
                                      });
                                    },
                                    initialSelection: 'IO',
                                    showCountryOnly: true,
                                    flagWidth: 20,
                                    showFlag: true,
                                    padding: const EdgeInsets.all(0),
                                    showOnlyCountryWhenClosed: false,
                                    favorite: ['+1', 'US', '+246', 'IO', '+52', 'MX'],
                                  )
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: InputLevel(
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              _phoneNumberFormatter,
                            ],
                            inputType: TextInputType.number,
                            margin: const EdgeInsets.all(0),
                            hint: 'phone_number'.tr,
                            onChange: (v) {
                              phone = v;
                            },
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputLevel(
                      margin: const EdgeInsets.all(0),
                      hint: 'email'.tr,
                      onChange: (v) {
                        email = v;
                      },
                    ),

                    /* const SizedBox(
                    height: 30,
                  ),
                  SelectionDropdown(
                    hint: 'change_phone_no'.tr,
                    onTap: (){


                    },
                  ),*/
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Obx(() => controller.loginProcess.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : RaisedGradientButtonGreen(
                              margin: const EdgeInsets.all(0),
                              onPressed: () {
                                controller.validationCreateStudent(
                                    fullName,
                                    school,
                                    board,
                                    level,
                                    phone,
                                    email,
                                    _pickImage,
                                  country.dialCode
                                );
                              },
                              width: 200,
                              child: Text(
                                'create'.tr.toUpperCase(),
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: PsColors.white),
                                textAlign: TextAlign.center,
                              ),
                            )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromSource(source: ImageSource.gallery);
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromSource(source: ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var _pickImage;

  _imgFromSource({ImageSource source}) async {
    final XFile photo = await ImagePicker().pickImage(
        source: source, maxWidth: 500, maxHeight: 500, imageQuality: 50);
    setState(() {
      _pickImage = File(photo.path);
    });

    Navigator.of(context).pop();
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
