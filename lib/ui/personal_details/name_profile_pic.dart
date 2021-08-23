import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/button.dart';
import 'package:reussite_io_new/widget/hide_button.dart';
import 'package:reussite_io_new/widget/input.dart';

class AddNameandProfilePicture extends StatefulWidget {
  @override
  _AddNameandProfilePictureState createState() =>
      _AddNameandProfilePictureState();
}

class _AddNameandProfilePictureState extends State<AddNameandProfilePicture> {
  TextEditingController fullName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsColors.mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 60, left: 15, right: 20, bottom: 10),
                child: InkWell(
                  onTap: () {
                    // Get.offNamedUntil(Routes.HOME, (route) => true);
                  },
                  child: Text(
                    'skip'.tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        color: PsColors.white,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 25, right: 25),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/dot_bg.png',
                      ),
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'let_get_acquanted'.tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                        color: PsColors.white),
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
                        'add_an_avater'.tr,
                        style: GoogleFonts.notoSans(
                            color: PsColors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputWidget(
                    controller: fullName,
                    margin: const EdgeInsets.all(0),
                    hint: 'full_name'.tr,
                    onChange: (v) {
                      setState(() {
                        fullName.text = v;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: fullName.text == null || fullName.text == ''
                        ? RaisedGradientHideButton(
                            color: PsColors.hidebtnColor,
                            margin: const EdgeInsets.all(0),
                            onPressed: () {},
                            width: 120,
                            child: Text(
                              'next'.tr.toUpperCase(),
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: PsColors.black),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : RaisedGradientButton(
                            margin: const EdgeInsets.all(0),
                            onPressed: () {
                              Get.offNamedUntil(Routes.HOME, (route) => true);
                            },
                            width: 120,
                            child: Text(
                              'next'.tr.toUpperCase(),
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: PsColors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
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
