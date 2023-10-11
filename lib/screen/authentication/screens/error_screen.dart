import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            FaIcon(
              FontAwesomeIcons.circleExclamation,
              color: Colors.red,
              size: 40,
            ),
            Text(
              'error_occurred'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
