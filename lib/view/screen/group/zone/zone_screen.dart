import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/view/screen/group/zone/zone_members.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';


class ZoneScreen extends StatefulWidget {
  ZoneScreen({Key? key}) : super(key: key);

  @override
  State<ZoneScreen> createState() => _ZoneScreenState();
}

class _ZoneScreenState extends State<ZoneScreen> {
  List<ZoneModel>? _zoneList;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Get.find<ZoneController>().getZoneList(true);
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
        title: Text("Zone",
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
      body: GetBuilder<ZoneController>(builder: (zoneController) {
        _zoneList = zoneController.zoneList;
        isLoading = zoneController.isLoading;
        return isLoading ? _zoneList!.isNotEmpty
            ? ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _zoneList!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ZoneMembersScreen(zoneId: _zoneList![index].zoneId.toString(),
                    zoneName: _zoneList![index].zoneName.toString(),)));
                  },
                  child: Padding(
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
                            right:  10.0),
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
                                        image: _zoneList![index]
                                            .url ??
                                            "",
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
                                          _zoneList![index]
                                              .zoneName ??
                                              "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
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
