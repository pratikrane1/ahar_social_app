import 'package:aharconnect/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  String? termsAndConditionString;

  @override
  void initState() {
    super.initState();
    Get.find<MyProfileController>().getPolicy("Terms and Conditions");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.whiteColor,
          leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
          ),
          title: Text(
            'Terms & Conditions'.tr,
            maxLines: 2,
            style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
              color: ThemeColors.blackColor
                ),
          ),
          centerTitle: false,
          elevation: 0.0,
          bottomOpacity: 0.0,
        ),
        body: GetBuilder<MyProfileController>(builder: (myAccountController) {
          termsAndConditionString = myAccountController.legalPolicies;
          return termsAndConditionString!.isNotEmpty ?
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  // color: ThemeColors.greyTextColor.withOpacity(0.13),
                ),
                child: Html(
                  data: termsAndConditionString,
                ),
              ),
            ),
          )
              : const Center(
            child: CircularProgressIndicator(color: ThemeColors.primaryColor,),
          );

        }
        ));
  }
}
