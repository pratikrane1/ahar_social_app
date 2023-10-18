import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/comment_model.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/screen/comment/widgets/comment_card.dart';
import 'package:aharconnect/utils/constants.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class CommentsScreen extends StatefulWidget {
  CommentsScreen({
    Key? key,
    required this.postData,
  }) : super(key: key);
  PostData postData;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _commentController = TextEditingController();
  List<CommentModel>? _postCommentList;

  @override
  void initState() {
    super.initState();
    Get.find<ZoneController>().getPostComment(widget.postData.postId.toString(),true);
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Theme(
        data: Theme.of(context).copyWith(
          useMaterial3: false,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeColors.whiteColor,
            leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24,
              ),
            ),
            title: Text(
              'comments'.tr,
              style:
                  GoogleFonts.openSans(
                      fontSize: 18,
                      color: ThemeColors.blackColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12)
                        .copyWith(top: 8),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'field_is_empty'.tr;
                                }
                                return null;
                              },
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.center,
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w600,
                              ),
                              controller: _commentController,
                              cursorColor: ThemeColors.blackColor,
                              autofocus: false,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  splashRadius: 20,
                                  onPressed: () async {
                                    final validForm =
                                    _formKey.currentState!.validate();
                                    if (validForm) {
                                      ///Post Comment
                                      Get.find<ZoneController>().PostComment(widget.postData.postId.toString(),
                                          Get.find<AuthController>().getUserId().toString(),"Post",_commentController.text,
                                          widget.postData.postId.toString());
                                      _commentController.clear();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: ThemeColors.blackColor,
                                  ),
                                ),
                                counterText: ' ',
                                fillColor: kGreyColor4,
                                filled: true,
                                isCollapsed: true,
                                contentPadding: const EdgeInsets.all(14),
                                hintText: 'comment'.tr,
                                hintStyle: GoogleFonts.openSans(
                                  fontSize: 15,
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
                    ),
                  ),
                  GetBuilder<ZoneController>(builder: (zoneController) {
                    _postCommentList = zoneController.postCommentList;
                      return _postCommentList != null ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _postCommentList!.length,
                        itemBuilder: (context, index) {
                          return CommentCard(
                            comment: _postCommentList![index],
                            postId: widget.postData.postId.toString(),
                          );
                        },
                      ) : const SizedBox();
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
