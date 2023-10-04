
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:socialrecipe/utils/images.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/app_button.dart';
import 'package:socialrecipe/widget/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  // Profile? _profileData;
  bool _isGainZPro = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    // _profileData = await Get.find<MyAccountController>().profileData;
    // if (_profileData == null) {
    //   _profileData = await Get.find<MyAccountController>().getProfileData();
    // }
    // setState(() {});
  }

  _launchWhatsapp(BuildContext context,) async {
    var whatsapp = "1234567890";
    var message = "Hi Ahar team, I have a Query. Can you please help me?";

    var whatsappURl_android = "whatsapp://send?phone=" + whatsapp + "&text=$message";
    var whatsappURL_WEB = "https://wa.me/$whatsapp/?text=${Uri.parse(message)}";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse(message)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        showCustomSnackBar("Could not launch", isError: true);
      }
    }
    else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        showCustomSnackBar("Could not launch", isError: true);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        surfaceTintColor: Colors.white,
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
          'Customer Support'.tr,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
        ),
        centerTitle: false,
        elevation: 4.0,
        bottomOpacity: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ///Call Us Logo
            Center(
              child: SvgPicture.asset(
                Images.customer_support_logo,
                height: MediaQuery.of(context).size.height / 3,
              ),
            ),

            /// Call Us Button
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                  onPressed: ()async{
                    String? number =  "0123456789";
                    final call = Uri.parse('tel:$number');
                    if (await canLaunchUrl(call)) {
                    launchUrl(call);
                    } else {
                    showCustomSnackBar("Could not launch", isError: true);
                    throw 'Could not launch $call';
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        color: ThemeColors.primaryColor, width: 1),
                    backgroundColor: ThemeColors.primaryColor,
                    // color:Colors.red,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Images.phone_icon, height: 27,
                        color: ThemeColors.whiteColor,
                      ),
                       const SizedBox(width: 5,),
                       Flexible(
                        child: Text('call_us'.tr,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style:const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: ThemeColors.whiteColor)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5,),

            _isGainZPro ? Row(
              children: [
                Expanded(child: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Divider(thickness: 1.5,indent: 40.0,color: ThemeColors.greyTextColor.withOpacity(0.8),),
                )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("or".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat-Bold',
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.greyTextColor.withOpacity(0.8))),
                ),
                Expanded(child: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Divider(thickness: 1.5,endIndent: 40.0,color: ThemeColors.greyTextColor.withOpacity(0.8),),
                )),
              ],
            ) : Container(),

            _isGainZPro ? const SizedBox(height: 5,) : Container(),

            /// Whatsapp Button
            _isGainZPro ? Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                  onPressed: (){
                    _launchWhatsapp(context,);
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        color: ThemeColors.whatsappButtonColor, width: 1),
                    backgroundColor: ThemeColors.whiteColor,
                    surfaceTintColor: ThemeColors.whiteColor,
                    // color:Colors.red,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Images.whatsapp_icon, height: 27,
                          color: ThemeColors.whatsappButtonColor,
                      ),
                      const SizedBox(width: 5,),
                      Flexible(
                        child: Text('whatsapp'.tr,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style:const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: ThemeColors.whatsappButtonColor)),
                      ),
                    ],
                  ),
                ),
              ),
            ) : Container(),

            const SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'If you prefer to speak with a support representative directly, you can reach our helpline at '.tr,
                  style: const TextStyle(
                      fontSize: 19,
                      fontFamily: 'Montserrat-Bold',
                      fontWeight: FontWeight.w500,
                      color: ThemeColors.customerSupportTextColor),
                  children: <TextSpan>[
                    const TextSpan(text: " 0123456789",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat-ExtraBold',
                          fontWeight: FontWeight.w700,
                          color: ThemeColors.primaryColor,
                      ),),
                    TextSpan(text: '.Our knowledgeable agents will be glad to assist you and provide step-by-step guidance.'.tr,),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
