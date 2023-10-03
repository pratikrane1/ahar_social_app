import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialrecipe/static_data.dart';
import 'package:socialrecipe/utils/constants.dart';
import 'package:socialrecipe/src/models/recipe_post_model.dart';
import 'package:socialrecipe/src/models/user_model.dart';
import 'package:socialrecipe/screen/recipe_feed/widgets/recipe_post_card.dart';
import 'package:socialrecipe/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:socialrecipe/utils/theme_colors.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key, required this.user}) : super(key: key);
  final UserModel? user;
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
      Provider.of<UserProvider>(context, listen: false).refreshUser();
      setState(() {});
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    UserModel? userProvider =
        Provider.of<UserProvider>(context, listen: false).getUser;
    return RefreshIndicator(
      onRefresh: refreshTab,
      color: ThemeColors.primaryColor,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        //padding: EdgeInsets.only(bottom: 50),
        physics: const AlwaysScrollableScrollPhysics(),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                // .where('uid', whereIn: widget.user!.following)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Some error occurred'),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text('No Post Found'),
                );
              } else if (snapshot.data == null) {
                return const Center(
                  child: Text('No data'),
                );
              } else {
                if (snapshot.data!.docs.isEmpty) {
                  return const SizedBox();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  // itemCount: snapshot.data!.docs.length,
                  itemCount: Data().feedList!.length,
                  itemBuilder: ((context, index) {
                    RecipePostModel post = RecipePostModel.fromSnapshot(
                        snapshot.data!.docs[index]);
                    return RecipePostCard(
                      user: userProvider,
                      post: post,
                      feedData: Data().feedList![index],
                    );
                  }),
                );
              }
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
