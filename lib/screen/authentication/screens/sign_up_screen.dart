import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialrecipe/screen/authentication/widgets/sign_up_form.dart';
import 'package:socialrecipe/utils/app_pages.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          bottomOpacity: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            splashRadius: 30,
            onPressed: () {
              Navigator.pushNamed(context, AppPages.loginPath);
            },
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.grey.shade500,
              size: 21,
            ),
          ),
        ),
        body: SignupForm(
          formKey: _formKey,
          userNameController: _userNameController,
          emailController: _emailController,
          passwordController: _passwordController,
        ),
      ),
    );
  }
}
