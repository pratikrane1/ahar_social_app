import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:aharconnect/utils/theme_colors.dart';

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
    // Get.find<MyAccountController>().getTermsAndConditions();
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
          // toolbarHeight: _width > 200 ? 120 : 100,
          backgroundColor: ThemeColors.whiteColor,
          // leadingWidth: MediaQuery.of(context).size.width,
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
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     IconButton(
          //       splashRadius: 20,
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       icon: const Icon(
          //         Icons.arrow_back,
          //         color: Colors.black,
          //         size: 24,
          //       ),
          //     ),
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 8.0),
          //         child: Text(
          //           'Terms and Conditions',
          //           style: Theme.of(context).textTheme.headline6!.copyWith(
          //             fontSize: 25,
          //             fontWeight: FontWeight.w600,
          //             fontFamily: 'Montserrat',
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          centerTitle: false,
          elevation: 0.0,
          bottomOpacity: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                // color: ThemeColors.greyTextColor.withOpacity(0.13),
              ),
              child: Html(
                data: "Terms And Conditions",
              ),
            ),
          ),
        ));
  }
}
