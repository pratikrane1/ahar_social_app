import 'package:aharconnect/view/screen/bottom%20nav%20bar/bottom_nav.dart';
import 'package:aharconnect/view/screen/home/widget/post_detail_widget.dart';
import 'package:aharconnect/view/screen/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String walkThrough = '/walkThrough';
  static const String login = '/login';
  static const String otpVerify = '/otpVerify';
  static const String welcome = '/welcome';
  static const String postDetail = '/postDetail';


  static String getInitialRoute(String index) => '$initial?index=$index';
  static String getSplashRoute(String title) {
    return '$splash?title=$title';
  }

  static String getWalkThroughRoute() => '$walkThrough';
  static String getLoginRoute() {
    return '$login';
  }

  static String getOtpVerifyRoute(
    String number,
    String countryCode,
    String token,
  ) {
    return '$otpVerify?number=$number&country_code=$countryCode&token=$token';
  }

  static String getWelcomeRoute() => '$welcome';

  static String getPostDetailRoute(String postId, String zoneId) {
    return '$postDetail?postId=$postId&zoneId=$zoneId';
  }

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          return BottomNavBar();
        }),
    GetPage(
        name: splash,
        page: () {
          return SplashScreen();
        }),
    GetPage(
        name: postDetail,
        page: () {
          return PostDetailScreen(
            postId: Get.parameters['postId'].toString(),
            zoneId: Get.parameters['zoneId'].toString(),
          );
        }),
  ];

  static getRoute(Widget navigateTo) {
    return navigateTo;
  }
}
