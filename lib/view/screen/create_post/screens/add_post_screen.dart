import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/view/screen/create_post/screens/create_post_screen.dart';
import 'package:aharconnect/view/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';


class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 22.0).copyWith(bottom: 94),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              child: Lottie.asset("assets/anim/recipe.json"),
            ),
            Text(
              'create_your_post'.tr,
              style: GoogleFonts.openSans(
                  fontSize: 25, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            const Spacer(),

            ///Add your post button
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
              child: AppButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateRecipePostScreen(
                                isFeed: true,
                              )));
                },
                height: 60,
                // width: MediaQuery.of(context).size.width,W
                text: Text(
                  'add_your_post'.tr,
                  style: GoogleFonts.openSans(
                      color: ThemeColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                loading: true,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                      color: ThemeColors.buttonColor, width: 1),
                  backgroundColor: ThemeColors.buttonColor,
                  // color:Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),

            ///Upload your notice
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
              child: AppButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateRecipePostScreen(
                                isFeed: false,
                              )));
                },
                height: 60,
                // width: MediaQuery.of(context).size.width,W
                text: Text(
                  'add_your_notice'.tr,
                  style: GoogleFonts.openSans(
                      color: ThemeColors.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                loading: true,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                      color: ThemeColors.buttonColor, width: 1),
                  backgroundColor: ThemeColors.whiteColor,
                  // color:Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
