import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/ui/profile/profile_controller.dart';
import 'package:reussite_io_new/widget/input_with_level.dart';

import '../../utils.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final ProfileController controller = Get.put(ProfileController());

  TextEditingController phoneNo = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();

  bool isLoading = true;

  String name;
  String phone;
  String emailId;

  @override
  void initState() {
    super.initState();
    controller.getParentDetails().then((value) {
      print(controller.model.value.phoneNumber);
      setState(() {
        isLoading = false;
        phoneNo.text = controller.model.value.phoneNumber;
        phone = controller.model.value.phoneNumber;
        name =
            '${controller.model.value.firstName} ${controller.model.value.lastName}';
        fullName.text =
            '${controller.model.value.firstName} ${controller.model.value.lastName}';
        email.text = controller.model.value.email;
        emailId = controller.model.value.email;
      });
    });
  }

  _updateProfile() {
    if (name.isEmpty) {
      Utils.errorToast('full_name_required'.tr);
    } else if (name.length < 3) {
      Utils.errorToast("full_name_min_length_error".tr);
    }
    if (phone.isEmpty) {
      Utils.errorToast('invalid_mobile_no'.tr);
    } else if (phone.length < 9) {
      Utils.errorToast('invalid_mobile_no'.tr);
    } else if (emailId.isEmpty) {
      Utils.errorToast('email_required'.tr);
    } else if (!AuthController.validateEmail(emailId)) {
      Utils.errorToast('email_invalid'.tr);
    } else {
      setState(() {
        isLoading = true;
      });
      print(emailId);
      controller.updateProfile(name, phone, emailId).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PsColors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 45, left: 15, right: 15, bottom: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 13.29,
                      width: 16.75,
                      child: Icon(
                        Icons.arrow_back,
                        color: PsColors.mainColor,
                      ),
                    ),
                  ),
                  Expanded(child: const SizedBox()),
                  isLoading
                      ? CircularProgressIndicator()
                      : InkWell(
                          onTap: () {
                            _updateProfile();
                          },
                          child: Text(
                            'save'.tr,
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w600,
                                color: PsColors.mainColor,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        )
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
                        'edit_profile'.tr,
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
                                // color: PsColors.light_green,
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                  image: _pickImage != null
                                      ? FileImage(_pickImage)
                                      : AssetImage(
                                          'assets/icons/profile_pic_icon.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              padding: const EdgeInsets.all(10),
                              // child: Image.asset('assets/icons/profile_pic_icon.png'),
                            ),
                          ),
                          Text(
                            'edit_child_avater'.tr,
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
                        controller: phoneNo,
                        margin: const EdgeInsets.all(0),
                        enable: false,
                        hint: 'phone_number'.tr,
                        onChange: (v) {
                          phone = v;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputLevel(
                        controller: fullName,
                        margin: const EdgeInsets.all(0),
                        hint: 'full_name'.tr,
                        onChange: (v) {
                          name = v;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputLevel(
                        controller: email,
                        margin: const EdgeInsets.all(0),
                        hint: 'email'.tr,
                        onChange: (v) {
                          emailId = v;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // SelectionDropdown(
                      //   hint: 'change_phone_no'.tr,
                      //   onTap: () {},
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
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
}
