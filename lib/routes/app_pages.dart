import 'package:get/get.dart';
import 'package:reussite_io_new/bindings/auth_binding.dart';
import 'package:reussite_io_new/ui/add_child/addnewchild.dart';
import 'package:reussite_io_new/ui/add_child/edit_child.dart';
import 'package:reussite_io_new/ui/country/country_page.dart';
import 'package:reussite_io_new/ui/datepicker/reservation_date_picker.dart';
import 'package:reussite_io_new/ui/help/help_list.dart';
import 'package:reussite_io_new/ui/help/support.dart';
import 'package:reussite_io_new/ui/help/support_request.dart';
import 'package:reussite_io_new/ui/home/home_page.dart';
import 'package:reussite_io_new/ui/home/menu_page.dart';
import 'package:reussite_io_new/ui/login/login_page.dart';
import 'package:reussite_io_new/ui/notification/notification_page.dart';
import 'package:reussite_io_new/ui/personal_details/name_profile_pic.dart';
import 'package:reussite_io_new/ui/profile/edit_profile.dart';
import 'package:reussite_io_new/ui/reservation/add_reservation.dart';
import 'package:reussite_io_new/ui/splash/splash.dart';
import 'package:reussite_io_new/ui/verify/verification_page.dart';
import 'package:reussite_io_new/ui/welcome/welcome.dart';
import 'app_routes.dart';
// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: Routes.SPLASH,
        page: () => Splash(),

    ),
    GetPage(
        name: Routes.WELCOME,
        page: () => WelComePage(),

    ),
    GetPage(
        name: Routes.HELP,
        page: () => HelpListPage(),

    ),
    GetPage(
      
        name: Routes.EDIT_CHILD,
        page: (){
          return  EditChild();
         }

    ),
    GetPage(
        name: Routes.SUPPORT_REQUEST,
        page: () => SupportRequest(),
    ),
    GetPage(
        name: Routes.HOME,
        page: () => HomePage(),

    ),
    GetPage(
        name: Routes.NOTIFICATION,
        page: () => NotificationPage(),

    ),
    GetPage(
        name: Routes.SUPPORT_PAGE,
        page: () => SupportPage(),

    ),
    GetPage(
        name: Routes.RESERVATION_DATETIME,
        page: () => ReservationDatePicker(),

    ),
    GetPage(
        name: Routes.ADD_RESERVATION,
        page: () => AddNewReservation(),

    ),
    GetPage(
        name: Routes.EDIT_PROFIE,
        page: () => EditProfile(),

    ),
    GetPage(
        name: Routes.MENU,
        page: () => MenuPage(),

    ),
    GetPage(
        name: Routes.ADD_NEW_CHILD,
        page: () => AddNewChild(),


    ),
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginPage(),
        binding: AuthBinding(),
        children: [
          GetPage(
            name: Routes.COUNTRY,
            page: () => CountryPage(),
          ),
          GetPage(
            name: Routes.OTP_VERIFY,
            page: () => VerificationPage(),
          ),
          GetPage(
            name: Routes.ADD_NAME_PIC,
            page: () => AddNameandProfilePicture(),
          ),
        ]),
  ];
}