import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialrecipe/utils/constants.dart';
import 'package:socialrecipe/src/models/user_model.dart';
import 'package:socialrecipe/screen/profile/screens/edit_profile_screen.dart';
import 'package:socialrecipe/screen/profile/widgets/profile_back_button.dart';
import 'package:socialrecipe/screen/profile/widgets/profile_cached_background_photo.dart';
import 'package:socialrecipe/screen/profile/widgets/profile_default_background_photo.dart';
import 'package:socialrecipe/screen/profile/widgets/profile_info_container.dart';
import 'package:socialrecipe/screen/profile/widgets/profile_messages_button.dart';
import 'package:socialrecipe/screen/profile/widgets/profile_post_section.dart';
import 'package:socialrecipe/screen/profile/widgets/profile_send_message_button.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);
  String? userId;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bool _isLoadingProfile = false;
  String imageUrl = 'assets/default_image.jpg';
  Stream<QuerySnapshot<Map<String, dynamic>>>? streamResult;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      streamResult = FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: widget.userId)
          .snapshots();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingProfile
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Theme(
            data: Theme.of(context).copyWith(useMaterial3: false),
            child: RefreshIndicator(
              color: kOrangeColor,
              backgroundColor: Colors.white,
              displacement: 50,
              onRefresh: _refresh,
              child: Scaffold(
                body: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SafeArea(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('id', isEqualTo: widget.userId)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: LinearProgressIndicator(
                              color: kOrangeColor,
                              backgroundColor: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error occurred!'),
                          );
                        } else if (snapshot.data == null) {
                          return const Center(
                            child: Text('No Data!'),
                          );
                        } else {
                          UserModel user =
                              UserModel.fromSnapshot(snapshot.data.docs[0]);
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.9,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      user.photoUrl == ""
                                          ? const ProfileDefaultBackgroundPhoto()
                                          : ProfileCachedBackgroundPhoto(
                                              user: user,
                                            ),
                                      Positioned(
                                        top: 3,
                                        right: 5,
                                        child: Row(
                                          children: [
                                            FirebaseAuth.instance.currentUser!
                                                        .uid !=
                                                    widget.userId
                                                ? ProfileSendMessageButton(
                                                    user: user,
                                                  )
                                                : ProfileMessageButton(
                                                    userId: widget.userId!,
                                                  ),
                                          ],
                                        ),
                                      ),
                                      FirebaseAuth.instance.currentUser!.uid !=
                                              widget.userId
                                          ? const ProfileBackButton()
                                          : const SizedBox(),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: ProfileInfoContainer(
                                          user: user,
                                          userId: widget.userId,
                                          onEdit: () async {
                                            // final result =
                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfileScreen(
                                                  user: user,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ProfilePostSection(userId: widget.userId!),
                                // Padding(
                                //   padding: const EdgeInsets.all(15.0),
                                //   child: buildProductList(context),
                                // )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget buildProductList(
      BuildContext context,) {
    // if (productList.length <= 0) {
    //   return GridView.builder(
    //     shrinkWrap: true,
    //     scrollDirection: Axis.vertical,
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       childAspectRatio: 2/2.5,
    //     ),
    //     // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
    //     itemBuilder: (context, index) {
    //       return Shimmer.fromColors(
    //         baseColor: Theme.of(context).hoverColor,
    //         highlightColor: Theme.of(context).highlightColor,
    //         enabled: true,
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             width: MediaQuery.of(context).size.width,
    //             child: Card(
    //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //               elevation: 5,
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   SizedBox(
    //                     height: 15,
    //                   ),
    //                   CachedNetworkImage(
    //                     // width: 150,
    //                     // height: 150,
    //                     filterQuality: FilterQuality.medium,
    //                     // imageUrl: Api.PHOTO_URL + widget.users.avatar,
    //                     imageUrl: "https://picsum.photos/250?image=9",
    //                     // imageUrl: productData.prodImg.toString(),
    //                     placeholder: (context, url) {
    //                       return Shimmer.fromColors(
    //                         baseColor: Theme.of(context).hoverColor,
    //                         highlightColor: Theme.of(context).highlightColor,
    //                         enabled: true,
    //                         child: Container(
    //                           height: 80,
    //                           width: 80,
    //                           decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             borderRadius: BorderRadius.circular(8),
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                     imageBuilder: (context, imageProvider) {
    //                       return Container(
    //                         height: 80,
    //                         width: 80,
    //                         decoration: BoxDecoration(
    //                           image: DecorationImage(
    //                             image: imageProvider,
    //                             fit: BoxFit.cover,
    //                           ),
    //                           borderRadius: BorderRadius.circular(0),
    //                         ),
    //                       );
    //                     },
    //                     errorWidget: (context, url, error) {
    //                       return Shimmer.fromColors(
    //                         baseColor: Theme.of(context).hoverColor,
    //                         highlightColor: Theme.of(context).highlightColor,
    //                         enabled: true,
    //                         child: Container(
    //                           height: 80,
    //                           width: 80,
    //                           decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             borderRadius: BorderRadius.circular(8),
    //                           ),
    //                           child: Icon(Icons.error),
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(left: 15, top: 10, right: 5),
    //                     child: Container(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             "Product",
    //                             style: TextStyle(
    //                                 fontWeight: FontWeight.w400,
    //                                 color: ThemeColors.textColor,
    //                                 fontSize: 15.0,
    //                                 fontFamily: 'SF-Pro-Display-Regular'),
    //                           ),
    //                           SizedBox(
    //                             height: 5,
    //                           ),
    //                           Text(
    //                             "\u{20B9} 0.0",
    //                             style: TextStyle(
    //                                 fontWeight: FontWeight.w600,
    //                                 fontSize: 20.0,
    //                                 fontFamily: 'SF-Pro-Display-Bold'),
    //                           ),
    //                           SizedBox(
    //                             height: 5,
    //                           ),
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text(
    //                                 "\u{20B9} 0.0",
    //                                 style: TextStyle(
    //                                     decoration: TextDecoration.lineThrough,
    //                                     fontWeight: FontWeight.w600,
    //                                     fontSize: 18.0,
    //                                     fontFamily: 'SF-Pro-Display-Regular',
    //                                     color: ThemeColors.textFieldHintColor),
    //                               ),
    //                               InkWell(
    //                                   onTap: () {
    //                                     Navigator.push(
    //                                         context,
    //                                         MaterialPageRoute(
    //                                             builder: (context) => CartPage(backIcon: true,)));
    //                                   },
    //                                   child: Icon(
    //                                     Icons.add_shopping_cart,
    //                                     color: ThemeColors.baseThemeColor,
    //                                   ))
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.all(Radius.circular(20)),
    //                 color: Colors.white),
    //           ),
    //         ),
    //       );
    //     },
    //     itemCount: List.generate(8, (index) => index).length,
    //   );
    // }

    // return ListView.builder(
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 4,
      itemBuilder: (context, index) {
        // final item = producerList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(13)
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Group Name',style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Poppins-Bold',
                  )),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Location: ",style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins-Light',
                              fontWeight: FontWeight.w500

                          )),
                          Text("Navi,Mumbai",style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins-Light',
                              fontWeight: FontWeight.w500

                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.circle,size: 15,),
                          SizedBox(width: 4,),
                          Text("Admin",style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins-Light',
                            fontWeight: FontWeight.w500
                          )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Text('Total Members:',style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins-Light',
                      fontWeight: FontWeight.w500
                  )),
                ],
              ),
            ),
          ),
        );
      },

    );
  }


}
