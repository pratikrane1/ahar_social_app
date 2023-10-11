import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/providers/settings_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:aharconnect/utils/theme_colors.dart';

import 'group_listing_detail_screen.dart';

// ignore: must_be_immutable
class GroupListScreen extends StatefulWidget {
  const GroupListScreen({Key? key}) : super(key: key);

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 3.0,
          bottomOpacity: 0.0,
          backgroundColor: ThemeColors.whiteColor,
          title: Text(
            'Groups',
            style: GoogleFonts.openSans(
              fontSize: 25,
              color: ThemeColors.blackColor,
              fontWeight: FontWeight.bold
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
                      GoogleFonts.openSans(
                        fontSize: 20,
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
