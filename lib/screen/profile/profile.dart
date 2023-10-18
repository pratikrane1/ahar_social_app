import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/controller/profile_controller.dart';
import 'package:aharconnect/data/model/profile_model.dart';
import 'package:aharconnect/screen/authentication/screens/log_in_screen.dart';
import 'package:aharconnect/screen/group/zone/zone_screen.dart';
import 'package:aharconnect/screen/profile/my%20profile/my_profile_screen.dart';
import 'package:aharconnect/screen/group/office%20bearers/office_bearers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aharconnect/screen/profile/privacy%20policy/privacy_policy.dart';
import 'package:aharconnect/screen/profile/settings/settings_screen.dart';
import 'package:aharconnect/screen/profile/terms%20and%20conditions/terms_conditons_screen.dart';
import 'package:aharconnect/screen/profile/transaction/transaction_history.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/custom_image.dart';
import 'cutomer support/customer_support.dart';
import 'faq/faq_screen.dart';
import 'membership detail/membership_screen.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile? _profileData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<MyProfileController>().getProfileData();
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
            await Get.find<MyProfileController>().getProfileData();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 5,
              ),

              ///My Account
              GetBuilder<MyProfileController>(builder: (myAccountController) {
                // _isLoading = myAccountController.isLoading;
                _profileData = myAccountController.profileData;
                return _profileData != null
                    ? InkWell(
                        onTap: () {
                          // Get.toNamed(RouteHelper.myAccount);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyProfileScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeColors.whiteColor,
                            border: Border.all(
                                width: 1,
                                color:
                                    ThemeColors.greyTextColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: ListTile(
                            leading: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  // border: Border.all(width: 1),
                                ),
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: _profileData!.profileImage != ""
                                      ? CustomImage(
                                          image: _profileData!.profileImage,
                                          fit: BoxFit.cover,
                                          fromProfile: true,
                                        )
                                      : SvgPicture.asset(
                                          _profileData!.name != null
                                              ? Images.my_account_logo
                                              : Images.my_account_logo,
                                          height: 25,
                                          // color: ThemeColors.greyTextColor,
                                        ),
                                )),
                            title: Text(
                                _profileData!.name != null
                                    ? _profileData!.name!
                                        .split(" ")
                                        .elementAt(0)
                                        .toString()
                                    : 'My Account',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: _profileData!.name != null
                                        ? ThemeColors.primaryColor
                                        : ThemeColors.greyTextColor
                                            .withOpacity(1))),
                            subtitle:
                                Text('view_and_update_your_profile_details'.tr,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    )),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: ThemeColors.primaryColor,
                        ),
                      );
              }),

              const SizedBox(
                height: 10,
              ),

              ///Ahar Office Bearers
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OfficeBearersScreen()));
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
                      Images.refer_icon,
                      height: 25,
                      color: ThemeColors.greyTextColor,
                    ),
                    title: Text('Office Bearers'.tr,
                        style: const TextStyle(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ZoneScreen()));
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
                      Images.autopull_referal_list_icon,
                      height: 25,
                      color: ThemeColors.greyTextColor,
                    ),
                    title: Text('Zonal Team'.tr,
                        style: const TextStyle(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MembershipScreen()));
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
                    title: Text('Membership Detail'.tr,
                        style: const TextStyle(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionHistoryScreen()));
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
                    title: Text("Transaction history".tr,
                        style: const TextStyle(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsConditionsScreen()));
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
                    title: Text("Terms And Conditions".tr,
                        style: const TextStyle(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen()));
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
                    title: Text('Privacy Policies'.tr,
                        style: const TextStyle(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpCentreScreen()));
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
                    title: Text("FAQS".tr,
                        style: const TextStyle(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerSupportScreen()));
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
                    title: Text("Customer Support".tr,
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              // const SizedBox(
              //   height: 10,
              // ),
              //
              // ///Credit Screen
              // InkWell(
              //   onTap: () {
              //     // Get.toNamed(RouteHelper.helpCentre);
              //     Navigator.push(context, MaterialPageRoute(
              //         builder: (context) => const CreditScreen()
              //     ));
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: ThemeColors.whiteColor,
              //       border: Border.all(
              //           width: 1,
              //           color: ThemeColors.greyTextColor.withOpacity(0.3)),
              //       borderRadius: BorderRadius.circular(0),
              //     ),
              //     child: ListTile(
              //       leading: SvgPicture.asset(
              //         Images.credit_icon, height: 25,
              //         // color: ThemeColors.greyTextColor,
              //       ),
              //       title:  Text("Credit Screen".tr,
              //           style:const TextStyle(
              //               fontSize: 14,
              //               fontFamily: 'Montserrat',
              //               fontWeight: FontWeight.w600,
              //               color: ThemeColors.greyTextColor)),
              //       trailing: const Icon(Icons.arrow_forward_ios),
              //     ),
              //   ),
              // ),

              const SizedBox(
                height: 10,
              ),

              ///Settings Screen
              InkWell(
                onTap: () {
                  // Get.toNamed(RouteHelper.helpCentre);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
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
                    title: Text("Settings Screen".tr,
                        style: const TextStyle(
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
                  Get.find<AuthController>().clearUserNumber();
                  Get.find<AuthController>().cleartoken();

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LogInScreen()));
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
                    title: Text('logout'.tr,
                        style: const TextStyle(
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
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor)),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(AppConstants.APP_VERSION,
                        style: TextStyle(
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
                  child: Column(
                    children: [
                      Image.asset(
                        Images.logo,
                        height: 120,
                        // color: ThemeColors.primaryColor,
                      ),
                      const Text("Powered by WAAYU",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
