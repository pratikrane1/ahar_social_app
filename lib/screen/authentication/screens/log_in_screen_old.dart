import 'package:flutter/material.dart';
import 'package:socialrecipe/screen/authentication/widgets/log_in_form_old.dart';

class LogInScreenOld extends StatefulWidget {
  const LogInScreenOld({Key? key}) : super(key: key);

  @override
  State<LogInScreenOld> createState() => _LogInScreenOldState();
}

class _LogInScreenOldState extends State<LogInScreenOld> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        resizeToAvoidBottomInset: false,
        body: LoginFormOld(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
        ),
      ),
    );
  }
}
