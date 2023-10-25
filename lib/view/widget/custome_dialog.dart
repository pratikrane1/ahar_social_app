import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/controller/localization_controller.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/view/screen/authentication/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_button.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.only(top: 10.0, bottom: 20, left: 10, right: 10),
            // margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: ThemeColors.whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                 Center(
                    child: Padding(
                  padding:const EdgeInsets.all(10.0),
                  child: Text(
                    "logout_from_ahar_connect".tr,
                    style:GoogleFonts.openSans(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.blackColor),
                  ),
                ) //
                    ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        height: 35,
                        width: 150,
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: AppButton(
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Get.find<LocalizationController>().setLanguage(Locale(
                              AppConstants.languages[0].languageCode,
                              AppConstants.languages[0].countryCode,
                            ));
                            Get.find<LocalizationController>().setSelectIndex(0);
                            Get.find<AuthController>().clearUserNumber();
                            Get.find<AuthController>().cleartoken();

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => LogInScreen()));
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          text:  Text(
                            'yes'.tr,
                            style:GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          loading: true,
                          color: ThemeColors.whiteColor,
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                color: ThemeColors.buttonColor, width: 1),
                            backgroundColor: ThemeColors.whiteColor,
                            // color:Colors.red,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 35,
                        width: 150,
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: AppButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          text:  Text(
                            'no'.tr,
                            style:GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          // loading: login is LoginLoading,
                          loading: true,
                          color: ThemeColors.whiteColor,
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                color: ThemeColors.buttonColor, width: 1),
                            backgroundColor: ThemeColors.primaryColor,
                            // color:Colors.red,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 15.0,
            top: 18.0,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.cancel, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}




