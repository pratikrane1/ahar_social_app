

import 'package:flutter/material.dart';
import 'package:socialrecipe/screen/home/screens/home_screen.dart';
import 'package:socialrecipe/utils/app_pages.dart';
import 'package:socialrecipe/utils/images.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/app_button.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:socialrecipe/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:socialrecipe/providers/auth_provider.dart';
import 'package:socialrecipe/providers/settings_provider.dart';
import 'package:get/get.dart';

class VerifyNumberScreen extends StatefulWidget {
  const VerifyNumberScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _otpController.clear();
  }

  @override
  Widget build(BuildContext context){
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    AuthProvider appState = Provider.of<AuthProvider>(context, listen: false);
    final settingsManager =
    Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),

        decoration:  const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.loginBackground),
            fit: BoxFit.fill,
            // fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios)),
              ),
            ),
            SizedBox(height: 60,),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    'Welcome back, ',
                    style: TextStyle(
                      fontSize: 34,
                      fontFamily: 'OpenSans-ExtraBold',),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Please login to your account to continue',
                    style: TextStyle(
                      fontSize: 14,
                      color: ThemeColors.greyTextColor,
                      fontFamily: 'OpenSans-Light',
                    ),

                  ),
                  const SizedBox(height: 50),

                  Text(
                    'Mobile No.',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans-Light',
                    ),
                  ),
                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Text(
                        '123456789',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'OpenSans-Light',
                        ),
                      ),
                      SizedBox(width: 8,),
                      Icon(FlatIcons.edit_1,size: 20,)
                    ],
                  ),

                  const SizedBox(height: 15),

                  // !: OTP field

                  Text(
                    'OTP Code',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans-Light',
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left:30,right: 30,top: 20),
                    child: Center(
                      child: PinCodeTextField(
                        autoDisposeControllers: false,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          // inactiveColor: ThemeColors.textFieldHintColor,
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
                          debugPrint("Completed");
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


                  const SizedBox(height: 30),


                  Padding(
                    padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                    child: AppButton(
                      onPressed: () async {
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                        //     HomeScreen()));
                        final navigator = Navigator.of(context);

                        final output = await appState.logInUser(
                          userEmail: 'pratik.rane@desteksolutions.com',
                          userPassword: '12345678',
                        );
                        await userProvider.refreshUser();
                        if (output == null) {
                          // navigator.pushReplacementNamed(AppPages.home);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                              HomeScreen()));
                        }
                        setState(() {
                          // _isLoading = false;
                        });
                        if (output != null) {
                          Get.snackbar(
                            'Error',
                            output,
                            snackPosition: SnackPosition.TOP,
                            forwardAnimationCurve: Curves.elasticInOut,
                            reverseAnimationCurve: Curves.easeOut,
                            colorText: settingsManager.darkMode
                                ? Colors.white
                                : Colors.black,
                          );
                        }
                      },
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      text: Text('Login',style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,fontFamily: 'OpenSans-ExtraBold',
                          fontWeight: FontWeight.w700) ,),
                      loading: true,
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: ThemeColors.buttonColor, width: 1),
                        backgroundColor: ThemeColors.buttonColor,
                        // color:Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50))),
                      ),


                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}