import 'package:flutter/material.dart';
import 'package:aharconnect/providers/settings_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SettingsThemeButton extends StatelessWidget {
  const SettingsThemeButton(
      {Key? key, required this.onTap, required this.kGreyColorShade})
      : super(key: key);
  final Function()? onTap;
  final Color kGreyColorShade;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: MediaQuery.of(context).size.height / 14,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Theme',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: kGreyColorShade,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: AnimatedCrossFade(
                firstChild: SvgPicture.asset(
                  'assets/sun.svg',
                  color: Colors.white,
                ),
                secondChild: SvgPicture.asset(
                  'assets/moon.svg',
                  color: Colors.black,
                ),
                crossFadeState: settingsManager.darkMode == true
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 450),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
