

import 'dart:async';

import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/screen/bottom%20nav%20bar/bottom_nav.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/app_button.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyNumberScreen extends StatefulWidget {
  VerifyNumberScreen({
    Key? key,
    required this.mobileNumber
  }) : super(key: key);
  String mobileNumber;

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool loading = true;
  Timer? _timer;
  int _seconds = 0;


  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _otpController.clear();
    _timer?.cancel();
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if (_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context){

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
          GetBuilder<AuthController>(builder: (authController) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                extendBodyBehindAppBar: true,
                body: ListView(
                  children: [
                    const SizedBox(height: 80,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                      ),
                    ),
                    const SizedBox(height: 60,),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            'welcome_back'.tr,
                            style: GoogleFonts.openSans(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'please_login_to_your_account_to_continue'.tr,
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: ThemeColors.greyTextColor,
                                fontWeight: FontWeight.normal

                            ),

                          ),
                          const SizedBox(height: 50),

                          Text(
                            'mobile_no'.tr,
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 7,),

                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.mobileNumber}',
                                style: GoogleFonts.openSans(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 8,),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset(
                                  'assets/editing.png',
                                  height: 20,width: 20,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          // !: OTP field

                          Text(
                            'OTP_Code'.tr,
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left:30,right: 30,top: 20),
                            child: Center(
                              child: PinCodeTextField(
                                autoDisposeControllers: false,
                                length: 4,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  inactiveColor: ThemeColors.blackColor,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  activeFillColor: Colors.white,
                                  inactiveFillColor: Colors.white,
                                ),
                                animationDuration: const Duration(milliseconds: 300),
                                // backgroundColor: Colors.blue.shade50,
                                enableActiveFill: true,
                                controller: _otpController,
                                onCompleted: (v) {
                                },
                                onChanged: (value) {
                                  debugPrint(value);
                                  setState(() {
                                    // currentText = value;
                                  });
                                },
                                beforeTextPaste: (text) {
                                  return true;
                                },
                                appContext: context,
                              ),
                            ),
                          ),

                          ///Did not receive code
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(
                              'dit_not_received_the_otp'.tr,
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: ThemeColors.blackColor,
                                  fontWeight: FontWeight.w800),
                            ),
                            TextButton(
                              onPressed: _seconds < 1
                                  ? () {
                                _startTimer();
                                authController.login(widget.mobileNumber,);
                              }
                                  : null,
                              child: Text(
                                  '${'resend'.tr}${_seconds > 0 ? ' ($_seconds)' : ''}'),
                            ),
                          ]),

                          const SizedBox(height: 30),


                          Padding(
                            padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                            child: AppButton(
                              onPressed: () async {


                                if (_otpController.text == "") {
                                  showCustomSnackBar('please_enter_otp'.tr);
                                }else if (_otpController.text.length < 4) {
                                  showCustomSnackBar('please_enter_4_digit_otp'.tr);
                                }else if (_otpController.text.length > 4) {
                                  showCustomSnackBar('please_enter_4_digit_otp'.tr);
                                }else{
                                  setState(() {
                                    loading = false;
                                  });
                                  _verifyOtp(authController, _otpController.text.trim());
                                }
                              },
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              text: Text('login'.tr,style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700) ,),
                              loading: loading,
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(color: ThemeColors.buttonColor, width: 1),
                                backgroundColor: ThemeColors.buttonColor,
                                // color:Colors.red,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height:MediaQuery.of(context).viewInsets.bottom),

                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  void _verifyOtp(AuthController authController,String otp) async {


    var logData = await authController
        .verifyOTP(authController.loginModel!.data!.userId.toString(),otp)
        .then((status) {
      if (status.success == true) {
        authController.saveUserNumber(status.data!.mobileNumber!.trim());
        authController.saveUserId(status.data!.userId!.toInt());
        Timer.periodic(const Duration(seconds: 2), (timer) {
          // Get.offNamed(RouteHelper.bottomNav);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
              BottomNavBar()));
          timer.cancel();
        });

        showCustomSnackBar(status.message!, isError: false);

      } else {
        showCustomSnackBar(status.message!, isError: true);
        setState(() {
          loading = true;
        });
      }
      setState(() {
        loading = authController.isVerifyOtpLoading;
      });
    });
    print(logData);
  }

}