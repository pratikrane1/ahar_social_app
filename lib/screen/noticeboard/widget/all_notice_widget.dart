import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialrecipe/providers/user_provider.dart';
import 'package:socialrecipe/screen/noticeboard/widget/notice_post_card.dart';
import 'package:socialrecipe/src/models/message.dart';
import 'package:socialrecipe/screen/chat/widgets/my_message_bubble.dart';
import 'package:socialrecipe/screen/chat/widgets/sender_message_bubble.dart';
import 'package:socialrecipe/src/models/user_model.dart';

class AllNoticeScreen extends StatefulWidget {
  const AllNoticeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AllNoticeScreen> createState() => _AllNoticeScreenState();
}

class _AllNoticeScreenState extends State<AllNoticeScreen> {
 

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? userProvider =
        Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemCount: 5,
        itemBuilder: ((context, index) {
          return NoticePostCard();
        }),
      ),
    );
  }
}
