
import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:aharconnect/screen/group/widget/group_feed_widget.dart';
import 'package:aharconnect/screen/group/widget/group_member_widget.dart';
import 'package:aharconnect/screen/noticeboard/widget/all_notice_widget.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:google_fonts/google_fonts.dart';


class ZoneScreen extends StatefulWidget {
  const ZoneScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<ZoneScreen> createState() => _ZoneScreenState();
}

class _ZoneScreenState extends State<ZoneScreen> {
  String? defaultSelectedGroup;
  List<ZoneModel>? _zoneList;


  @override
  void initState() {
    super.initState();
    Get.find<ZoneController>().getZoneList();
  }

  void setDefaultGroup(){
    if(_zoneList != null) {
      defaultSelectedGroup = _zoneList![0].zoneName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: GetBuilder<ZoneController>(builder: (zoneController) {
        _zoneList = zoneController.zoneList;
        // setDefaultGroup();
        return _zoneList != null ? Scaffold(
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
                  Tab(text: 'Feed',),
                  Tab(text: 'Noticeboard',),
                  Tab(text: 'Members',),
                ],
              ),
              title: Row(
                children: [
                  Container(
                    decoration:  BoxDecoration(
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
                      child: Image.asset(
                        'assets/default_image.jpg',
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  const SizedBox(width: 5,),
                  Text(defaultSelectedGroup ?? "All",style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 20,
                    fontFamily: 'Poppins-Bold',),),
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
            body: const TabBarView(
              children: [
                GroupFeedWidget(),
                AllNoticeScreen(),
                GroupMemberWidget(),
              ],
            ),
          ) : const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),);
        }
      ),
    );
  }

  void ShowModelBottomSheet(List<ZoneModel> zoneList){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
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
                  height: MediaQuery.of(context).size.height*0.11,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              defaultSelectedGroup = zoneList[index].zoneName;
                              defaultSelectedGroup;
                            });
                            setState(() {
                            });
                            print(defaultSelectedGroup);
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: ListTile(
                              title: Text(
                                  zoneList[index].zoneName.toString(),
                                  style:
                                  GoogleFonts.openSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  'Participants: ${0.toString()}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      color: ThemeColors.greyTextColor
                                  ),
                                ),
                              ),
                              leading: Container(
                                  decoration:  BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(100)),
                                    border: Border.all(width: 1),

                                  ),
                                  height: 50,
                                  width: 50,
                                  child:
                                  // contactUser.photoUrl == ""
                                  //     ?
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      'assets/default_image.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                              ),
                              trailing: Text(zoneList[index].createdAt.toString(),
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
        );
      },
    );
  }
}

class GroupModel{
  String? groupName;
  String? Participants;
  String? date;

  GroupModel({required this.groupName, required this.date, required this.Participants});
}