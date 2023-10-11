import 'package:flutter/material.dart';
import 'package:aharconnect/screen/noticeboard/widget/notice_post_card.dart';
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