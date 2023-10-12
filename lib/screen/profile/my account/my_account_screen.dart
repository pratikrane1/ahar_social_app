import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialrecipe/utils/images.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/image_picker_widget.dart';

import 'edit_profile.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pancardController = TextEditingController();
  final _bankAccountController = TextEditingController();
  final _ifscCodeController = TextEditingController();
  final _referByController = TextEditingController();
  final _referByNameController = TextEditingController();
  final _businessInController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _nomineeNameController = TextEditingController();
  final _nomineeAgeController = TextEditingController();
  final _nomineeRelationController = TextEditingController();
  final _nomineeMobileNoController = TextEditingController();
  final _cityController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _districtController = TextEditingController();
  final _addressController = TextEditingController();
  final _stateController = TextEditingController();
  final _messageController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Profile? _profileData;
  bool _isLoading = true;
  bool _isPhotosLoading = false;
  bool _isCameraLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    // Get.find<MyAccountController>().getProfileData();
    // Get.find<MyAccountController>().initData();
  }

  // getData() {
  //   _nameController.text = _profileData!.name ?? "";
  //   _phoneController.text = _profileData!.number ?? "";
  //   _emailController.text = _profileData!.email ?? "";
  //   _passwordController.text = _profileData!.password ?? "";
  //   _pancardController.text = _profileData!.panCard ?? "";
  //   _bankAccountController.text = _profileData!.bankAccount ?? "";
  //   _ifscCodeController.text = _profileData!.ifscCode ?? "";
  //   _referByController.text = _profileData!.referredby ?? "";
  //   _businessInController.text = _profileData!.businessIn.toString() ?? "";
  //   _pinCodeController.text = _profileData!.pinCode ?? "";
  //   _cityController.text = _profileData!.city ?? "";
  //   _districtController.text = _profileData!.district ?? "";
  //   _stateController.text = _profileData!.state ?? "";
  //   _referByNameController.text = _profileData!.referredName ?? "";
  //   _dobController.text = _profileData!.dateOfBirth ?? "";
  //   _genderController.text = _profileData!.gender ?? "";
  //   if(_profileData!.nominee!=null){
  //     _nomineeNameController.text = _profileData!.nominee!.name ?? "";
  //     _nomineeAgeController.text = _profileData!.nominee!.age ?? "";
  //     _nomineeRelationController.text = _profileData!.nominee!.relation ?? "";
  //     _nomineeMobileNoController.text = _profileData!.nominee!.mobile ?? "";
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
   _nameController.dispose();
     _phoneController.dispose();
     _emailController.dispose() ;
     _passwordController.dispose();
     _pancardController.dispose();
     _bankAccountController.dispose();
     _ifscCodeController.dispose();
     _referByController.dispose();
     _businessInController.dispose();
     _pinCodeController.dispose();
     _nomineeNameController.dispose();
     _nomineeAgeController.dispose();
     _nomineeMobileNoController.dispose();
     _nomineeRelationController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _businessNameController.dispose();
    _messageController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _referByNameController.dispose();
    _dobController.dispose();
    _genderController.dispose();
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
              onPressed: () async{
                // Get.toNamed(RouteHelper.myAccountEdit);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyAccountEditScreen()
                ));
              },
            ),
          ],
          title: Text(
            'Profile Details'.tr,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 18,
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
                        image: '',
                        onTap: () => null,
                        rawFile: null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        // onTap: () => myAccountController.pickGalleryImage(),
                        child: Center(
                          child: Text('${_nameController.text}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color:
                                  ThemeColors.blackColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ///Name
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text('Name'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _nameController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color:
                            ThemeColors.blackColor.withOpacity(0.6)
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter full name".tr,
                          hintStyle: TextStyle(
                              fontSize: 15, color: _nameController.text == "" ?Colors.red: null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),    focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                        ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
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
                        child: Text('Business Name'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _businessNameController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color:
                            ThemeColors.blackColor.withOpacity(0.6)
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter business name".tr,
                          hintStyle: TextStyle(fontSize: 15,color: _cityController.text == "" ?Colors.red: null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
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
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: ThemeColors.blackColor
                                    .withOpacity(0.6))),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _phoneController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color:
                            ThemeColors.blackColor.withOpacity(0.6)
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter phone number".tr,
                          hintStyle: TextStyle(
                              fontSize: 15,color: _phoneController.text == "" ?Colors.red: null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),    focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                        ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
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
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: ThemeColors.blackColor
                                    .withOpacity(0.6))),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _emailController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.emailAddress,
                        style:  TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color:
                            ThemeColors.blackColor.withOpacity(0.6)
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter email".tr,
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _emailController.text == "" ?Colors.red: null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),    focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                        ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                        ),
                        validator: (value) {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // ///bank account
                      // Padding(
                      //   padding: EdgeInsets.only(left: 5.0),
                      //   child: Text('Bank Account'.tr,
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           fontFamily: 'Montserrat',
                      //           fontWeight: FontWeight.w500,
                      //           color:
                      //           ThemeColors.blackColor.withOpacity(0.6))),
                      // ),
                      // TextFormField(
                      //   readOnly: true,
                      //   controller: _bankAccountController,
                      //   textAlign: TextAlign.start,
                      //   keyboardType: TextInputType.text,
                      //   style: TextStyle(
                      //       fontSize: 18,
                      //       height: 1.5,
                      //       color:
                      //       ThemeColors.blackColor.withOpacity(0.6)
                      //   ),
                      //   decoration: InputDecoration(
                      //     filled: true,
                      //     fillColor: Color(0xFFF8F7F7),
                      //     hintText: "Enter bank account".tr,
                      //     hintStyle: TextStyle(fontSize: 15,color: _bankAccountController.text == "" ?Colors.red: null),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),    focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //   ),
                      //     border: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),
                      //   ),
                      //   validator: (value) {},
                      //   onChanged: (value) {},
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      //
                      // ///Ifsc code
                      // Padding(
                      //   padding: EdgeInsets.only(left: 5.0),
                      //   child: Text('IFSC Code'.tr,
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           fontFamily: 'Montserrat',
                      //           fontWeight: FontWeight.w500,
                      //           color:
                      //           ThemeColors.blackColor.withOpacity(0.6))),
                      // ),
                      // TextFormField(
                      //   readOnly: true,
                      //   controller: _ifscCodeController,
                      //   textAlign: TextAlign.start,
                      //   keyboardType: TextInputType.text,
                      //   style: TextStyle(
                      //       fontSize: 18,
                      //       height: 1.5,
                      //       color:
                      //       ThemeColors.blackColor.withOpacity(0.6)
                      //   ),
                      //   decoration: InputDecoration(
                      //     filled: true,
                      //     fillColor: Color(0xFFF8F7F7),
                      //     hintText: "Enter IFSC code".tr,
                      //     hintStyle: TextStyle(fontSize: 15,color: _ifscCodeController.text == "" ?Colors.red: null),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),    focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //   ),
                      //     border: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),
                      //   ),
                      //   validator: (value) {},
                      //   onChanged: (value) {},
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      //
                      // ///Date Of Birth
                      // Padding(
                      //   padding: EdgeInsets.only(left: 5.0),
                      //   child: Text('Birthday'.tr,
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           fontFamily: 'Montserrat',
                      //           fontWeight: FontWeight.w500,
                      //           color:
                      //           ThemeColors.blackColor.withOpacity(0.6))),
                      // ),
                      // TextFormField(
                      //   readOnly: true,
                      //   controller: _dobController,
                      //   textAlign: TextAlign.start,
                      //   keyboardType: TextInputType.text,
                      //   style: TextStyle(
                      //       fontSize: 18,
                      //       height: 1.5,
                      //       color:
                      //       ThemeColors.blackColor.withOpacity(0.6)
                      //   ),
                      //   decoration: InputDecoration(
                      //     filled: true,
                      //     fillColor: Color(0xFFF8F7F7),
                      //     hintText: "Please enter birthday".tr,
                      //     hintStyle: TextStyle(fontSize: 15,color: _dobController.text == "" ?Colors.red: null),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),    focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //   ),
                      //     border: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),
                      //   ),
                      //   validator: (value) {},
                      //   onChanged: (value) {},
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      //
                      // ///Gender
                      // Padding(
                      //   padding: EdgeInsets.only(left: 5.0),
                      //   child: Text('Gender'.tr,
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           fontFamily: 'Montserrat',
                      //           fontWeight: FontWeight.w500,
                      //           color:
                      //           ThemeColors.blackColor.withOpacity(0.6))),
                      // ),
                      // TextFormField(
                      //   readOnly: true,
                      //   controller: _genderController,
                      //   textAlign: TextAlign.start,
                      //   keyboardType: TextInputType.text,
                      //   style: TextStyle(
                      //       fontSize: 18,
                      //       height: 1.5,
                      //       color:
                      //       ThemeColors.blackColor.withOpacity(0.6)
                      //   ),
                      //   decoration: InputDecoration(
                      //     filled: true,
                      //     fillColor: Color(0xFFF8F7F7),
                      //     hintText: "Please enter gender".tr,
                      //     hintStyle: TextStyle(fontSize: 15,color: _genderController.text == "" ?Colors.red: null),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),    focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //   ),
                      //     border: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),
                      //   ),
                      //   validator: (value) {},
                      //   onChanged: (value) {},
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      //
                      //
                      // ///Pin Code
                      // Padding(
                      //   padding: EdgeInsets.only(left: 5.0),
                      //   child: Text('Pin Code'.tr,
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           fontFamily: 'Montserrat',
                      //           fontWeight: FontWeight.w500,
                      //           color:
                      //           ThemeColors.blackColor.withOpacity(0.6))),
                      // ),
                      // TextFormField(
                      //   readOnly: true,
                      //   controller: _pinCodeController,
                      //   textAlign: TextAlign.start,
                      //   keyboardType: TextInputType.text,
                      //   style: TextStyle(
                      //       fontSize: 18,
                      //       height: 1.5,
                      //       color:
                      //       ThemeColors.blackColor.withOpacity(0.6)
                      //   ),
                      //   decoration: InputDecoration(
                      //     filled: true,
                      //     fillColor: Color(0xFFF8F7F7),
                      //     hintText: "Enter pin code".tr,
                      //     hintStyle: TextStyle(fontSize: 15,color: _pinCodeController.text == "" ?Colors.red: null),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),
                      //     border: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                      //     ),
                      //   ),
                      //   validator: (value) {},
                      //   onChanged: (value) {},
                      // ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///City
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text('City'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _cityController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color:
                            ThemeColors.blackColor.withOpacity(0.6)
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter city".tr,
                          hintStyle: TextStyle(fontSize: 15,color: _cityController.text == "" ?Colors.red: null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
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
                        child: Text('Address'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _addressController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color:
                            ThemeColors.blackColor.withOpacity(0.6)
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter address".tr,
                          hintStyle: TextStyle(fontSize: 15,color: _districtController.text == "" ?Colors.red: null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
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
                        child: Text('Message (Optional)'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _messageController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color:
                            ThemeColors.blackColor.withOpacity(0.6)
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter message".tr,
                          hintStyle: TextStyle(fontSize: 15,color: _stateController.text == "" ?Colors.red: null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeColors.blackColor.withOpacity(0.2)),
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
    );

  }

}
