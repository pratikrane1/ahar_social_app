import 'package:aharconnect/controller/group_controller.dart';
import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                        // return Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     // height: MediaQuery.of(context).size.height * 0.1,
                        //     height: 80,
                        //     decoration: BoxDecoration(
                        //       border: Border.all(
                        //           width: 1,
                        //           color: ThemeColors.greyTextColor
                        //               .withOpacity(0.3)),
                        //       borderRadius: BorderRadius.circular(25),
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(top: 0.0),
                        //       child: Column(
                        //         children: [
                        //           InkWell(
                        //             onTap: () {},
                        //             child: Padding(
                        //               padding: const EdgeInsets.only(top: 8.0),
                        //               child: ListTile(
                        //                 title: Text(
                        //                     _membersList![index].name ?? "",
                        //                     maxLines: 2,
                        //                     style: GoogleFonts.openSans(
                        //                       fontSize: 13,
                        //                       fontWeight: FontWeight.w600,
                        //                     )),
                        //                 leading: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius:
                        //                           const BorderRadius.all(
                        //                               Radius.circular(100)),
                        //                       border: Border.all(width: 1),
                        //                     ),
                        //                     height: 50,
                        //                     width: 50,
                        //                     child: ClipRRect(
                        //                       borderRadius:
                        //                           BorderRadius.circular(100),
                        //                       child: CustomImage(
                        //                         image: _membersList![index]
                        //                                 .profilePhoto ??
                        //                             "",
                        //                         fit: BoxFit.cover,
                        //                         fromProfile: true,
                        //                       ),
                        //                     )),
                        //                 // trailing: Text(
                        //                 //   index == 0 ? 'Admin' : '',
                        //                 //   style: GoogleFonts.openSans(
                        //                 //     fontSize: 12,
                        //                 //     color: ThemeColors.msgFieldColor,
                        //                 //   ),
                        //                 // ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // );
                        return Card(
                          surfaceTintColor: Colors.white,
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ExpansionTile(
                            backgroundColor: ThemeColors.whiteColor,
                            tilePadding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 5, right: 15),
                            leading: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  border: Border.all(width: 1),
                                ),
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CustomImage(
                                    image: _membersList![index].profilePhoto ?? "",
                                    fit: BoxFit.cover,
                                    fromProfile: true,
                                  ),
                                )),
                            title: Text(_membersList![index].name ?? "",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                    fontWeight: FontWeight.w600)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //     officeBearers![index].position!.positionName ?? "",
                                //     style: GoogleFonts.openSans(
                                //         color: Colors.black,
                                //         fontSize: Dimensions.fontSizeDefault,
                                //         fontWeight: FontWeight.w600)),
                                Text(_membersList![index].businessName ?? "",
                                    style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontSize: Dimensions.fontSizeDefault,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            children: <Widget>[
                              const Divider(
                                thickness: 1.0,
                              ),
                              /// Phone , Email and Whatsapp Button
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment : MainAxisAlignment.spaceBetween,

                                  children: [
                                    ///Phone button
                                    InkWell(
                                        onTap: () async {
                                          String? number =
                                              _membersList![index].mobileNo ?? "";
                                          Get.find<GroupController>()
                                              .launchPhone(number);
                                        },
                                        child: Column(
                                          children: [
                                            const Icon(Icons.phone),
                                            Text("phone".tr,
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black,
                                                    fontSize: Dimensions.fontSizeDefault,
                                                    fontWeight: FontWeight.w500)),
                                          ],
                                        )),
                                    ///Email button
                                    InkWell(
                                        onTap: () async {
                                          String? email =
                                              _membersList![index].email ?? "";
                                          Get.find<GroupController>()
                                              .launchMain(email);
                                        },
                                        child:
                                        Column(
                                          children: [
                                            const Icon(Icons.email_outlined),
                                            Text("email".tr,
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black,
                                                    fontSize: Dimensions.fontSizeDefault,
                                                    fontWeight: FontWeight.w500)),
                                          ],
                                        )),
                                    ///Whatsapp button
                                    InkWell(
                                        onTap: () async {
                                          String? mobileNo =
                                              _membersList![index].mobileNo ?? "";
                                          Get.find<GroupController>()
                                              .launchWhatsapp(mobileNo);
                                        },
                                        child: Column(
                                          children: [
                                            const FaIcon(
                                                FontAwesomeIcons.whatsapp),
                                            Text("whatsapp".tr,
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black,
                                                    fontSize: Dimensions.fontSizeDefault,
                                                    fontWeight: FontWeight.w500)),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
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
