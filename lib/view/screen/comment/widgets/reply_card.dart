import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/comment_model.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class ReplyCard extends StatelessWidget {
  const ReplyCard(
      {Key? key,
      required this.comment,
      required this.postData})
      : super(key: key);
  final CommentReply comment;
  final PostData postData;
  String daysBetween(DateTime commentedDate) {
    String date;
    if ((DateTime.now().difference(commentedDate).inHours / 24).round() ==
        1) {
      date = DateFormat('kk:mm').format(
        commentedDate,
      );
      return 'Yesterday at $date';
    }
    if ((DateTime.now().difference(commentedDate).inHours / 24).round() >
        1) {
      date = DateFormat('dd MMMM, kk:mm').format(
        commentedDate,
      );
      return date;
    } else {
      date = DateFormat('kk:mm').format(
        commentedDate,
      );
      return 'Today at $date';
    }
  }

  String likeOrUnlikeText() {
    if (comment.islike == 1) {
      return "Unlike";
    }
    return 'Like';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                    child: CustomImage(
                      image: comment.url ?? "",
                      fit: BoxFit.fill,
                      fromProfile: true,
                    ),
                  ),
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          comment.username ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              GoogleFonts.openSans(
                                    fontSize: 13,
                                  ),
                        ),
                      ),
                      Text(
                        daysBetween(DateTime.parse(comment.createdAt!)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                              fontSize: 10,
                              color: Colors.grey.shade800,
                            ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                comment.dsc ?? "",
                                softWrap: true,
                                style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.openSans(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                      children: [
                        TextSpan(
                          text: '${comment.commentlike != 0 ? comment.commentlike : ""} ',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: likeOrUnlikeText(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if(comment.islike == 1) {
                                Get.find<ZoneController>().addCommentLike(
                                  comment.id.toString(),
                                  "0",
                                  postData.postId.toString(),
                                );
                              }else{
                                Get.find<ZoneController>().addCommentLike(
                                  comment.id.toString(),
                                  "1",
                                  postData.postId.toString(),
                                );
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
        ],
      ),
    );
  }
}
