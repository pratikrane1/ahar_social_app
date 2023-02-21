import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:socialrecipe/screen/authentication/screens/verify_number.dart';
import 'package:socialrecipe/utils/app_pages.dart';
import 'package:socialrecipe/utils/constants.dart';

import 'package:socialrecipe/screen/authentication/widgets/auth_bottom_rich_text.dart';
import 'package:socialrecipe/screen/authentication/widgets/auth_confirm_button.dart';
import 'package:socialrecipe/providers/auth_provider.dart';
import 'package:socialrecipe/providers/settings_provider.dart';
import 'package:socialrecipe/providers/user_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:socialrecipe/utils/images.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/app_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.formKey,
    required this.phoneController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isLoading = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    AuthProvider appState = Provider.of<AuthProvider>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Stack(
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
          extendBodyBehindAppBar: true,
          body: Container(
            // height: MediaQuery.of(context).size.height,
            // constraints: const BoxConstraints.expand(),
            //
            // decoration:  const BoxDecoration(
            //           image: DecorationImage(
            //             image: AssetImage(Images.loginBackground),
            //             fit: BoxFit.fill,
            //             // fit: BoxFit.cover,
            //           ),
            //         ),
            child: Padding(
              padding: const EdgeInsets.all(18.0).copyWith(top: 200),
              child: Form(
                key: widget.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome back, ',
                        style: TextStyle(
                          fontSize: 34,
                          fontFamily: 'OpenSans-ExtraBold',
                        ),
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
                          fontSize: 14,
                          fontFamily: 'OpenSans-Light',
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
                              return 'Phone Number Required';
                            }
                            return null;
                          },
                          controller: widget.phoneController,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          // controller: _nameController,
                          cursorColor: kOrangeColor,
                          autofocus: false,
                          autocorrect: false,
                          keyboardType: TextInputType.number,

                          obscureText: false,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            counterText: ' ',
                            fillColor: settingsManager.darkMode
                                ? kGreyColor
                                : ThemeColors.textFieldBackgroundColor,
                            filled: true,
                            // isCollapsed: true,
                            contentPadding: const EdgeInsets.all(18),
                            hintText: 'Your Mobile Number',
                            hintStyle:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      fontSize: 16,
                                      color: ThemeColors.greyTextColor,
                                      // fontWeight: FontWeight.bold,
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VerifyNumberScreen()));
                          },
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          text: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'OpenSans-ExtraBold',
                                fontWeight: FontWeight.w700),
                          ),
                          loading: true,
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color: ThemeColors.buttonColor, width: 1),
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
