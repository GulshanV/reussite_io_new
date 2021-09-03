import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/manu_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPage createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  // final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: PsColors.mainColor,
                    )),
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
                      'settings'.tr,
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 33,
                          color: PsColors.mainColor),
                    ),
                    const SizedBox(
                      height: 30,
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
                      levelValue: 'my_profile'.tr,
                      onTap: () {
                        Get.offNamedUntil(Routes.EDIT_PROFIE, (route) => true);
                      },
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
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('login', '');
                          prefs.setString('token', '');
                          prefs.setString('countryCode', '');
                          Get.offNamedUntil(Routes.LOGIN, (route) => false);
                        }),
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
  String img64;
  _imgFromSource({ImageSource source}) async {
    final XFile photo = await ImagePicker().pickImage(
        source: source, maxWidth: 500, maxHeight: 500, imageQuality: 50);
    setState(() {
      _pickImage = File(photo.path);
      // img64 = base64Encode(_pickImage.readAsBytesSync());
      // fileName = _pickImage.path.split('/').last;
    });
    // sp.putString(SpUtil.UserImage, img64);
    // print("Image path ======> ${img64}");
    // _convertImage();
    Navigator.of(context).pop();
  }

  // var file;
  // _convertImage() {
  //   dynamic byteImage;
  //   setState(() {
  //     byteImage = base64Decode(sp.getString(SpUtil.UserImage));
  //     file = Io.File("decodedBezkoder.png");
  //     file.writeAsBytesSync(byteImage);
  //   });
  // }
}
