
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:socialrecipe/utils/theme_colors.dart';


// ignore: must_be_immutable
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  String? legalPolicy;

  @override
  void initState() {
    super.initState();
    // Get.find<MyAccountController>().getLegalAndPolicies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 100,
          backgroundColor: ThemeColors.whiteColor,
          // leadingWidth: 250,
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
              'privacy_policy'.tr,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
            ),
          centerTitle: false,
          elevation: 0.0,
          bottomOpacity: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all(Radius.circular(15)),
                // color: ThemeColors.greyTextColor.withOpacity(0.13),
              ),
              child: Html(
                data: "Privacy Policy",
              ),
            ),
          ),
        ));
  }
}
