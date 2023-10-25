import 'package:aharconnect/controller/membership_controller.dart';
import 'package:aharconnect/controller/profile_controller.dart';
import 'package:aharconnect/data/model/membership_model.dart';
import 'package:aharconnect/data/model/profile_model.dart';
import 'package:aharconnect/view/screen/profile/membership%20detail/widget/payment_dialog.dart';
import 'package:aharconnect/view/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MembershipScreen extends StatefulWidget {
  bool? isGainZPro;
  bool? fromSplash;
  MembershipScreen({this.isGainZPro, this.fromSplash = false, Key? key})
      : super(key: key);

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  bool _isLoading = true;
  MembershipModel? _membershipDetails;
  // Profile? _profileData;
  bool _isGainZPro = true;
  Profile? _profileData;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
    Get.find<MembershipController>().getMembershipDetails();
  }

  void fetchUserProfile() async {
    _profileData = await Get.find<MyProfileController>().profileData;
    _profileData ??= await Get.find<MyProfileController>().getProfileData();
    setState(() {});
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        backgroundColor: ThemeColors.whiteColor,
        surfaceTintColor: ThemeColors.whiteColor,
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
        title: Text(
          "membership_details".tr,
          style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
            color: ThemeColors.blackColor
              ),
        ),
        centerTitle: false,
        elevation: 2.0,
        bottomOpacity: 0.0,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<MembershipController>(builder: (membershipController) {
          _membershipDetails = membershipController.membershipDetails;
          return _membershipDetails != null ?
          Column(
              children: [
                ///Gainz Pro
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Membership Date
                      // _membershipDetails!.validityFrom != null ?
                      Text(
                        '${'starting_from'.tr} ${_membershipDetails!.createdAt} ${'Till'} ${_membershipDetails!.endAt}',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors.greyTextColor),
                      ),
                      // : SizedBox(),

                    const SizedBox(height: 20,),

                    /// Buy Now Container
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.7,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                          boxShadow: const [
                            BoxShadow(
                              color: ThemeColors.greyTextColor,
                              blurRadius: 3,
                              spreadRadius: 0.2,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                             Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text('\u{20B9} ${_membershipDetails!.membershipDetails!.amount}',
                                style: GoogleFonts.openSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: ThemeColors.blackColor),),
                            ),

                            const SizedBox(height: 8,),

                            Text('inclusive_of_GST'.tr,
                              style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.blackColor),),

                            const SizedBox(height: 15,),

                            const Divider(
                              // color: ThemeColors.blackColor,
                              thickness: 2,
                              indent: 25.0,
                              endIndent: 25.0,
                            ),

                            const SizedBox(height: 15,),

                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: AppButton(
                                onPressed: () async {
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context) => PaymentDialog(
                                  //       amount: "${_membershipDetails!.membershipDetails}",paidAmount: "${_membershipDetails!.membershipDetails}",
                                  //       profileData: _profileData,
                                  //     ));
                                },
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                text:  Text("renew".tr,
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: Dimensions.fontSizeSmall,
                                      fontWeight: FontWeight.w700),
                                ),
                                loading: _isLoading,
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      color: ThemeColors.buttonColor, width: 1),
                                  backgroundColor: ThemeColors.buttonColor,
                                  // color:Colors.red,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(50))),
                                ),
                              ),
                            ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Text('benefits'.tr,
                        style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.blackColor),),

                      ///Benifits String
                      Html(
                        data: "${_membershipDetails!.membershipDetails!.dsc}",
                      ),
                    ],
                  ),
                ),
              ],
            )
              : const Padding(
            padding: EdgeInsets.only(top: 200.0),
            child: Center(
              child: CircularProgressIndicator(color: ThemeColors.primaryColor,),
            ),
          );
          }
        ),
      ),
    );
  }
}