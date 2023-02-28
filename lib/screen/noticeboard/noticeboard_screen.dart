
import 'package:flutter/material.dart';
import 'package:socialrecipe/screen/noticeboard/widget/all_notice_widget.dart';
import 'package:socialrecipe/utils/theme_colors.dart';


class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {





  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins-Bold',
           ),
            unselectedLabelColor: ThemeColors.greyTextColor,
            tabs: [
              Tab(text: 'All',),
              Tab(text: 'Group',),
            ],
          ),
          title: Text('Noticeboard',style: Theme.of(context).textTheme.headline2!.copyWith(
            fontSize: 25,
            fontFamily: 'Poppins-Bold',

          ),),
        ),
        body: TabBarView(
          children: [
            AllNoticeScreen(),
            AllNoticeScreen(),
          ],
        ),
      ),
    );
  }
}
