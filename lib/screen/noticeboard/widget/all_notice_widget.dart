import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aharconnect/providers/user_provider.dart';
import 'package:aharconnect/screen/noticeboard/widget/notice_post_card.dart';
import 'package:aharconnect/src/models/message.dart';
import 'package:aharconnect/screen/chat/widgets/my_message_bubble.dart';
import 'package:aharconnect/screen/chat/widgets/sender_message_bubble.dart';
import 'package:aharconnect/src/models/user_model.dart';
import 'package:aharconnect/static_data.dart';

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
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemCount: Data().noticeBoardList!.length,
        itemBuilder: ((context, index) {
          return NoticePostCard(noticeBoardData: Data().noticeBoardList![index],);
        }),
      ),
    );
  }
}

class NoticeBoardModel{
  String? userName;
  String? zoneName;
  String? userImage;
  String? postText;
  String? pdfText;

  NoticeBoardModel({required this.userName,
    required this.postText, required this.zoneName,required this.userImage,required this.pdfText});
}