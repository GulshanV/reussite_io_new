import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:reussite_io_new/controller/home_controller.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/ui/reservation/reservation_list.dart';

class HomePage extends GetView<HomeController>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 15,
              right: 20,
              left: 20
            ),
            child: Row(
              children: [
                InkWell(
                  onTap:(){
                    Get.offNamedUntil(Routes.MENU, (route) => true);
                  },
                  child: Image.asset(
                    'assets/icons/nav_profile.png',
                    height: 25,
                  ),
                ),

                Expanded(child: const SizedBox()),

                InkWell(
                  onTap: (){

                    Get.offNamedUntil(Routes.NOTIFICATION, (route) => true);
                  },
                  child: Image.asset(
                    'assets/icons/nav_notification.png',
                    height: 25,
                  ),
                )
              ],
            ),
          ),
          Expanded(child: Center(
            child: ReservationList(),
          ))

        ],
      ),
    );

  }

}