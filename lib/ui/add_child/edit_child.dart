import 'dart:io';

import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/ui/add_child/update_child_controller.dart';
import 'package:reussite_io_new/utils.dart';
import 'package:reussite_io_new/widget/input_with_level.dart';
import 'package:reussite_io_new/widget/mobile_widget.dart';
import 'package:reussite_io_new/widget/selection_dropdown.dart';

class EditChild extends StatefulWidget {
  EditChild();

  @override
  _EditChild createState() => _EditChild();
}

class _EditChild extends State<EditChild> {
  final controller = Get.put(UpdateChildController());

  var fullName = TextEditingController();
  var school = TextEditingController();
  var board = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();

  bool isLoading = false;

  _updateProfile() {
    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (fullName.text.isEmpty) {
      Utils.errorToast('full_name_required'.tr);
    } else if (fullName.text.length < 5) {
      Utils.errorToast("full_name_min_length_error".tr);
    } else if (school.text.isEmpty) {
      Utils.errorToast('school_required'.tr);
    } else if (board.text.isEmpty) {
      Utils.errorToast('board_required'.tr);
    } else if (phone.text.isEmpty) {
      Utils.errorToast('invalid_mobile_no'.tr);
    } else if (email.text.isEmpty) {
      Utils.errorToast('email_required'.tr);
    } else if (!regExp.hasMatch(email.text)) {
      Utils.errorToast('email_invalid'.tr);
    } else {
      setState(() {
        isLoading = true;
      });
      controller
          .updateChildInformation(
              controller.student.value.id,
              controller.student.value.parentId,
              fullName.text,
              school.text,
              board.text,
              '$level',
          phone.text,
          country.dialCode,
              email.text)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        controller.edit();
        controller.getChildInformation();
      });
    }
  }

  String level;

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
  void initState() {
    _getcountryCode();
    super.initState();
    controller.getChildInformation().then((value) {
      setState(() {
        level = '${controller.student.value.grade}';
        fullName.text = controller.student.value.firstName +
            " " +
            controller.student.value.lastName;
        school.text = controller.student.value.schoolName;
        board.text = controller.student.value.schoolBoard;
        email.text = controller.student.value.email;
        phone.text = controller.student.value.phoneNumber??'';
        if(controller.student.value.countryCode!=null){
          selectedCountry= '${controller.student.value.countryCode}';
          country=CountryCode(
              dialCode: '+${controller.student.value.countryCode}'
          );
        }

      });
    });
  }

  String countryCode;

  _getcountryCode() {
    Utils.getCountryCode().then((v) {
      setState(() {
        countryCode = v;
      });
      print("Country Code ============> $countryCode");
    });
  }

  /// Image Picker ///

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
    final XFile photo = await ImagePicker().pickImage(source: source);
    setState(() {
      _pickImage = File(photo.path);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsColors.white,
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 45, left: 15, right: 30, bottom: 10),
            child: Row(children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);

                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: PsColors.mainColor,
                  )
              ),
              Expanded(child: const SizedBox()),
              Obx(
                () => controller.isEdit.value
                    ? isLoading
                        ? CircularProgressIndicator()
                        : InkWell(
                            onTap: () {
                              _updateProfile();
                            },
                            child: Text(
                              "save".tr,
                              style: GoogleFonts.notoSans(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: PsColors.mainColor),
                            ),
                          )
                    : InkWell(
                        onTap: () {
                          controller.edit();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 20,
                          width: 20,
                          child: Icon(
                            Icons.edit,
                            color: PsColors.mainColor,
                          ),
                        ),
                      ),
              )
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() => controller.isLoadInformation.value
                  ? Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${controller.student.value.firstName ?? ''}\n${controller.student.value.lastName ?? ''}',
                                style: GoogleFonts.notoSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 33,
                                    color: PsColors.mainColor),
                              ),
                              Expanded(child: const SizedBox()),
                              controller.isEdit.value
                                  ? InkWell(
                                      onTap: () {
                                        _showPicker(context);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: PsColors.light_grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: _pickImage != null
                                                ? FileImage(_pickImage)
                                                : AssetImage(
                                                    'assets/dummy/squircle.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        // child: Image.asset(),
                                      ),
                                    )
                                  : Container(
                                      height: 60,
                                      width: 60,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: PsColors.light_grey,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/dummy/squircle.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // child: Image.asset(),
                                    )
                            ],
                          ),
                          controller.isEdit.value
                              ? Container()
                              : const SizedBox(
                                  height: 15,
                                ),
                          controller.isEdit.value
                              ? Container()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'meet.appui.io/${controller.student.value.conferenceUrl ?? ''}',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          color: PsColors.meetLinkColor,
                                          fontSize: 12,
                                          decoration: TextDecoration.underline),
                                    )),
                                    Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                          color: PsColors.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: const EdgeInsets.all(5),
                                      child:
                                          Image.asset('assets/images/link.png'),
                                    )
                                  ],
                                ),
                          const SizedBox(
                            height: 30,
                          ),
                          controller.isEdit.value
                              ? InputLevel(
                                  enable: controller.isEdit.value,
                                  controller: fullName,
                                  margin: const EdgeInsets.all(0),
                                  hint: 'full_name'.tr,
                                  onChange: (v) {
                                    fullName.text = v;
                                  },
                                )
                              : Container(),
                          controller.isEdit.value
                              ? SizedBox(
                                  height: controller.isEdit.value ? 15 : 0,
                                )
                              : Container(),
                          // InputLevel(
                          //   enable: controller.isEdit.value,
                          //   controller: TextEditingController(
                          //       text:
                          //           controller.student.value.schoolName ?? ''),
                          //   margin: const EdgeInsets.all(0),
                          //   hint: 'school_name'.tr,
                          //   onChange: (v) {
                          //     fullName = v;
                          //   },
                          // ),
                          // SizedBox(
                          //   height: controller.isEdit.value ? 15 : 0,
                          // ),
                          InputLevel(
                            enable: controller.isEdit.value,
                            controller: school,
                            margin: const EdgeInsets.all(0),
                            hint: 'school_name'.tr,
                            onChange: (v) {
                              school.text = v;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InputLevel(
                            enable: controller.isEdit.value,
                            controller: board,
                            margin: const EdgeInsets.all(0),
                            hint: 'school_board'.tr,
                            onChange: (v) {
                              board.text = v;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SelectionDropdown(
                            subLevelValue: 'level_of_study'.tr,
                            hint: 'level_of_study'.tr,
                            levelValue: '${level ?? ''}',
                            onTap: () async {
                              if (controller.isEdit.value) {
                                var ind = await showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        ListView(
                                          padding: const EdgeInsets.all(15),
                                          children: [
                                            Text(
                                              'select_study_level'.tr,
                                              style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            Wrap(
                                              children: List.generate(
                                                  12,
                                                      (index) =>
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context, index);
                                                        },
                                                        child: Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(8.0),
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
                              }
                            }
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              controller.isEdit.value
                                  ? Container(
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
                                              enabled:false,
                                              onChanged: (e) {
                                                selectedCountry = e.toString().replaceAll(new RegExp(r'[^\w\s]+'), '');
                                                _phoneNumberFormatter =
                                                    _NumberTextInputFormatter(int.parse(selectedCountry));
                                                updatePlaceholderHint();
                                                setState(() {
                                                  country=e;
                                                });
                                              },
                                              initialSelection: countryCode??'IO',
                                              showCountryOnly: true,
                                              flagWidth: 20,
                                              showFlag: true,
                                              padding: const EdgeInsets.all(0),
                                              showOnlyCountryWhenClosed: false,
                                              favorite: ['+1', 'US', '+246', 'IO', '+52', 'MX'],
                                            )
                                          ),
                                          // Icon(
                                          //   Icons.keyboard_arrow_down,
                                          //   size: 16,
                                          // )
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Expanded(
                                child: InputLevel(
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    _phoneNumberFormatter,
                                  ],
                                  inputType: TextInputType.number,
                                  controller: phone,
                                  enable: controller.isEdit.value,
                                  margin: const EdgeInsets.all(0),
                                  hint: 'phone_number'.tr,
                                  onChange: (v) {
                                    phone.text = v;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InputLevel(
                            enable: controller.isEdit.value,
                            controller: email,
                            margin: const EdgeInsets.all(0),
                            hint: 'email'.tr,
                            onChange: (v) {
                              email.text = v;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        /*  controller.isEdit.value
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context, 1);
                                    },
                                    child: Text(
                                      'remove_child'.tr,
                                      style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.w600,
                                          color: PsColors.hintColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),*/
                        ],
                      ),
                    )),
            ),
          )
        ],
      ),
    );
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
