import 'package:aharconnect/controller/localization_controller.dart';
import 'package:aharconnect/data/model/messages.dart';
import 'package:aharconnect/helper/route_helper.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'helper/get_di.dart' as di;
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  await FlutterDownloader.initialize();
  FlutterNativeSplash.remove();
  // if (Platform.isAndroid) {
  //   InAppUpdate.checkForUpdate().then((updateInfo) {
  //     if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
  //       //Logic to perform an update
  //       if (updateInfo.immediateUpdateAllowed) {
  //         // Perform immediate update
  //         InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
  //           if (appUpdateResult == AppUpdateResult.success) {
  //             //App Update successful
  //             showCustomSnackBar("App Updated.");
  //           }
  //         });
  //       }
  //     }
  //   });
  // }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  await di.init();
  Map<String, Map<String, String>> _languages = await di.init();
  String? fcmTitle;
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        fcmTitle = remoteMessage.notification!.title != null ? remoteMessage.notification!.title : null;
        // Get.find<NotificationController>().getFcmNotificationTitle(fcmTitle!);
        // print(fcmTitle);
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
      // handles
    }
  } catch (e) {}

  runApp(MyApp(
    languages: _languages,
    fcmTitle: fcmTitle ?? "",
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final String fcmTitle;
  MyApp({
    required this.languages,
    required this.fcmTitle,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // initializeDateFormatting();
    return GetBuilder<LocalizationController>(builder: (localizeController) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.APP_NAME,
        navigatorKey: Get.key,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: localizeController.locale,
        translations: Messages(languages: languages),
        fallbackLocale: Locale(AppConstants.languages[0].languageCode,
            AppConstants.languages[0].countryCode),
        initialRoute: RouteHelper.getSplashRoute(fcmTitle),
        getPages: RouteHelper.routes,
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      );
    });
  }
}
