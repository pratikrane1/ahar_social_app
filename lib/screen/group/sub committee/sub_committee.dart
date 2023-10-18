import 'package:aharconnect/controller/group_controller.dart';
import 'package:aharconnect/data/model/sub_committee_model.dart';
import 'package:aharconnect/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';


class SubCommitteeScreen extends StatefulWidget {
  SubCommitteeScreen({Key? key}) : super(key: key);

  @override
  State<SubCommitteeScreen> createState() => _SubCommitteeScreenState();
}

class _SubCommitteeScreenState extends State<SubCommitteeScreen> {
  List<SubCommitteeModel>? _subCommitteeList;

  @override
  void initState() {
    super.initState();
    Get.find<GroupController>().getSubCommitteeList();
  }

  // apiCall() async {
  //   if (widget.title == "Office Bearers") {
  //     // officeBearers = await ApiClient().getOfficeBearersList();
  //     Get.find<GroupController>().getOfficersBearersList();
  //   } else if (widget.title == "Sub Committee") {
  //     // officeBearers = await ApiClient().getSubCommiteList();
  //   } else if (widget.title == "Zone") {
  //     // officeBearers = await ApiClient().getZoneList();
  //   } else if (widget.title == "Zonal Team") {
  //     // officeBearers = await ApiClient().getZoneList();
  //   }
  //   // print(officeBearers);
  //   setState(() {});
  // }

  @override
  void dispose() {
    super.dispose();
    // screenshotController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        surfaceTintColor: ThemeColors.whiteColor,
        title: Text("Sub Committee",
          style: GoogleFonts.openSans(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: ThemeColors.blackColor),
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 2.0,
        bottomOpacity: 3.0,
      ),
      body: GetBuilder<GroupController>(builder: (groupController) {
        _subCommitteeList = groupController.subCommitteeList;
        return _subCommitteeList!.isNotEmpty
            ? ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _subCommitteeList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: MediaQuery.of(context).size.height*0.1,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color:
                          ThemeColors.greyTextColor.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          left: 10.0,
                          right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    border: Border.all(width: 1),
                                  ),
                                  height: 50,
                                  width: 50,
                                  child:
                                  // contactUser.photoUrl == ""
                                  //     ?
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(100),
                                    child: CustomImage(
                                      image: _subCommitteeList![index]
                                          .user!
                                          .url,
                                      fit: BoxFit.cover,
                                      fromProfile: true,
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        1.8,
                                    child: Text(
                                        _subCommitteeList![index]
                                            .user!
                                            .name ??
                                            "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  _subCommitteeList![index].committeName != null
                                      ? Text(
                                      _subCommitteeList![index]
                                          .committeName ??
                                          "",
                                      maxLines: 2,
                                      style: GoogleFonts.openSans(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ))
                                      : SizedBox(),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        1.7,
                                    child: Text(
                                        _subCommitteeList![index]
                                            .user!
                                            .businessName ??
                                            "",
                                        maxLines: 2,
                                        style: GoogleFonts.openSans(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                  onTap: () async {
                                    String? number = _subCommitteeList![index]
                                        .user!
                                        .mobileNo ??
                                        "";
                                    Get.find<GroupController>()
                                        .launchPhone(number);
                                  },
                                  child: const Icon(Icons.phone)),
                              const SizedBox(
                                width: 7.0,
                              ),
                              InkWell(
                                  onTap: () async {
                                    String? email = _subCommitteeList![index]
                                        .user!
                                        .email ??
                                        "";
                                    Get.find<GroupController>()
                                        .launchMain(email);
                                  },
                                  child:
                                  const Icon(Icons.email_outlined)),
                              InkWell(
                                  onTap: () async {
                                    String? mobileNo =
                                        _subCommitteeList![index]
                                            .user!
                                            .mobileNo ??
                                            "";
                                    Get.find<GroupController>()
                                        .launchWhatsapp(mobileNo);
                                  },
                                  child: const FaIcon(
                                      FontAwesomeIcons.whatsapp)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
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