import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:socialrecipe/utils/app_constants.dart';
import 'package:socialrecipe/utils/images.dart';
import 'package:socialrecipe/utils/theme_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var langValue ;
  int? selectedIndex;
  bool isSwitched = false;

  @override
  void initState(){
    super.initState();
    // selectedIndex = Get.find<LocalizationController>().selectedIndex;
    // isSwitched = Get.find<AuthController>().notification;
  }

  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
      });
      // Notifications.setPushNotificationsEnabled(true);
    }
    else
    {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () async {
            // Get.back();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          "Settings".tr,
          style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              // Get.find<LocalizationController>().setLanguage(Locale(
              //   AppConstants.languages[selectedIndex!].languageCode,
              //   AppConstants.languages[selectedIndex!].countryCode,
              // ));
              // Get.find<LocalizationController>().setSelectIndex(selectedIndex!);
              // Get.find<AuthController>().setNotificationActive(isSwitched);
              // showCustomSnackBar("Saved",isError: false);

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 70,
                // height: 20,
                decoration: BoxDecoration(
                  color: ThemeColors.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Save".tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      color: ThemeColors.whiteColor
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        // centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: const [
                      BoxShadow(
                        color: ThemeColors.greyTextColor,
                        blurRadius: 3,
                        spreadRadius: 0.2,
                      )
                    ],
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.language_icon, height: 25,
                      // color: ThemeColors.greyTextColor,
                    ),
                    title:  Text("Language".tr,
                        style:const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                      },
                      child: ListTile(
                        title: Text(AppConstants.languages[index].languageName ?? "",
                            style:const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat-Medium',
                                fontWeight: FontWeight.w500,
                                color: ThemeColors.greyTextColor)),
                        leading: Radio(
                          activeColor: ThemeColors.greyTextColor,
                          value: index,
                          groupValue: selectedIndex,
                          onChanged: (value) {
                            setState(() {
                              selectedIndex = value as int?;
                            });
                          },
                        ),
                      ),
                    );
                  },),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: ThemeColors.whiteColor,
              border: Border.all(
                  width: 1,
                  color: ThemeColors.greyTextColor.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(0),
              boxShadow: const [
                BoxShadow(
                  color: ThemeColors.greyTextColor,
                  blurRadius: 3,
                  spreadRadius: 0.2,
                )
              ],
            ),
            child: ListTile(
              leading: SvgPicture.asset(
                Images.notification_icon, height: 25,
                // color: ThemeColors.greyTextColor,
              ),
              title:  Text("Notification".tr,
                  style:const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.greyTextColor)),
              trailing: Switch(
                onChanged: toggleSwitch,
                value: isSwitched,
                activeColor: ThemeColors.primaryColor,
                activeTrackColor: ThemeColors.greyTextColor.withOpacity(0.5),
                inactiveThumbColor: ThemeColors.greyTextColor,
                inactiveTrackColor: ThemeColors.greyTextColor.withOpacity(0.5),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
