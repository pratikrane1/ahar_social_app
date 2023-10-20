import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/utils/constants.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/view/screen/authentication/screens/verify_number.dart';
import 'package:aharconnect/view/widget/app_button.dart';
import 'package:aharconnect/view/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController _phoneController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _phoneController = TextEditingController();
    super.initState();
    Future<void>.delayed(
        const Duration(milliseconds: 300), _tryPasteCurrentPhone);
  }

  Future _tryPasteCurrentPhone() async {
    if (!mounted) return;
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;
      if (phone == null) return;
      if (!mounted) return;
      _phoneController.text = phone;
    } on PlatformException catch (e) {
      print('Failed to get mobile number because of: ${e.message}');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            child: Image.asset(
              Images.loginBackground,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: true,
            body: Padding(
              padding: const EdgeInsets.all(18.0).copyWith(top: 180),
              child: GetBuilder<AuthController>(builder: (authController) {
                return ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'welcome_back'.tr,
                      style: GoogleFonts.openSans(
                          fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'please_login_to_your_account_to_continue'.tr,
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: ThemeColors.greyTextColor,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 50),

                    Text(
                      'mobile_no'.tr,
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // !: Mobile No field
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      )),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'phone_number_required'.tr;
                          }
                          return null;
                        },
                        controller: _phoneController,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                        ),
                        // controller: _nameController,
                        cursorColor: ThemeColors.blackColor,
                        autofocus: false,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          counterText: ' ',
                          fillColor: ThemeColors.textFieldBackgroundColor,
                          filled: true,
                          // isCollapsed: true,
                          contentPadding: const EdgeInsets.all(20),
                          hintText: 'your_mobile_number'.tr,
                          hintStyle: GoogleFonts.openSans(
                            fontSize: 17,
                          ),
                          focusedErrorBorder: kFocusedErrorBorder,
                          errorBorder: kErrorBorder,
                          enabledBorder: kEnabledBorder,
                          focusedBorder: kFocusedBorder,
                          border: kBorder,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: AppButton(
                        onPressed: () async {
                          String? phone;

                          if (_phoneController.text != null) {
                            // String? num = phoneController.text.trim();
                            phone = _phoneController.text.trim();
                            // phone = num.substring(num.length - 10);
                          }
                          if (phone!.length < 10) {
                            showCustomSnackBar(
                                'please_enter_10_digit_number'.tr);
                          } else if (phone.length > 13) {
                            showCustomSnackBar('please_enter_valid_number'.tr);
                          } else if (phone.isEmpty) {
                            showCustomSnackBar('please_enter_phone_number'.tr);
                          } else {
                            setState(() {
                              loading = false;
                            });

                            _login(
                                authController, _phoneController.text.trim());
                          }
                        },
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        text: Text(
                          'next'.tr,
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        loading: loading,
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              color: ThemeColors.buttonColor, width: 1),
                          backgroundColor: ThemeColors.buttonColor,
                          // color:Colors.red,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  void _login(AuthController authController, String number) async {
    String _numberWithCountryCode =
        number.length > 10 ? number.substring(number.length - 10) : "${number}";
    // String _numberWithCountryCode = number;

    var logData = await authController
        .login(
      _numberWithCountryCode,
    )
        .then((status) {
      if (status.success == true) {
        showCustomSnackBar(status.message!, isError: false);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyNumberScreen(
                      mobileNumber: _numberWithCountryCode,
                      userId: status.data!.userId.toString(),
                    )));
      } else {
        showCustomSnackBar(status.message!, isError: true);

        authController.clearUserNumber();
        setState(() {
          loading = true;
        });
      }
      setState(() {
        loading = authController.isLoading;
      });
    });
    print(logData);
  }
}
