import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/comment_model.dart';
import 'package:aharconnect/screen/comment/widgets/reply_card.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/custom_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CommentCard extends StatefulWidget {
  CommentCard({
    Key? key,
    required this.comment,
    required this.postId,
  }) : super(key: key);
  CommentModel? comment;
  final String postId;
  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool showReplyField = false;
  String daysBetween(DateTime commentedDate) {
    String date;
    if ((DateTime.now().difference(commentedDate).inHours / 24)
            .round() ==
        1) {
      date = DateFormat('kk:mm').format(
        commentedDate,
      );
      return 'Yesterday at $date';
    }
    if ((DateTime.now().difference(commentedDate).inHours / 24)
            .round() >
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
    if (widget.comment!.islike == 1) {
      return "Unlike";
    }
    return 'Like';
  }

  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? replyStreamResult;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: CustomImage(
                      image: widget.comment!.url ?? "",
                      fit: BoxFit.fill,
                      fromProfile: true,
                    ),
                  ),
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.comment!.userName ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              GoogleFonts.openSans(
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                      Text(
                        daysBetween(DateTime.parse(widget.comment!.createdAt!)),
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
                                widget.comment!.dsc ?? "",
                                softWrap: true,
                                style: GoogleFonts.openSans(
                                      fontSize: 14,
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
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.openSans(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                      children: [
                        TextSpan(
                          text: '${widget.comment!.commentlike ?? ""} ',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: likeOrUnlikeText(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              // commentProvider.likeOrUnlikeComment(
                              //   postId: widget.postId,
                              //   userId: FirebaseAuth.instance.currentUser!.uid,
                              //   commentId: widget.comment.commentId,
                              //   likes: widget.comment.likes,
                              // );
                            },
                        ),
                        const TextSpan(text: '  ●  '),
                        TextSpan(
                          text: showReplyField ? 'Cancel' : 'Reply',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                showReplyField = !showReplyField;
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                  showReplyField
                      ? Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                  controller: _replyController,
                                  cursorColor: Colors.black,
                                  autofocus: false,
                                  autocorrect: false,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    suffixIcon: IconButton(
                                      splashRadius: 20,
                                      iconSize: 20,
                                      onPressed: () async {
                                        Get.find<ZoneController>().PostComment(widget.comment!.id.toString(),
                                            Get.find<AuthController>().getUserId().toString(),"PostComment",_replyController.text,
                                        widget.postId);
                                        _replyController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        color: ThemeColors.blackColor,
                                      ),
                                    ),
                                    fillColor: kGreyColor4,
                                    filled: true,
                                    contentPadding:
                                        const EdgeInsets.only(left: 14),
                                    hintText: 'Reply',
                                    hintStyle: GoogleFonts.openSans(
                                          fontSize: 13,
                                          color: Colors.grey.shade700,
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
                        )
                      : const SizedBox.shrink(),

                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.comment!.commentReply!.length,
                      itemBuilder: (context, index) {
                        return ReplyCard(
                          comment: widget.comment!.commentReply![index],
                          postId: widget.postId,
                        );
                      },
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
