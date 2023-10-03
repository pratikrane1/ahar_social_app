
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialrecipe/screen/group/widget/group_feed_widget.dart';
import 'package:socialrecipe/screen/group/widget/group_member_widget.dart';
import 'package:socialrecipe/screen/noticeboard/widget/all_notice_widget.dart';
import 'package:socialrecipe/utils/theme_colors.dart';


class GroupScreen extends StatefulWidget {
  const GroupScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {



  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelColor: ThemeColors.blackColor,
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins-Bold',
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins-Bold',
            ),
            unselectedLabelColor: ThemeColors.greyTextColor,
            tabs: [
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
                  BorderRadius.all(Radius.circular(100)),
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
              SizedBox(width: 5,),
              Text('Mumbai Zone | Group',style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 20,
                fontFamily: 'Poppins-Bold',),),
              IconButton(
                splashRadius: 20,
                onPressed: () async {
                  ShowModelBottomSheet();
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
            GroupFeedWidget(),
            AllNoticeScreen(),
            GroupMemberWidget(),
          ],
        ),
      ),
    );
  }

  void ShowModelBottomSheet(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 200,
          // color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
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
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              //     GroupScreen()));
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: ListTile(
                                title: Text(
                                  // contactUser.userName,
                                    'Zone Name',
                                    style:
                                    TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppins-Bold',
                                      fontWeight: FontWeight.w600,
                                    )
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    // "${contactUser.lastMessage}",
                                    'Participants: 200',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                        fontSize: 13,
                                        fontFamily: 'Poppins-Light',
                                        color: ThemeColors.greyTextColor

                                    ),
                                  ),
                                ),
                                leading: Container(
                                    decoration:  BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
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
                                  //     : Padding(
                                  //   padding: const EdgeInsets.all(2.0),
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(100),
                                  //     child: CachedNetworkImage(
                                  //       imageUrl: contactUser.photoUrl,
                                  //       fit: BoxFit.cover,
                                  //       errorWidget: (context, url, error) =>
                                  //       const Center(
                                  //         child: FaIcon(
                                  //             FontAwesomeIcons.circleExclamation),
                                  //       ),
                                  //       placeholder: (context, url) =>
                                  //           Shimmer.fromColors(
                                  //               baseColor: Colors.grey.shade400,
                                  //               highlightColor:
                                  //               Colors.grey.shade300,
                                  //               child: SizedBox(
                                  //                   height: MediaQuery.of(context)
                                  //                       .size
                                  //                       .height /
                                  //                       3.3,
                                  //                   width: double.infinity)),
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                                trailing: Text(
                                  // contactUser.messageSent == null
                                  //     ? ''
                                  //     :
                                  DateFormat('kk:mm')
                                  // .format(contactUser.messageSent!)
                                      .format(DateTime.now())
                                      .toString(),
                                  style: const TextStyle(
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
        );
      },
    );
  }
}
