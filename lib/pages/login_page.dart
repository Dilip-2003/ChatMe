import 'dart:developer';

import 'package:chat_me/services/alert_service.dart';
import 'package:chat_me/services/auth_service.dart';
import 'package:chat_me/services/navigation_service.dart';
import 'package:chat_me/utils/const.dart';
import 'package:chat_me/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _globalLoginFormKey = GlobalKey();
  String? email, password;
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _alertService = _getIt<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildLoginUI(),
    );
  }

  Widget _buildLoginUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          children: [
            _headerText(),
            _loginForm(),
            _createAnAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Hi, Welcome Back!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "Hello again, you have been missed",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Form(
        key: _globalLoginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomFormField(
              hintText: 'Email',
              height: MediaQuery.of(context).size.height * 0.1,
              validationRegExp: emailValidation,
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            CustomFormField(
              hintText: 'Password',
              height: MediaQuery.of(context).size.height * 0.1,
              validationRegExp: passwordValidation,
              obscureText: true,
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        onPressed: () async {
          if (_globalLoginFormKey.currentState!.validate()) {
            _globalLoginFormKey.currentState!.save();

            bool result = await _authService.login(email!, password!);
            if (result) {
              _navigationService.pushedReplacementName('/home');
            } else {
              _alertService.showToast(
                text: 'Failed to login, Please try again.',
                icon: Icons.error,
              );
            }
            log(result.toString());
            log(email.toString());
            log(password.toString());
          }
          log('login button');
        },
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _createAnAccountLink() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          "Don't have an account? ",
        ),
        GestureDetector(
          onTap: () {
            _navigationService.pushedName('/register');
            log('go to sign up');
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        )
      ],
    ));
  }
}
