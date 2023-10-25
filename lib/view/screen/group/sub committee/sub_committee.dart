import 'package:aharconnect/controller/group_controller.dart';
import 'package:aharconnect/data/model/sub_committee_model.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
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
  bool _isSubComLoading = false;

  @override
  void initState() {
    super.initState();
    Get.find<GroupController>().getSubCommitteeList();
  }


  @override
  void dispose() {
    super.dispose();
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
        _isSubComLoading = groupController.isSubComLoading;
        return _isSubComLoading ? _subCommitteeList!.isNotEmpty
            ? ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _subCommitteeList!.length,
              itemBuilder: (context, index) {
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
                            image: _subCommitteeList![index].user!.url ?? "",
                            fit: BoxFit.cover,
                            fromProfile: true,
                          ),
                        )),
                    title: Text(_subCommitteeList![index].user!.name ?? "",
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: Dimensions.fontSizeExtraLarge,
                            fontWeight: FontWeight.w600)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            _subCommitteeList![index].committeName ?? "",
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: Dimensions.fontSizeDefault,
                                fontWeight: FontWeight.w600)),
                        Text(_subCommitteeList![index].user!.businessName ?? "",
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
                                  _subCommitteeList![index].user!.mobileNo ?? "";
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
                                  String? email = _subCommitteeList![index].user!.email ?? "";
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
                                  String? mobileNo = _subCommitteeList![index].user!.mobileNo ?? "";
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
          ],
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
