import 'package:flutter/material.dart';
import 'package:aharconnect/screen/recipe_feed/screens/activity_tab.dart';


class GroupFeedWidget extends StatefulWidget {
  const GroupFeedWidget({Key? key}) : super(key: key);

  @override
  State<GroupFeedWidget> createState() => _GroupFeedWidgetState();
}

class _GroupFeedWidgetState extends State<GroupFeedWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _phoneController= TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: false,
      ),
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: SizedBox(
                  height: double.maxFinite,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ActivityTab(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedModel{
  String? userName;
  String? zoneName;
  String? postImage;
  String? userImage;
  String? postText;
  String? likeCount;

  FeedModel({required this.userName,required this.likeCount,required this.postImage,
    required this.postText, required this.zoneName,required this.userImage});
}