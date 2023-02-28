import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialrecipe/screen/group/group_screen.dart';
import 'package:socialrecipe/utils/app_pages.dart';
import 'package:socialrecipe/utils/constants.dart';
import 'package:socialrecipe/src/models/user_model.dart';
import 'package:socialrecipe/providers/settings_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialrecipe/utils/theme_colors.dart';

// ignore: must_be_immutable
class GroupListScreen extends StatefulWidget {
  const GroupListScreen({Key? key}) : super(key: key);

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  // GroupListScreen({Key? key}) : super(key: key);
  String lastMessage = '';
  TextEditingController _phoneController= TextEditingController();

  getContactData(String contactId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('contacts')
        .doc(contactId)
        .collection('messages')
        .snapshots()
        .listen((event) {
      lastMessage = event.docs.last['messageText'];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingsProvider>(context, listen: false);
    final settingsManager =
    Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          bottomOpacity: 0.0,
          title: Text(
            'Groups',
            style: Theme.of(context).textTheme.headline2!.copyWith(
              fontSize: 25,
              fontFamily: 'Poppins-Bold',

            ),
          ),
          actions: [
            IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.search,
                size: 30,
                color: ThemeColors.blackColor,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [


              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('contacts')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data == null || !snapshot.hasData) {
                    return const Center(
                      child: Text("You don't have any chat"),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error occurred!'),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("You don't have any chat"),
                    );
                  }
                  final contactUsersList = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: contactUsersList.length,
                      itemBuilder: (context, index) {
                        final contactUser =
                        UserModel.fromSnapshot(contactUsersList[index]);
                        // getContactData(contactUser.id);
                        return Container(
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
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   AppPages.chatPath,
                                    //   arguments: contactUser,
                                    // );
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  GroupScreen()));
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
                                        child: contactUser.photoUrl == ""
                                            ? ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.asset(
                                            'assets/default_image.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                            : Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              imageUrl: contactUser.photoUrl,
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) =>
                                              const Center(
                                                child: FaIcon(
                                                    FontAwesomeIcons.circleExclamation),
                                              ),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                      baseColor: Colors.grey.shade400,
                                                      highlightColor:
                                                      Colors.grey.shade300,
                                                      child: SizedBox(
                                                          height: MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                              3.3,
                                                          width: double.infinity)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      trailing: Text(
                                        contactUser.messageSent == null
                                            ? ''
                                            : DateFormat('kk:mm')
                                            .format(contactUser.messageSent!)
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
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        )

    );
  }
}
