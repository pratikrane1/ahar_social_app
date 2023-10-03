import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialrecipe/screen/profile/credit/credit_screen.dart';
import 'package:socialrecipe/screen/profile/settings/settings_screen.dart';
import 'package:socialrecipe/utils/app_constants.dart';
import 'package:socialrecipe/utils/images.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/custom_image.dart';
import 'cutomer support/customer_support.dart';
import 'faq/faq_screen.dart';
import 'membership detail/membership_screen.dart';
import 'my account/my_account_screen.dart';
import 'my auto pull referal/my_auto_pull_referal.dart';
import 'my referal list/referal_list.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Profile? _profileData;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    // Get.find<MyAccountController>().getProfileData();
    // Get.find<ReferController>().getReferralLevelCount(Get.find<AuthController>().getUserId());
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: ThemeColors.whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          elevation: 3.0,
          title: Text(
            'My Account'.tr,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
          ),
        ),
        body: RefreshIndicator(
          color: ThemeColors.primaryColor,
          onRefresh: () async {
            // await Get.find<MyAccountController>().getProfileData();
            // await Get.find<ReferController>().getReferralLevelCount(Get.find<AuthController>().getUserId());
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 5,
              ),

              ///My Account
              InkWell(
                onTap: () {
                  // Get.toNamed(RouteHelper.myAccount);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MyAccountScreen()
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          // border: Border.all(width: 1),
                        ),
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CustomImage(image: "", fit: BoxFit.cover,fromProfile: true,),
                        )),
                    title: Text(  'My Account',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.primaryColor)),
                    subtitle:  Text('View and update your profile details'.tr,
                        style:const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ///Ahar Office Bearers
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => ReferalListScreen()
                  // ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.refer_icon, height: 25,
                      color: ThemeColors.greyTextColor,
                    ),
                    title:  Text('Ahar Office Bearers'.tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ///zonal team
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => MyAutoPullReferalScreen()
                  // ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.autopull_referal_list_icon, height: 25,
                      color: ThemeColors.greyTextColor,
                    ),
                    title:  Text('Zonal Team'.tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ///Membership Detail
              InkWell(
                onTap: () {
                  // Get.toNamed(RouteHelper.membershipScreen);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MembershipScreen()
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.membership_icon, height: 25,
                      // color: ThemeColors.greyTextColor,
                    ),
                    title:  Text('Membership Detail'.tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ///Transaction history
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) =>  TransactionHistoryScreen()
                  // ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.transaction_history, height: 25,
                      // color: ThemeColors.greyTextColor,
                    ),
                    title:  Text("Transaction history".tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ///Terms And Conditions
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => TermsConditionsScreen()
                  // ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.terms_condition_icon, height: 25,
                      // color: ThemeColors.greyTextColor,
                    ),
                    title:  Text("Terms And Conditions".tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),


              ///Privacy Policies
              InkWell(
                onTap: () {
                  // Get.toNamed(RouteHelper.privacyPolicy);
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => PrivacyPolicyScreen()
                  // ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.privacy_policy_icon, height: 25,
                      // color: ThemeColors.greyTextColor,
                    ),
                    title:  Text('Privacy Policies'.tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ///FAQS
              InkWell(
                onTap: () {
                  // Get.toNamed(RouteHelper.helpCentre);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const HelpCentreScreen()
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.faq_icon, height: 25,
                      // color: ThemeColors.greyTextColor,
                    ),
                    title:  Text("FAQS".tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),


              ///Customer Support
              InkWell(
                onTap: () {
                  // Get.to(CustomerSupportScreen());
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CustomerSupportScreen()
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.customer_support_icon, height: 25,
                      // color: ThemeColors.greyTextColor,
                    ),
                    title:  Text("Customer Support".tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ///Credit Screen
              InkWell(
                onTap: () {
                  // Get.toNamed(RouteHelper.helpCentre);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const CreditScreen()
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.credit_icon, height: 25,
                      // color: ThemeColors.greyTextColor,
                    ),
                    title:  Text("Credit Screen".tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ///Settings Screen
              InkWell(
                onTap: () {
                  // Get.toNamed(RouteHelper.helpCentre);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SettingsScreen()
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.settings_icon, height: 25,
                      // color: ThemeColors.greyTextColor,
                    ),
                    title:  Text("Settings Screen".tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),


              ///Logout
              InkWell(
                onTap: () {
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) => CustomDialog());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    border: Border.all(
                        width: 1,
                        color: ThemeColors.greyTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      Images.logout_icon, height: 25,
                      // color: ThemeColors.greyTextColor,
                    ),
                    title:  Text('logout'.tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("version".tr,
                        style:const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    const SizedBox(width: 5,),
                    const Text(AppConstants.APP_VERSION,
                        style:TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ///Destek Logo
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ThemeColors.whiteColor,
                  border: Border.all(
                      width: 1,
                      color: ThemeColors.greyTextColor.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    Images.logo,
                    height: 120,
                    // color: ThemeColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
