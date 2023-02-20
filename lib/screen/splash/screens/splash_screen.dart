import 'dart:async';
import 'package:flutter/material.dart';
import 'package:socialrecipe/screen/walkthrough/walkthrough.dart';
import 'package:socialrecipe/utils/images.dart';
import 'package:flutter/services.dart';

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
      // authBloc = BlocProvider.of<AuthBloc>(context);
      //  authBloc!.add(OnAuthCheck());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WalkThroughScreen()));
    });
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
