import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsAccountDetailsButton extends StatelessWidget {
  const SettingsAccountDetailsButton({
    Key? key,
    required this.kGreyColorShade,
    required this.arrowForwardColor,
    required this.onTap,
  }) : super(key: key);
  final Color kGreyColorShade;
  final Color arrowForwardColor;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: MediaQuery.of(context).size.height / 14,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Account'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: kGreyColorShade),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: arrowForwardColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
