import 'dart:async';
import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/screen/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/screen/walkthrough/walkthrough.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final int splashDuration = 5;
  // AuthBloc? authBloc;

  @override
  void initState() {
    startTime();
    super.initState();
  }

  startTime() async {
    return Timer(await Duration(seconds: splashDuration), () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _route();
    });
  }

  _route() {
    if (Get.find<AuthController>().getUserToken() != null) {
      var token = Get.find<AuthController>().getUserToken();
      print("Brearer Token: $token");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WalkThroughScreen()));    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.splash),
          fit: BoxFit.fill,
          // fit: BoxFit.cover,
    ),
    ),
    ));
    //     StreamBuilder<User?>(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         // child: CircularProgressIndicator(),
    //         child: Container(
    //           decoration:  BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage(Images.splash),
    //               // fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return const ErrorScreen();
    //     } else if (snapshot.data == null) {
    //       if (onboardingBox?.get(1) ?? false) {
    //         return const LogInScreen();
    //       }
    //       return const LogInScreen();
    //     }
    //     return const HomeScreen();
    //   },
    // ));
  }
}
