import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialrecipe/utils/app_pages.dart';
import 'package:socialrecipe/utils/constants.dart';

class ProfileMessageButton extends StatelessWidget {
  const ProfileMessageButton({Key? key, required this.userId})
      : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50,
      onPressed: () {
        Navigator.pushNamed(
          context,
          AppPages.contactsPath,
        );
      },
      splashRadius: 20,
      icon: CircleAvatar(
        backgroundColor:
            const Color.fromARGB(255, 244, 244, 246).withOpacity(0.9),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.facebookMessenger,
            color: kOrangeColor,
            size: 40,
          ),
        ),
      ),
    );
  }
}
