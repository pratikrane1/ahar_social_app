import 'package:aharconnect/controller/profile_controller.dart';
import 'package:aharconnect/data/model/profile_model.dart';
import 'package:aharconnect/data/model/response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/app_button.dart';
import 'package:aharconnect/widget/custom_snackbar.dart';

class MyProfileEditScreen extends StatefulWidget {
  const MyProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileEditScreen> createState() => _MyProfileEditScreenState();
}

class _MyProfileEditScreenState extends State<MyProfileEditScreen> {
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _messageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;

  Profile? _profileData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileData = Get.find<MyProfileController>().profileData;
    print(_profileData);
    getData();
  }

  getData() {
    _nameController.text = _profileData!.name ?? "";
    _phoneController.text = _profileData!.mobileNo ?? "";
    _emailController.text = _profileData!.email ?? "";
    _businessNameController.text = _profileData!.businessName ?? "";
    _cityController.text = _profileData!.city ?? "";
    _addressController.text = _profileData!.address ?? "";
    _messageController.text = _profileData!.bio ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
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
            // await Get.find<myProfileController>().profileData;
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
          'Edit Details'.tr,
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
      body: GetBuilder<MyProfileController>(builder: (myProfileController) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        controller: _nameController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: ThemeColors.blackColor.withOpacity(0.6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter full name".tr,
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _nameController.text == ""
                                  ? Colors.red
                                  : null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
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
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                    ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        controller: _businessNameController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: ThemeColors.blackColor.withOpacity(0.6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter business Name",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _cityController.text == ""
                                  ? Colors.red
                                  : null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
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
                                color:
                                    ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        controller: _phoneController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: ThemeColors.blackColor.withOpacity(0.6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter phone number".tr,
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _phoneController.text == ""
                                  ? Colors.red
                                  : null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
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
                                color:
                                    ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        controller: _emailController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: ThemeColors.blackColor.withOpacity(0.6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter email".tr,
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _emailController.text == ""
                                  ? Colors.red
                                  : null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
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
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                    ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        controller: _cityController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: ThemeColors.blackColor.withOpacity(0.6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter city".tr,
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _cityController.text == ""
                                  ? Colors.red
                                  : null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
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
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                    ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        controller: _addressController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: ThemeColors.blackColor.withOpacity(0.6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter address",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _addressController.text == ""
                                  ? Colors.red
                                  : null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
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
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                    ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        controller: _messageController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: ThemeColors.blackColor.withOpacity(0.6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter message",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _messageController.text == ""
                                  ? Colors.red
                                  : null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.blackColor.withOpacity(0.2)),
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
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: AppButton(
                  onPressed: () async {
                    _updateProfile(myProfileController);
                  },
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  text: Text(
                    'Save'.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'OpenSans-ExtraBold',
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
                height: 10,
              ),
            ],
          ),
        );
      }),
    );
  }

  void _updateProfile(MyProfileController myProfileController) async {
    String _name = _nameController.text.trim();
    String _city = _cityController.text.trim();
    String _businessName = _businessNameController.text.trim();
    String _mobileNumber = _phoneController.text.trim();
    String _email = _emailController.text.trim();
    String _address = _addressController.text.trim();

    final RegExp nameRegExp = RegExp(
        r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$",
        caseSensitive: false);
    final RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        caseSensitive: false);
    final phoneRegex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

    if (myProfileController.profileData!.name == _name &&
        myProfileController.profileData!.city == _city &&
        myProfileController.profileData!.address == _address &&
        myProfileController.profileData!.mobileNo == _mobileNumber &&
        myProfileController.profileData!.businessName == _businessName &&
        myProfileController.profileData!.email == _email) {
      showCustomSnackBar('change_something_to_update'.tr);
    } else if (_nameController.text == "") {
      showCustomSnackBar("please_enter_name".tr);
    } else if (!nameRegExp.hasMatch(_nameController.text.trim())) {
      showCustomSnackBar("please_enter_valid_name".tr);
    } else if (_businessNameController.text == "") {
      showCustomSnackBar("please_enter_business_name".tr);
    } else if (!nameRegExp.hasMatch(_businessNameController.text.trim())) {
      showCustomSnackBar("please_enter_valid_business_name".tr);
    } else if (_phoneController.text == "") {
      showCustomSnackBar("please_enter_phone_number".tr);
    } else if (!phoneRegex.hasMatch(_phoneController.text)) {
      showCustomSnackBar("please_enter_valid_phone_number".tr);
    } else if (_emailController.text == "") {
      showCustomSnackBar("please_enter_email".tr);
    } else if (!emailRegex.hasMatch(_emailController.text.trim())) {
      showCustomSnackBar("please_enter_valid_email".tr);
    } else if (!nameRegExp.hasMatch(_cityController.text.trim())) {
      showCustomSnackBar("please_enter_valid_city_name".tr);
    } else if (_cityController.text == "") {
      showCustomSnackBar("please_enter_city".tr);
    } else if (!nameRegExp.hasMatch(_addressController.text.trim())) {
      showCustomSnackBar("please_enter_valid_address_name".tr);
    } else if (_addressController.text == "") {
      showCustomSnackBar("please_enter_address".tr);
    } else {
      setState(() {
        _isLoading = false;
      });
      ResponseModel _responseModel = await Get.find<MyProfileController>()
          .updateProfileData(
              _nameController.text.trim(),
              _businessNameController.text.trim(),
              _phoneController.text.trim(),
              _emailController.text.trim(),
              _cityController.text.trim(),
              _addressController.text.trim(),
              _messageController.text.trim());
      if (_responseModel.isSuccess) {
        setState(() {
          _isLoading = true;
        });
        showCustomSnackBar('profile_updated_successfully'.tr, isError: false);
        // _profileData =
        //     Get.find<myProfileController>().profileData;
        // setState(() {});
      } else {
        showCustomSnackBar(_responseModel.message);
        setState(() {
          _isLoading = true;
        });
      }
    }
  }
}
