import 'package:flutter/material.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widget/custom_snackbar.dart';

class GroupDetailScreen extends StatefulWidget {
  GroupDetailScreen({
    Key? key,
    required this.title
  }) : super(key: key);
  String? title;

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {


  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    // screenshotController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        surfaceTintColor: ThemeColors.whiteColor,
        title: Text(
          widget.title.toString(),
          style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 2.0,
        bottomOpacity: 3.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: MediaQuery.of(context).size.height*0.1,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: ThemeColors.greyTextColor.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,left: 10.0,right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
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
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SizedBox(
                                    // width: 100,
                                    child: Text("SHRI. SUKESH S.SHETTY PRESIDENT",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.w600,
                                        )
                                    ),
                                  ),
                                  Text("HOTEL HINDAMATA",
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Poppins-Bold',
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ],
                          ),

                          Row(
                             children: [
                              InkWell(
                                  onTap: ()async{
                                    String? number = "1234567890";
                                    final call = Uri.parse('tel:$number');
                                    if (await canLaunchUrl(call)) {
                                    launchUrl(call);
                                    } else {
                                    showCustomSnackBar("Could not launch", isError: true);
                                    throw 'Could not launch $call';
                                    }
                                  },
                                  child: Icon(Icons.phone)),
                               SizedBox(width: 7.0,),
                               InkWell(
                                   onTap: ()async{
                                     String? email = "pratik.rane@desteksolutions.com";
                                     Uri mail = Uri.parse('mailto:$email');
                                     if (await canLaunchUrl(mail)) {
                                       launchUrl(mail);
                                     } else {
                                       showCustomSnackBar("Could not launch", isError: true);
                                       throw 'Could not launch $mail';
                                     }
                                   },
                                   child: Icon(Icons.email_outlined)),
                             ],
                           ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



