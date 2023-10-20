import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/view/screen/noticeboard/widget/all_notice_widget.dart';
import 'package:aharconnect/view/screen/zone/widget/zone_feed_widget.dart';
import 'package:aharconnect/view/screen/zone/widget/zone_member_widget.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ZoneScreen extends StatefulWidget {
  const ZoneScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<ZoneScreen> createState() => _ZoneScreenState();
}

class _ZoneScreenState extends State<ZoneScreen> {
  String? defaultSelectedZone;
  String? defaultSelectedZoneURL;
  int? defaultSelectedZoneId = 0;
  List<ZoneModel>? _zoneList;

  @override
  void initState() {
    super.initState();
    Get.find<ZoneController>().getZoneList(false);
  }

  void setDefaultGroup() {
    if (_zoneList != null) {
      defaultSelectedZone = _zoneList![0].zoneName;
      defaultSelectedZoneURL = _zoneList![0].url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: GetBuilder<ZoneController>(builder: (zoneController) {
        _zoneList = zoneController.zoneList;
        if(_zoneList != null) {
          // setDefaultGroup();
        }
        return _zoneList != null
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: ThemeColors.whiteColor,
                  bottom: TabBar(
                    labelColor: ThemeColors.blackColor,
                    labelStyle: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelColor: ThemeColors.greyTextColor,
                    tabs: const [
                      Tab(
                        text: 'Feed',
                      ),
                      Tab(
                        text: 'Noticeboard',
                      ),
                      Tab(
                        text: 'Members',
                      ),
                    ],
                  ),
                  title: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            border: Border.all(width: 1),
                          ),
                          height: 35,
                          width: 35,
                          child:
                              // contactUser.photoUrl == ""
                              //     ?
                              ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CustomImage(
                              image: defaultSelectedZoneURL ?? "",
                              fit: BoxFit.cover,
                              fromProfile: true,
                            ),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        defaultSelectedZone ?? "All",
                        style: GoogleFonts.openSans(
                              fontSize: 20,
                          color: ThemeColors.blackColor
                            ),
                      ),
                      IconButton(
                        splashRadius: 20,
                        onPressed: () async {
                          ShowModelBottomSheet(_zoneList!);
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                  automaticallyImplyLeading: false,
                ),
                body: TabBarView(
                  children: [
                    GroupFeedWidget(
                        zoneId: defaultSelectedZoneId.toString(), type: "Post"),
                    AllNoticeScreen(
                        zoneId: defaultSelectedZoneId.toString(),
                        type: "Noticboard"),
                    ZoneMemberWidget(zoneId: defaultSelectedZoneId.toString()),
                  ],
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

  void ShowModelBottomSheet(List<ZoneModel> zoneList) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 4,),

            Image.asset(Images.divider_icon,
              scale: 4.0,
            ),

            const SizedBox(height: 4,),

            Text("zone".tr,
                style: GoogleFonts.openSans(
                  fontSize: Dimensions.fontSizeExtraLarge,
                  fontWeight: FontWeight.w600,
                )),

            Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: zoneList.length,
                itemBuilder: (context, index) {
                  // final contactUser =
                  // UserModel.fromSnapshot(contactUsersList[index]);
                  // getContactData(contactUser.id);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 10.5,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: ThemeColors.greyTextColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    defaultSelectedZone = zoneList[index].zoneName;
                                    defaultSelectedZoneURL = zoneList[index].url;
                                    defaultSelectedZone;
                                    defaultSelectedZoneURL = zoneList[index].url;
                                    defaultSelectedZoneURL;
                                    defaultSelectedZoneId = zoneList[index].zoneId;
                                    defaultSelectedZoneId;
                                  });
                                  Get.find<ZoneController>().getFeedPostDataList(
                                      defaultSelectedZoneId.toString(), "Post");
                                  Get.find<ZoneController>().getNoticePostList(
                                      defaultSelectedZoneId.toString(),
                                      "Noticboard");
                                  Get.find<ZoneController>().getMembersList(
                                      defaultSelectedZoneId.toString());
                                  Navigator.pop(context);
                                },
                                child: ListTile(
                                  title: Text(zoneList[index].zoneName.toString(),
                                      style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      'Participants: ${zoneList[index].participantsCount.toString()}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                          fontSize: 13,
                                          color: ThemeColors.greyTextColor),
                                    ),
                                  ),
                                  leading: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100)),
                                        border: Border.all(width: 1),
                                      ),
                                      height: 50,
                                      width: 50,
                                      child:
                                      CustomImage(
                                        image: zoneList[index].url ?? "",
                                        fit: BoxFit.cover,
                                        fromProfile: true,
                                      ),
                                  ),
                                  trailing: Text(DateFormat("dd/MM/yyy").format(DateTime.parse(zoneList[index].createdAt!)),
                                    // zoneList[index].createdAt.toString(),
                                    style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
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
            ),
          ],
        );
      },
    );
  }
}
