import 'package:flutter/material.dart';
import 'package:aharconnect/static_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:aharconnect/utils/theme_colors.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // NotificationScreen({Key? key}) : super(key: key);
  String lastMessage = '';
  TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          elevation: 4.0,
          bottomOpacity: 0.0,
          backgroundColor: ThemeColors.whiteColor,
          title: Text(
            'Notification',
            style: GoogleFonts.openSans(
                  fontSize: 20,
              color: ThemeColors.blackColor
                ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: Data().notificationList!.length,
                  itemBuilder: (context, index) {
                    // final contactUser =
                    // UserModel.fromSnapshot(contactUsersList[index]);
                    // getContactData(contactUser.id);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: MediaQuery.of(context).size.height*0.11,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color:
                                  ThemeColors.greyTextColor.withOpacity(0.3)),
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
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: ListTile(
                                    title: Text(
                                        "${Data().notificationList![index].title} ${DateFormat.jm().format(DateTime.now())}",
                                        style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    subtitle: Text(
                                        Data().notificationList![index].body ??
                                            "",
                                        style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    leading: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          border: Border.all(width: 1),
                                        ),
                                        height: 50,
                                        width: 50,
                                        child:
                                            // contactUser.photoUrl == ""
                                            //     ?
                                            ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                            'assets/default_image.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    // trailing: Text(
                                    //   DateFormat.jm().format(DateTime.now()),
                                    //   style: const TextStyle(
                                    //     fontSize: 12,
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )

              // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              //   stream: FirebaseFirestore.instance
              //       .collection('users')
              //       .doc(FirebaseAuth.instance.currentUser!.uid)
              //       .collection('contacts')
              //       .snapshots(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (snapshot.data == null || !snapshot.hasData) {
              //       return const Center(
              //         child: Text("You don't have any chat"),
              //       );
              //     } else if (snapshot.hasError) {
              //       return const Center(
              //         child: Text('Error occurred!'),
              //       );
              //     }
              //     if (snapshot.data!.docs.isEmpty) {
              //       return const Center(
              //         child: Text("You don't have any chat"),
              //       );
              //     }
              //     final contactUsersList = snapshot.data!.docs;
              //     return Padding(
              //       padding: const EdgeInsets.all(8),
              //       child: ListView.builder(
              //         primary: false,
              //         shrinkWrap: true,
              //         physics: const BouncingScrollPhysics(),
              //         itemCount: contactUsersList.length,
              //         itemBuilder: (context, index) {
              //           final contactUser =
              //           UserModel.fromSnapshot(contactUsersList[index]);
              //           // getContactData(contactUser.id);
              //           return Container(
              //             height: MediaQuery.of(context).size.height*0.11,
              //             decoration: BoxDecoration(
              //               border: Border.all(width: 1,color: ThemeColors.greyTextColor.withOpacity(0.3)),
              //               borderRadius: BorderRadius.circular(25),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.only(top: 5.0),
              //               child: Column(
              //                 children: [
              //                   InkWell(
              //                     onTap: () {
              //                       Navigator.pushNamed(
              //                         context,
              //                         AppPages.chatPath,
              //                         arguments: contactUser,
              //                       );
              //                     },
              //                     child: Padding(
              //                       padding: const EdgeInsets.only(bottom: 4.0),
              //                       child: ListTile(
              //                         title: Text(
              //                             contactUser.userName,
              //                             style:
              //                             TextStyle(
              //                               fontSize: 15,
              //                               fontFamily: 'Poppins-Bold',
              //                               fontWeight: FontWeight.w600,
              //                             )
              //                         ),
              //                         subtitle: Padding(
              //                           padding: const EdgeInsets.only(top: 6),
              //                           child: Text(
              //                             "${contactUser.lastMessage}",
              //                             maxLines: 1,
              //                             overflow: TextOverflow.ellipsis,
              //                             style: Theme.of(context)
              //                                 .textTheme
              //                                 .headline3!
              //                                 .copyWith(
              //                                 fontSize: 13,
              //                                 fontFamily: 'Poppins-Light',
              //                                 color: ThemeColors.greyTextColor
              //
              //                             ),
              //                           ),
              //                         ),
              //                         leading: Container(
              //                           decoration:  BoxDecoration(
              //                             borderRadius:
              //                             BorderRadius.all(Radius.circular(100)),
              //                             border: Border.all(width: 1),
              //
              //                           ),
              //                           height: 50,
              //                           width: 50,
              //                           child: contactUser.photoUrl == ""
              //                               ? ClipRRect(
              //                             borderRadius: BorderRadius.circular(100),
              //                             child: Image.asset(
              //                               'assets/default_image.jpg',
              //                               fit: BoxFit.cover,
              //                             ),
              //                           )
              //                               : Padding(
              //                             padding: const EdgeInsets.all(2.0),
              //                             child: ClipRRect(
              //                               borderRadius: BorderRadius.circular(100),
              //                               child: CachedNetworkImage(
              //                                 imageUrl: contactUser.photoUrl,
              //                                 fit: BoxFit.cover,
              //                                 errorWidget: (context, url, error) =>
              //                                 const Center(
              //                                   child: FaIcon(
              //                                       FontAwesomeIcons.circleExclamation),
              //                                 ),
              //                                 placeholder: (context, url) =>
              //                                     Shimmer.fromColors(
              //                                         baseColor: Colors.grey.shade400,
              //                                         highlightColor:
              //                                         Colors.grey.shade300,
              //                                         child: SizedBox(
              //                                             height: MediaQuery.of(context)
              //                                                 .size
              //                                                 .height /
              //                                                 3.3,
              //                                             width: double.infinity)),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         trailing: Text(
              //                           contactUser.messageSent == null
              //                               ? ''
              //                               : DateFormat('kk:mm')
              //                               .format(contactUser.messageSent!)
              //                               .toString(),
              //                           style: const TextStyle(
              //                             fontSize: 12,
              //                             color: Colors.grey,
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //
              //                 ],
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ));
  }
}
