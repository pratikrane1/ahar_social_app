import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialrecipe/utils/app_pages.dart';
import 'package:socialrecipe/utils/constants.dart';
import 'package:socialrecipe/src/models/user_model.dart';
import 'package:socialrecipe/providers/settings_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ContactsListScreen extends StatelessWidget {
  ContactsListScreen({Key? key}) : super(key: key);
  String lastMessage = '';
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
  Widget build(BuildContext context) {
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
            color: kOrangeColor,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: Text(
          'Chats',
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 18,
              ),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.more_horiz,
              color: kOrangeColor,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppPages.chatPath,
                          arguments: contactUser,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: ListTile(
                          title: Text(
                            contactUser.userName,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              "Last sms: ${contactUser.lastMessage}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    fontSize: 13,
                                  ),
                            ),
                          ),
                          leading: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            height: 45,
                            width: 45,
                            child: contactUser.photoUrl == ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      'assets/default_image.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipRRect(
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
                    DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1.5,
                      dashLength: 12.0,
                      dashColor: Colors.black,
                      dashGradient: const [
                        Color.fromARGB(255, 244, 70, 54),
                        Color.fromARGB(255, 10, 92, 88)
                      ],
                      dashRadius: 5.0,
                      dashGapLength: 3.0,
                      dashGapColor: Colors.transparent,
                      dashGapRadius: 2.0,
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
