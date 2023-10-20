import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';

import 'notice_post_card.dart';

class AllNoticeScreen extends StatefulWidget {
  AllNoticeScreen({required this.zoneId, required this.type, Key? key})
      : super(key: key);
  String zoneId;
  String type;

  @override
  State<AllNoticeScreen> createState() => _AllNoticeScreenState();
}

class _AllNoticeScreenState extends State<AllNoticeScreen> {
  List<PostData>? _postDataList;
  bool _isPostDataLoading = false;

  @override
  void initState() {
    super.initState();
    Get.find<ZoneController>().getNoticePostList(widget.zoneId, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ZoneController>(builder: (zoneController) {
        _postDataList = zoneController.noticePostDataList;
        _isPostDataLoading = zoneController.isPostDataLoading;
        return _isPostDataLoading
            ? _postDataList!.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: _postDataList!.length,
                    itemBuilder: ((context, index) {
                      return NoticePostCard(
                        noticeBoardData: _postDataList![index],
                        zoneId: widget.zoneId,
                        type: widget.type,
                      );
                    }),
                  )
                : Center(
                    child: Text(
                      "No Data Found",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.blackColor),
                    ),
                  )
            : const Center(
                child: CircularProgressIndicator(
                  color: ThemeColors.primaryColor,
                ),
              );
      }),
    );
  }
}

class NoticeBoardModel {
  String? userName;
  String? zoneName;
  String? userImage;
  String? postText;
  String? pdfText;

  NoticeBoardModel(
      {required this.userName,
      required this.postText,
      required this.zoneName,
      required this.userImage,
      required this.pdfText});
}
