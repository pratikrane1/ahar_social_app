import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aharconnect/utils/theme_colors.dart';

// ignore: must_be_immutable
class ZoneMemberWidget extends StatefulWidget {
  ZoneMemberWidget({required this.zoneId, Key? key}) : super(key: key);
  String zoneId;

  @override
  State<ZoneMemberWidget> createState() => _ZoneMemberWidgetState();
}

class _ZoneMemberWidgetState extends State<ZoneMemberWidget> {
  List<MemberModel>? _membersList;
  bool _ismembersLoading = false;

  @override
  void initState() {
    super.initState();
    Get.find<ZoneController>().getMembersList(
      widget.zoneId,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<ZoneController>(builder: (zoneController) {
      _membersList = zoneController.membersList;
      _ismembersLoading = zoneController.isMemberLoading;
      return _ismembersLoading
          ? _membersList!.isNotEmpty
              ? ListView(children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _membersList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // height: MediaQuery.of(context).size.height * 0.1,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: ThemeColors.greyTextColor
                                      .withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ListTile(
                                        title: Text(
                                            _membersList![index].name ?? "",
                                            maxLines: 2,
                                            style: GoogleFonts.openSans(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        leading: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(100)),
                                              border: Border.all(width: 1),
                                            ),
                                            height: 50,
                                            width: 50,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CustomImage(
                                                image: _membersList![index]
                                                        .profilePhoto ??
                                                    "",
                                                fit: BoxFit.cover,
                                                fromProfile: true,
                                              ),
                                            )),
                                        // trailing: Text(
                                        //   index == 0 ? 'Admin' : '',
                                        //   style: GoogleFonts.openSans(
                                        //     fontSize: 12,
                                        //     color: ThemeColors.msgFieldColor,
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ])
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
    }));
  }
}
