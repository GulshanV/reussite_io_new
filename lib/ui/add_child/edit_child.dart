import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
      controller
          .updateChildInformation(
              controller.student.value.id,
              controller.student.value.parentId,
              fullName.text,
              school.text,
              board.text,
              "1",
              phone.text,
              email.text)
          .then((value) {
        controller.edit();
        controller.getChildInformation();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller.getChildInformation().then((value) {
      setState(() {
        fullName.text = controller.student.value.firstName +
            " " +
            controller.student.value.lastName;
        school.text = controller.student.value.schoolName;
        board.text = controller.student.value.schoolBoard;
        email.text = controller.student.value.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsColors.white,
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 60, left: 15, right: 15, bottom: 10),
            child: Row(children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: PsColors.mainColor,
                ),
              ),
              Expanded(child: const SizedBox()),
              Obx(
                () => controller.isEdit.value
                    ? InkWell(
                        onTap: () {
                          // print("School ==========> $school");
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
                        child: Icon(
                          Icons.edit,
                          size: 30,
                          color: PsColors.mainColor,
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
                              Container(
                                height: 60,
                                width: 60,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: PsColors.light_grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset('assets/dummy/squircle.png'),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
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
                                    borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.all(5),
                                child: Image.asset('assets/images/link.png'),
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
                                  // controller: TextEditingController(
                                  //     text: controller.student.value.firstName +
                                  //             " " +
                                  //             controller
                                  //                 .student.value.lastName ??
                                  //         ''),
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
                            hint: 'level_of_study'.tr,
                            levelValue:
                                controller.student.value.grade.toString() ?? '',
                            onTap: () {},
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              controller.isEdit.value
                                  ? Container(
                                      width: 70,
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
                                            child: Text(
                                              '+123',
                                              style: GoogleFonts.notoSans(
                                                  fontSize: 16,
                                                  color: PsColors.black,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 1,
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Expanded(
                                child: InputLevel(
                                  inputFormatters: [
                                    const UpperCaseTextFormatter(),
                                    MaskTextInputFormatter(
                                        mask: "(###) ###-##-##")
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
                          Padding(
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
                          ),
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
