import 'package:aharconnect/view/screen/authentication/screens/log_in_screen.dart';
import 'package:aharconnect/view/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final int splashDuration = 5;
  // AuthBloc? authBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: ListView(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40.0,
        ),
        Align(
          alignment: Alignment.center,
          // padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'stay_connected_with_your_community'.tr,
            textAlign: TextAlign.center,
            style:
                GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "${'protect'.tr} | ${'empower'.tr} | ${'grow'.tr}",
            textAlign: TextAlign.center,
            style:
            GoogleFonts.openSans(fontSize: 18,
                color: ThemeColors.greyTextColor,
                fontWeight: FontWeight.w500),
          ),
        ),
        Image.asset(
          'assets/community.png',
          fit: BoxFit.cover,
          height: 400.0,
        ),
        // SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0,top: 20.0),
          child: AppButton(
            onPressed: () async {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LogInScreen()));
            },
            height: 60,
            width: MediaQuery.of(context).size.width,
            text: Text(
              'login'.tr,
              style: GoogleFonts.openSans(
                  color: ThemeColors.buttonColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            loading: true,
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: ThemeColors.buttonColor, width: 1),
              backgroundColor: Colors.white,
              // color:Colors.red,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
            ),
          ),
        ),
      ],
    ));
  }


}
