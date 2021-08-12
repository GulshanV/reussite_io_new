import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/ui/add_child/home_controller.dart';
import 'package:reussite_io_new/ui/datepicker/calender_with_subject.dart';
import 'package:reussite_io_new/ui/reservation/reservation_list.dart';

import '../../utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getChildList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: PsColors.white,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 50, bottom: 15, right: 20, left: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.offNamedUntil(Routes.MENU, (route) => true);
                      },
                      child: Image.asset(
                        'assets/icons/nav_profile.png',
                        height: 25,
                      ),
                    ),
                    Expanded(child: const SizedBox()),
                    controller.arrStudent.length == 0
                        ? const SizedBox()
                        : InkWell(
                            onTap: () async {
                              var value = await Get.offNamedUntil(
                                  Routes.ADD_RESERVATION, (route) => true);
                              if (value != null) {
                                Utils.successToast(
                                    'booking_create_successfully');
                                controller.getChildList();
                              }
                            },
                            child: SvgPicture.asset(
                              'assets/icons/plus.svg',
                              height: 25,
                            ),
                          ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.offNamedUntil(Routes.NOTIFICATION, (route) => true);
                      },
                      child: Image.asset(
                        'assets/icons/nav_notification.png',
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: controller.isLoading.value
                      ? Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : controller.arrStudent.length == 0
                          ? Center(
                              child: ReservationList(controller),
                            )
                          : BookListWithCalender(controller))
            ],
          ),
        ));
  }
}
