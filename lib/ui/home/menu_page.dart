import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/manu_tile.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPage createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  // final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    // controller.getParentDetails();
  }

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
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: PsColors.mainColor,
                  ),
                ),
                Expanded(child: const SizedBox()),
                InkWell(
                  onTap: () {
                    Get.offNamedUntil(Routes.EDIT_PROFIE, (route) => true);
                  },
                  child: Icon(
                    Icons.edit,
                    size: 30,
                    color: PsColors.mainColor,
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
                      'add_your_full_name'.tr,
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
                            // _showPicker(context);
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
                    MenuLevel(
                      levelValue: 'help'.tr,
                      onTap: () {
                        Get.offNamedUntil(Routes.HELP, (route) => true);
                      },
                    ),
                    MenuLevel(
                      levelValue: 'about'.tr,
                      onTap: () {
                        Get.offNamedUntil(Routes.SUPPORT_PAGE, (route) => true);
                      },
                    ),
                    MenuLevel(
                      levelValue: 'privacy_policy'.tr,
                    ),
                    MenuLevel(
                      levelValue: 'tc'.tr,
                    ),
                    MenuLevel(
                      levelValue: 'logout'.tr,
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
