import 'dart:convert';
import 'package:aharconnect/screen/home/screens/home_screen.dart';
import 'package:aharconnect/screen/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String walkThrough = '/walkThrough';
  static const String login = '/login';
  static const String otpVerify = '/otpVerify';
  static const String welcome = '/welcome';
  static const String bottomNav = '/bottomNav';
  static const String allApp = '/allApp';
  static const String helpCentre = '/helpCentre';
  static const String customerSupport = '/customerSupport';
  static const String privacyPolicy = '/privacyPolicy';
  static const String termsConditions = '/termsConditions';
  static const String refer = '/refer';
  static const String referList = '/refer_list';
  static const String myAccount = '/myAccount';
  static const String myAccountEdit = '/myAccountEdit';
  static const String nomineeDetailsEdit = '/nomineeDetailsEdit';
  static const String search = '/search';
  static const String videoScreen = '/videoScreen';
  static const String galleryVideoScreen = '/galleryVideoScreen';
  static const String membershipScreen = '/membershipScreen';
  static const String coupanScreen = '/coupanScreen';
  static const String myPayoutScreen = '/myPayoutScreen';
  static const String regularPayoutScreen = '/regularPayoutScreen';
  static const String autoPullPayoutScreen = '/autoPullPayoutScreen';
  static const String myAutoPullReferalScreen = '/myAutoPullReferalScreen';
  static const String language = '/language';
  static const String image = '/image';
  static const String membershipDetail = '/membershipDetail';
  static const String referralSearch = '/referralSearch';

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

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          return HomeScreen();
        }),
    GetPage(
        name: splash,
        page: () {
          return SplashScreen();
        }),
  ];

  static getRoute(Widget navigateTo) {
    return navigateTo;
  }
}
