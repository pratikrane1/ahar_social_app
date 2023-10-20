import 'package:aharconnect/controller/profile_controller.dart';
import 'package:aharconnect/data/model/profile_model.dart';
import 'package:aharconnect/view/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_profile.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Profile? _profileData;

  @override
  void initState() {
    // TODO: implement initState
    //
    super.initState();
    Get.find<MyProfileController>().getProfileData();
    // Get.find<MyAccountController>().initData();
  }

  getData() {
    _nameController.text = _profileData!.name ?? "";
    _phoneController.text = _profileData!.mobileNo ?? "";
    _emailController.text = _profileData!.email ?? "";
    _businessNameController.text = _profileData!.businessName ?? "";
    _cityController.text = _profileData!.city ?? "";
    _addressController.text = _profileData!.address ?? "";
    _messageController.text = _profileData!.bio ?? "";
    _messageController.text = _profileData!.bio ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _businessNameController.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF8F7F7),
        appBar: AppBar(
          backgroundColor: ThemeColors.whiteColor,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            splashRadius: 20,
            onPressed: () async {
              // await Get.find<MyAccountController>().profileData;
              // Get.back();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
          ),
          actions: [
            IconButton(
              iconSize: 70,
              icon: SvgPicture.asset(
                Images.edit_logo,
                height: 25,
              ),
              onPressed: () async {
                // Get.toNamed(RouteHelper.myAccountEdit);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyProfileEditScreen()));
              },
            ),
          ],
          title: Text(
            'Profile Details'.tr,
            style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
              color: ThemeColors.blackColor
                ),
          ),
          centerTitle: false,
          elevation: 4.0,
          bottomOpacity: 0.0,
        ),
        body: GetBuilder<MyProfileController>(builder: (myAccountController) {
          // _isLoading = myAccountController.isLoading;
          _profileData = myAccountController.profileData;
          if (_profileData != null) {
            print(_profileData);
            getData();
          }
          return _profileData != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      /// Profile Details
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ImagePickerWidget(
                                image: '${_profileData!.profileImage}',
                                onTap: () =>
                                    myAccountController.pickGalleryImage(),
                                rawFile: myAccountController.rawFile,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                // onTap: () => myAccountController.pickGalleryImage(),
                                child: Center(
                                  child: Text('${_nameController.text}',
                                      style: GoogleFonts.openSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ThemeColors.blackColor)),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              ///Name
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text('Name'.tr,
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.6))),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: _nameController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    height: 1.5,
                                    color: ThemeColors.blackColor
                                        .withOpacity(0.6)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF8F7F7),
                                  hintText: "Enter full name".tr,
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 15,
                                      color: _nameController.text == ""
                                          ? Colors.red
                                          : null),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                ),
                                validator: (value) {},
                                onChanged: (value) {},
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              ///Business Name
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text('Business Name',
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.6))),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: _businessNameController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    height: 1.5,
                                    color: ThemeColors.blackColor
                                        .withOpacity(0.6)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF8F7F7),
                                  hintText: "Enter business name",
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 15,
                                      color: _cityController.text == ""
                                          ? Colors.red
                                          : null),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                ),
                                validator: (value) {},
                                onChanged: (value) {},
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              ///Phone Number
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text('Phone Number'.tr,
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.6))),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: _phoneController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    height: 1.5,
                                    color: ThemeColors.blackColor
                                        .withOpacity(0.6)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF8F7F7),
                                  hintText: "Enter phone number".tr,
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 15,
                                      color: _phoneController.text == ""
                                          ? Colors.red
                                          : null),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                ),
                                validator: (value) {},
                                onChanged: (value) {},
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              ///Email
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text('Email'.tr,
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.6))),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: _emailController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    height: 1.5,
                                    color: ThemeColors.blackColor
                                        .withOpacity(0.6)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF8F7F7),
                                  hintText: "Enter email".tr,
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 15,
                                      color: _emailController.text == ""
                                          ? Colors.red
                                          : null),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                ),
                                validator: (value) {},
                                onChanged: (value) {},
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              ///City
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text('City'.tr,
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.6))),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: _cityController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    height: 1.5,
                                    color: ThemeColors.blackColor
                                        .withOpacity(0.6)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF8F7F7),
                                  hintText: "Enter city".tr,
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 15,
                                      color: _cityController.text == ""
                                          ? Colors.red
                                          : null),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                ),
                                validator: (value) {},
                                onChanged: (value) {},
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              ///Address
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text('Address',
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.6))),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: _addressController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    height: 1.5,
                                    color: ThemeColors.blackColor
                                        .withOpacity(0.6)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF8F7F7),
                                  hintText: "Enter address",
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 15,
                                      color: _addressController.text == ""
                                          ? Colors.red
                                          : null),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                ),
                                validator: (value) {},
                                onChanged: (value) {},
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              ///Message
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text('Message (Optional)',
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.6))),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: _messageController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    height: 1.5,
                                    color: ThemeColors.blackColor
                                        .withOpacity(0.6)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF8F7F7),
                                  hintText: "Enter message",
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 15,
                                      color: _messageController.text == ""
                                          ? Colors.red
                                          : null),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.blackColor
                                            .withOpacity(0.2)),
                                  ),
                                ),
                                validator: (value) {},
                                onChanged: (value) {},
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: ThemeColors.primaryColor,
                  ),
                );
        }));
  }
}
