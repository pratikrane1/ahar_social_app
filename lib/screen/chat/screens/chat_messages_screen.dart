import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialrecipe/utils/constants.dart';
import 'package:socialrecipe/src/models/message.dart';
import 'package:socialrecipe/src/models/user_model.dart';
import 'package:socialrecipe/screen/chat/widgets/chat_messages.dart';
import 'package:socialrecipe/providers/message_provider.dart';
import 'package:socialrecipe/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:socialrecipe/utils/theme_colors.dart';

class ChatMessagesScreen extends StatefulWidget {
  const ChatMessagesScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  final TextEditingController _sendMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void dispose() {
    _sendMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: settingsManager.darkMode ? Colors.white : Colors.black,
            size: 24,
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: Text(
          widget.user.userName,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 18,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //color: Color(0xffc32c37),
                  color: ThemeColors.msgFieldColor,
                ),
                child: InkWell(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Center(
                          child: Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 20,
                      )),
                    ],
                  ),
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: ChatMessages(
                scrollController: _scrollController,
                userId: widget.user.id,
                currentUserId: FirebaseAuth.instance.currentUser!.uid,
              ),
            ),
          ),
          // Text Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              controller: _sendMessageController,
              cursorColor: kOrangeColor,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              minLines: null,
              maxLines: null,
              decoration: InputDecoration(
                counterText: ' ',
                prefixIcon: IconButton(
                  splashRadius: 20,
                  onPressed: () async {},
                  icon: Container(
                    decoration: BoxDecoration(
                      // color: ThemeColors.textFieldBackgroundColor,
                      border:
                          Border.all(color: ThemeColors.blackColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(
                              15.0) //                 <--- border radius here
                          ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: ThemeColors.blackColor,
                    ),
                  ),
                ),
                suffixIcon: Container(
                  child: IconButton(
                    splashRadius: 20,
                    onPressed: () async {
                      // !: Send message.
                      if (_sendMessageController.text.isNotEmpty) {
                        final message = Message(
                          receiverId: widget.user.id,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          messageText: _sendMessageController.text,
                          sentAt: DateTime.now(),
                          isSeen: false,
                          // type: MessageEnum.text,
                        );
                        messageProvider.sendMessage(
                          message,
                          widget.user.id,
                          FirebaseAuth.instance.currentUser!.uid,
                        );
                        _sendMessageController.clear();
                        _scrollToBottom();
                      }
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.13,
                        decoration: BoxDecoration(
                          color: ThemeColors.blackColor,
                          border: Border.all(
                            color: ThemeColors.blackColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(
                                  15.0) //                 <--- border radius here
                              ),
                        ),
                        child: const Icon(
                          Icons.send_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                fillColor: settingsManager.darkMode ? kGreyColor : kGreyColor4,
                filled: true,
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(18).copyWith(right: 0),
                hintText: 'Write a message...',
                hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 15,
                      color: settingsManager.darkMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                focusedErrorBorder: kFocusedErrorBorder,
                errorBorder: kErrorBorder,
                enabledBorder: kEnabledBorder,
                focusedBorder: kFocusedBorder,
                border: kBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
