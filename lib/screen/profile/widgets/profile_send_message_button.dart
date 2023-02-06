import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialrecipe/utils/app_pages.dart';
import 'package:socialrecipe/utils/constants.dart';
import 'package:socialrecipe/src/models/user_model.dart';
import 'package:socialrecipe/providers/message_provider.dart';
import 'package:socialrecipe/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileSendMessageButton extends StatelessWidget {
  const ProfileSendMessageButton({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final UserModel? currentUser = userProvider.getUser;
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    return IconButton(
      iconSize: 60,
      onPressed: () async {
        Navigator.pushNamed(
          context,
          AppPages.chatPath,
          arguments: user,
        );

        await messageProvider.createUserChatCollection(
          receiverUser: user,
          currentUser: currentUser!,
        );
      },
      splashRadius: 20,
      icon: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.9),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.facebookMessenger,
            color: kOrangeColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
