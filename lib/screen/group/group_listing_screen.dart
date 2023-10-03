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

import 'group_listing_detail_screen.dart';

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
          automaticallyImplyLeading: false,
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupDetailScreen(title: "Office Bearers",)));

                  },
                  child: groupWidget("Office Bearers")),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupDetailScreen(title: "Sub Committee",)));

                  },
                  child: groupWidget("Sub Committee")),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupDetailScreen(title: "Zone",)));
                  },
                  child: groupWidget("Zone")),
            ],
          ),
        )
    );
  }

  Widget groupWidget(String title){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: MediaQuery.of(context).size.height*0.1,
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: ThemeColors.greyTextColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0,bottom: 5.0,left: 5.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: ListTile(
                  title: Text(title,
                      style:
                      const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins-Bold',
                        fontWeight: FontWeight.w700,
                      )
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
