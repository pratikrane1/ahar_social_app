import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:aharconnect/utils/constants.dart';
import 'package:get/get.dart';

import '../../../utils/theme_colors.dart';

class AddRecipePostScreen extends StatelessWidget {
  const AddRecipePostScreen({Key? key}) : super(key: key);

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
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Poppins-Bold',
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: ThemeColors.buttonColor,
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, AppPages.createPostRecipePath);
                  },
                  child: Ink(

                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'add_your_post'.tr,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
