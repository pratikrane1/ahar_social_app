
import 'package:flutter/material.dart';
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
              SizedBox(width: 5,),
              Text('Mumbai Zone | Group',style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 20,
                fontFamily: 'Poppins-Bold',

              ),),
            ],
          ),
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
}
