import 'package:flutter/material.dart';
import 'package:socialrecipe/screen/authentication/widgets/log_in_form.dart';
import 'package:socialrecipe/screen/authentication/widgets/log_in_form_old.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // bottomNavigationBar: SizedBox(
        //   height: MediaQuery.of(context).size.height / 40,
        // ),
        resizeToAvoidBottomInset: false,
        body: LoginForm(
          formKey: _formKey,
          phoneController: _phoneController,
        ),
      ),
    );
  }
}
