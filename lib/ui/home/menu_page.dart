import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/ui/profile/profile_controller.dart';
import 'package:reussite_io_new/widget/input_with_level.dart';
import 'package:reussite_io_new/widget/manu_tile.dart';
import 'package:reussite_io_new/widget/selection_dropdown.dart';

class MenuPage extends StatefulWidget{

  @override
  _MenuPage createState()=>_MenuPage();
}

class _MenuPage extends State<MenuPage>{

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
             padding: const EdgeInsets.only(top: 45,left: 15,right: 15,bottom: 10),
             child: Row(
               children: [
                 InkWell(
                   onTap: ()=>Navigator.pop(context),
                   child: Icon(
                     Icons.arrow_back,
                     size: 30,
                     color: PsColors.mainColor,
                   ),
                 ),
                 Expanded(child:const SizedBox()),

                 InkWell(
                   onTap: (){
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
           Expanded(child:  Padding(
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
                         color: PsColors.mainColor
                     ),
                   ),


                   const SizedBox(
                     height: 55,
                   ),

                   Row(
                     children: [

                       Container(
                         height: 60,
                         width: 60,
                         margin: const EdgeInsets.only(
                             right: 10
                         ),
                         decoration: BoxDecoration(
                             color: PsColors.light_green,
                             borderRadius: BorderRadius.circular(7)
                         ),
                         padding: const EdgeInsets.all(10),
                         child: Image.asset(
                             'assets/icons/profile_pic_icon.png'
                         ),
                       ),

                       Text(
                         'add_child_avater'.tr,
                         style: GoogleFonts.notoSans(
                             color: PsColors.toolTitleColor,
                             fontWeight: FontWeight.w500,
                             fontSize: 14
                         ),
                       )

                     ],
                   ),
                   const SizedBox(
                     height: 30,
                   ),

                   MenuLevel(
                     levelValue: 'help'.tr,
                     onTap: (){
                       Get.offNamedUntil(Routes.HELP, (route) => true);
                     },
                   ),
                   MenuLevel(
                     levelValue: 'about'.tr,
                     onTap: (){
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
           ),)
         ],
       ),
     );
  }
}