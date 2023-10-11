import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/static_data.dart';
import 'package:aharconnect/screen/recipe_feed/widgets/recipe_post_card.dart';
import 'package:aharconnect/utils/theme_colors.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key,}) : super(key: key);
  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab>
    with AutomaticKeepAliveClientMixin {
  Stream<QuerySnapshot<Map<String, dynamic>>>? streamResult;
  @override
  void initState() {
    super.initState();
    // streamResult =
  }

  Future<void> refreshTab() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      streamResult = FirebaseFirestore.instance
          .collection('posts')
          // .where('uid', whereIn: widget.user!.following)
          .snapshots();
      setState(() {});
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshTab,
      color: ThemeColors.primaryColor,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        //padding: EdgeInsets.only(bottom: 50),
        physics: const AlwaysScrollableScrollPhysics(),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          // itemCount: snapshot.data!.docs.length,
          itemCount: Data().feedList!.length,
          itemBuilder: ((context, index) {
            return RecipePostCard(
              feedData: Data().feedList![index],
            );
          }),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
