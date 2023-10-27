import 'dart:ui';
import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/helper/download_file.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:intl/intl.dart';

class NoticePostCard extends StatefulWidget {
  NoticePostCard({
    Key? key,
    this.noticeBoardData,required this.zoneId, required this.type,
  }) : super(key: key);
  final PostData? noticeBoardData;
  String zoneId;
  String type;
  @override
  State<NoticePostCard> createState() => _NoticePostCardState();
}

class _NoticePostCardState extends State<NoticePostCard> {
  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
  }

//
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User image and user name section.
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth - (screenWidth - 15),
                bottom: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Profile imag
                  GestureDetector(
                    onTap: () {
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(50),
                      elevation: 8,
                      shadowColor: Colors.grey.withOpacity(0.2),
                      child: SizedBox(
                        width: 44,
                        height: 44,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CustomImage(
                            image: widget.noticeBoardData!.user!.profilePhoto,
                            fit: BoxFit.cover,
                            fromProfile: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ///Name & Desc & PDF
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///username, zones name and delete button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [

                                          Text(
                                            widget.noticeBoardData!.user!.name ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            widget.noticeBoardData!.zone != null
                                                ? widget.noticeBoardData!.zone!
                                                    .zoneName!
                                                : "All Zone's",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                                color: ThemeColors.greyTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      Text(DateFormat("dd/MM/yyy").format(DateTime.parse(widget.noticeBoardData!.post!.createdAt.toString())),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.openSans(
                                              fontSize: Dimensions.fontSizeSmall,
                                              fontWeight: FontWeight.normal,
                                              color: ThemeColors.blackColor)
                                              .copyWith(fontSize: 12)),
                                    ],
                                  ),
                                  ///Delete Button
                                  widget.noticeBoardData!.post!.isDeletable == 1 ?
                                  PopupMenuButton(
                                      splashRadius: 20,
                                      icon: const FaIcon(
                                        FontAwesomeIcons
                                            .ellipsisVertical,
                                        size: 18,
                                        color:
                                        Colors.black,
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child:
                                          Text("delete".tr),
                                          onTap: () async{
                                            await Get.find<ZoneController>().deletePost(widget.zoneId, widget.type,widget.noticeBoardData!.postId.toString());
                                            await Get.find<ZoneController>().getNoticePostList(widget.zoneId, widget.type);
                                          },
                                        ),
                                      ]) : const SizedBox(),
                                ],
                              ),


                              const SizedBox(
                                height: 7,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  widget.noticeBoardData!.post!.dsc ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines:
                                      widget.noticeBoardData!.post!.dsc != null
                                          ? widget.noticeBoardData!.post!.dsc!
                                              .length
                                          : null,
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              widget.noticeBoardData!.post!.postImage != ""
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.picture_as_pdf,
                                                color: ThemeColors.redColor,
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(
                                                  widget.noticeBoardData!.post!
                                                      .postImage!
                                                      .split("/")
                                                      .last,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: widget
                                                              .noticeBoardData!
                                                              .post!
                                                              .postImage !=
                                                          null
                                                      ? widget
                                                          .noticeBoardData!
                                                          .post!
                                                          .postImage!
                                                          .length
                                                      : null,
                                                  style: GoogleFonts.openSans(
                                                      height: 1.5,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                              onTap: () async {
                                                // Get.find<ZoneController>().downloadPDF(widget.noticeBoardData!.post!.postImage!);
                                                downloadPDF(widget
                                                    .noticeBoardData!
                                                    .post!
                                                    .postImage!);
                                              },
                                              child: const Icon(Icons.download))
                                        ],
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
            const Divider(
              thickness: 0.8,
            )
          ],
        ),
      ),
    );
  }
}
