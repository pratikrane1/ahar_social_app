import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aharconnect/utils/theme_colors.dart';

// ignore: must_be_immutable
class GroupMemberWidget extends StatefulWidget {
  const GroupMemberWidget({Key? key}) : super(key: key);

  @override
  State<GroupMemberWidget> createState() => _GroupMemberWidgetState();
}

class _GroupMemberWidgetState extends State<GroupMemberWidget> {
  // GroupMemberWidget({Key? key}) : super(key: key);
  String lastMessage = '';
  TextEditingController _phoneController= TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.1,
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
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  //     GroupScreen()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ListTile(
                                    title: Text(
                                      // contactUser.userName,
                                        'Jakob Curtis',
                                        style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        )
                                    ),
                                    leading: Container(
                                        decoration:  BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(100)),
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
                                              // : Padding(
                                          //   padding: const EdgeInsets.all(2.0),
                                          //   child: ClipRRect(
                                          //     borderRadius: BorderRadius.circular(100),
                                          //     child: CachedNetworkImage(
                                          //       imageUrl: contactUser.photoUrl,
                                          //       fit: BoxFit.cover,
                                          //       errorWidget: (context, url, error) =>
                                          //       const Center(
                                          //         child: FaIcon(
                                          //             FontAwesomeIcons.circleExclamation),
                                          //       ),
                                          //       placeholder: (context, url) =>
                                          //           Shimmer.fromColors(
                                          //               baseColor: Colors.grey.shade400,
                                          //               highlightColor:
                                          //               Colors.grey.shade300,
                                          //               child: SizedBox(
                                          //                   height: MediaQuery.of(context)
                                          //                       .size
                                          //                       .height /
                                          //                       3.3,
                                          //                   width: double.infinity)),
                                          //     ),
                                          //   ),
                                          // ),
                                        ),
                                        trailing: Text(
                                          index == 0 ? 'Admin' : '',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: ThemeColors.msgFieldColor,
                                          ),
                                        ),
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
                  )])));
                }
}
