import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/app_button.dart';
import 'package:socialrecipe/widget/custom_snackbar.dart';

class MyAccountEditScreen extends StatefulWidget {
  const MyAccountEditScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountEditScreen> createState() => _MyAccountEditScreenState();
}

enum Gender { male, female, other }

class _MyAccountEditScreenState extends State<MyAccountEditScreen> {
  final _nameController = TextEditingController();
  final _bankAccountController = TextEditingController();
  final _ifscCodeController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();
  final _genderController = TextEditingController();
  final _dateController = TextEditingController();
  final _pancardController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  // Profile? _profileData;
  bool _isLoading = true;
  // PostOfficeModel? locationData;

  // Gender? _selectedGender = Gender.male;
  Gender? _selectedGender;
  String? _genderValue;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    // _profileData = Get.find<MyAccountController>().profileData;
    // print(_profileData);
    // getData();
  }

  // getData() {
  //   _nameController.text = _profileData!.name ?? "";
  //   _bankAccountController.text = _profileData!.bankAccount ?? "";
  //   _ifscCodeController.text = _profileData!.ifscCode ?? "";
  //   _pinCodeController.text = _profileData!.pinCode ?? "";
  //   _cityController.text = _profileData!.city ?? "";
  //   _districtController.text = _profileData!.district ?? "";
  //   _stateController.text = _profileData!.state ?? "";
  //   _dateController.text = _profileData!.dateOfBirth ?? "";
  //   _pancardController.text = _profileData!.panCard ?? "";
  //   if (_profileData!.gender == "male") {
  //     _selectedGender = Gender.male;
  //   } else if (_profileData!.gender == "female") {
  //     _selectedGender = Gender.female;
  //   } else if (_profileData!.gender == "other") {
  //     _selectedGender = Gender.other;
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _bankAccountController.dispose();
    _ifscCodeController.dispose();
    _pinCodeController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _dateController.dispose();
    _genderController.dispose();
    _pancardController.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: selectedDate,
      initialDate: selectedDate == null ? DateTime.now() : selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1945),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        if (selectedDate != null) {
          _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
        }
      });
    }
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
        body: SingleChildScrollView(
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
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                        ),
                        validator: (value) {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///bank account
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text('Bank Account'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        controller: _bankAccountController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: ThemeColors.blackColor.withOpacity(0.6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter bank account".tr,
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _bankAccountController.text == ""
                                  ? Colors.red
                                  : null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                        ),
                        validator: (value) {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///Ifsc code
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text('IFSC Code'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        controller: _ifscCodeController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: ThemeColors.blackColor.withOpacity(0.6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter IFSC code".tr,
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _ifscCodeController.text == ""
                                  ? Colors.red
                                  : null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                        ),
                        validator: (value) {},
                        onChanged: (value) {
                          _ifscCodeController.value = TextEditingValue(
                              text: value.toUpperCase(),
                              selection: _ifscCodeController.selection
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///BirthDay
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text('Birthday'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: _dateController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              color: ThemeColors.blackColor.withOpacity(0.6)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF8F7F7),
                            hintText: "Please enter birthday".tr,
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: _dateController.text == ""
                                    ? Colors.red
                                    : null),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ThemeColors.blackColor
                                      .withOpacity(0.2)),
                            ),
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
                          onChanged: (value) {
                            setState(() {
                              _dateController.text = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///Gender
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text('Gender'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio<Gender>(
                                fillColor: MaterialStateColor.resolveWith(
                                        (states) => ThemeColors.primaryColor),
                                value: Gender.male,
                                groupValue: _selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                              Text('male'.tr)
                            ],
                          ),
                          Row(
                            children: [
                              Radio<Gender>(
                                fillColor: MaterialStateColor.resolveWith(
                                        (states) => ThemeColors.primaryColor),
                                value: Gender.female,
                                groupValue: _selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                              Text('female'.tr),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<Gender>(
                                fillColor: MaterialStateColor.resolveWith(
                                        (states) => ThemeColors.primaryColor),
                                value: Gender.other,
                                groupValue: _selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                              Text('other'.tr),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      ///Pin Code
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text('Pin Code'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6))),
                      ),
                      TextFormField(
                        controller: _pinCodeController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: ThemeColors.blackColor.withOpacity(0.6)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F7F7),
                          hintText: "Enter pin code".tr,
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: _pinCodeController.text == ""
                                  ? Colors.red
                                  : null),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                ThemeColors.blackColor.withOpacity(0.2)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.length > 6) {
                            showCustomSnackBar("enter_valid_pin_code".tr);
                          }
                        },
                        onChanged: (value) async {
                          String pinPattern = "^[1-9]{1}[0-9]{2}\\s{0,1}[0-9]{3}\$";
                          RegExp pinRegExp = RegExp(pinPattern);

                          if (pinRegExp
                              .hasMatch(_pinCodeController.text)) {
                            if (value.length == 6) {
                              // locationData =
                              // await Get.find<MyAccountController>()
                              //     .getLocation(value);
                              // if (locationData != null) {
                              //   if (locationData!.postOffice != null) {
                              //     setState(() {
                              //       _cityController.text = locationData!
                              //           .postOffice![0].region
                              //           .toString();
                              //       _districtController.text = locationData!
                              //           .postOffice![0].district
                              //           .toString();
                              //       _stateController.text = locationData!
                              //           .postOffice![0].state
                              //           .toString();
                              //     });
                              //   } else {
                              //     showCustomSnackBar("enter_valid_pin_code".tr);
                              //   }
                              // }
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///CITY STATE DISTRICT
                      // locationData != null ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///City
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text('City'.tr,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors.blackColor
                                        .withOpacity(0.6))),
                          ),
                          TextFormField(
                            controller: _cityController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6)),
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

                          ///District
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text('District'.tr,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors.blackColor
                                        .withOpacity(0.6))),
                          ),
                          TextFormField(
                            controller: _districtController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6)),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFF8F7F7),
                              hintText: "Enter district".tr,
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: _districtController.text == ""
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

                          ///State
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text('State'.tr,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors.blackColor
                                        .withOpacity(0.6))),
                          ),
                          TextFormField(
                            controller: _stateController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                                color:
                                ThemeColors.blackColor.withOpacity(0.6)),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFF8F7F7),
                              hintText: "Enter state".tr,
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: _stateController.text == ""
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
                      // : SizedBox(),
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
                    // _updateProfile(myAccountController);
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
        ),);
  }

  // void _updateProfile(MyAccountController myAccountController)async{
  //   String _name = _nameController.text.trim();
  //   String _bankAccount = _bankAccountController.text.trim();
  //   String _ifscCode = _ifscCodeController.text.trim();
  //   String _pinCode = _pinCodeController.text.trim();
  //   String _city = _cityController.text.trim();
  //   String _district = _districtController.text.trim();
  //   String _state = _stateController.text.trim();
  //   String _gender = _genderController.text.trim();
  //   String _dateOfBirth = _dateController.text.trim();
  //   String _pancard = _pancardController.text.trim();
  //
  //   String pinPattern = "^[1-9]{1}[0-9]{2}\\s{0,1}[0-9]{3}\$";
  //   RegExp pinRegExp = RegExp(pinPattern);
  //
  //   final RegExp nameRegExp = RegExp(
  //       r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$",
  //       caseSensitive: false);
  //   String pattern = '^[0-9]{9,18}\$';
  //   RegExp accountRegExp = RegExp(pattern);
  //   // final RegExp accountRegExp = RegExp("[0-9]{9,18}");
  //   String ifscPattern = '^[A-Z]{4}0[A-Z0-9]{6}\$';
  //   RegExp ifscRegExp = RegExp(ifscPattern);
  //
  //
  //   String pancardPattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
  //   RegExp pancardRegExp = RegExp(pancardPattern);
  //
  //
  //   if (myAccountController.profileData!.name == _name &&
  //       myAccountController.profileData!.bankAccount == _bankAccount &&
  //       myAccountController.profileData!.ifscCode == _ifscCode &&
  //       myAccountController.profileData!.pinCode == _pinCode &&
  //       myAccountController.profileData!.city == _city &&
  //       myAccountController.profileData!.district == _district &&
  //       myAccountController.profileData!.state == _state &&
  //       myAccountController.profileData!.panCard == _pancard &&
  //       myAccountController.profileData!.gender == _selectedGender!.name &&
  //       myAccountController.profileData!.dateOfBirth == _dateOfBirth) {
  //     showCustomSnackBar('change_something_to_update'.tr);
  //   } else if (_nameController.text == "") {
  //     showCustomSnackBar("please_enter_name".tr);
  //   } else if (!nameRegExp.hasMatch(_nameController.text)) {
  //     showCustomSnackBar("please_enter_valid_name".tr);
  //   } else if (_bankAccountController.text == "") {
  //     showCustomSnackBar("please_enter_bank_account".tr);
  //   } else if (!accountRegExp
  //       .hasMatch(_bankAccountController.text)) {
  //     showCustomSnackBar(
  //         "please_enter_valid_bank_account".tr);
  //   } else if (_ifscCodeController.text == "") {
  //     showCustomSnackBar("please_enter_ifsc_code".tr);
  //   } else if (!ifscRegExp
  //       .hasMatch(_ifscCodeController.text)) {
  //     showCustomSnackBar("please_enter_valid_ifsc_code".tr);
  //   } else if (_pancardController.text == "") {
  //     showCustomSnackBar("please_enter_pancard".tr);
  //   }else if (!pancardRegExp
  //       .hasMatch(_pancardController.text)) {
  //     showCustomSnackBar("please_enter_valid_pancard_number".tr);
  //   }  else if (_pinCodeController.text == "") {
  //     showCustomSnackBar("please_enter_pincode".tr);
  //   } else if (!pinRegExp.hasMatch(_pinCodeController.text)) {
  //     showCustomSnackBar("please_enter_valid_pincode".tr);
  //   }else if (!nameRegExp.hasMatch(_cityController.text)) {
  //     showCustomSnackBar("please_enter_valid_city_name".tr);
  //   } else if (_cityController.text == "") {
  //     showCustomSnackBar("please_enter_city".tr);
  //   } else if (!nameRegExp.hasMatch(_stateController.text)) {
  //     showCustomSnackBar("please_enter_valid_state_name".tr);
  //   } else if (_stateController.text == "") {
  //     showCustomSnackBar("please_enter_state".tr);
  //   } else if (!nameRegExp
  //       .hasMatch(_districtController.text)) {
  //     showCustomSnackBar(
  //         "please_enter_valid_district_name".tr);
  //   } else if (_districtController.text == "") {
  //     showCustomSnackBar("please_enter_district".tr);
  //   } else if (_dateController.text == "") {
  //     showCustomSnackBar("please_enter_birthday".tr);
  //   } else if (_selectedGender == null) {
  //     showCustomSnackBar("please_select_gender".tr);
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     ResponseModel _responseModel =
  //         await Get.find<MyAccountController>()
  //         .updateProfileData(
  //         _profileData!.id!.toInt(),
  //         _nameController.text,
  //         _bankAccountController.text,
  //         _ifscCodeController.text,
  //         _pinCodeController.text,
  //         _cityController.text,
  //         _districtController.text,
  //         _stateController.text,
  //         _dateController.text,
  //         _selectedGender!.name,
  //         _pancardController.text);
  //     if (_responseModel.isSuccess) {
  //       setState(() {
  //         _isLoading = true;
  //       });
  //       showCustomSnackBar('profile_updated_successfully'.tr,
  //           isError: false);
  //       // _profileData =
  //       //     Get.find<MyAccountController>().profileData;
  //       // setState(() {});
  //     } else {
  //       showCustomSnackBar(_responseModel.message);
  //       setState(() {
  //         _isLoading = true;
  //       });
  //     }
  //   }
  // }
}
