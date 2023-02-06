import 'package:flutter/material.dart';
import 'package:socialrecipe/screen/authentication/widgets/log_in_form.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
        body: LoginForm(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
        ),
      ),
    );
  }
}
