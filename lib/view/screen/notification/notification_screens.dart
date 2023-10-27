import 'package:aharconnect/controller/notification_controller.dart';
import 'package:aharconnect/data/model/notification_model.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:aharconnect/utils/theme_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel>? _notificationList;
  bool _hasNotification = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<NotificationController>().getNotificationList();
  }

  @override
  void dispose() {
    super.dispose();
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
              color: ThemeColors.blackColor,
                fontWeight: FontWeight.bold
                ),
          ),
        ),
        body:  GetBuilder<NotificationController>(
            builder: (notificationController) {
              _notificationList = notificationController.notificationList;
              _hasNotification = notificationController.hasNotification;
              return _hasNotification
                  ? _notificationList!.length != 0
                  ? SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _notificationList!.length,
                      itemBuilder: (context, index) {
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
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 4.0),
                                      child: ListTile(
                                        title: RichText(
                                          text: TextSpan(
                                              text: "${_notificationList![index].title} ",
                                            style: GoogleFonts.openSans(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,color: ThemeColors.blackColor
                                                  ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: DateFormat.jm().format(DateTime.parse(_notificationList![index].createdAt.toString())),
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,color: ThemeColors.blackColor
                                                  )
                                              ),
                                            ],
                                          ),

                                          // Text(
                                          //     "${_notificationList![index].title} ${DateFormat.jm().format(DateTime.parse(_notificationList![index].createdAt.toString()))}",
                                          //     style: GoogleFonts.openSans(
                                          //       fontSize: 15,
                                          //       fontWeight: FontWeight.w600,
                                          //     )),
                                        ),

                                        subtitle: Text(
                                            _notificationList![index].dsc ??
                                                "",
                                            style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            )),
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
                ],
              ),
            )
                  : Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_DEFAULT),
                          boxShadow: const [
                            BoxShadow(
                              color: ThemeColors.greyTextColor,
                              blurRadius: 2,
                              spreadRadius: 0.1,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "No notifications to show yet",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "You'll see useful information here soon.Stay tuned.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              )
                  : const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),);
          }
        ));
  }
}

