import 'dart:io';
import 'package:chat_me/services/alert_service.dart';
import 'package:chat_me/services/auth_service.dart';
import 'package:chat_me/services/media_service.dart';
import 'package:chat_me/services/navigation_service.dart';
import 'package:chat_me/services/storage_service.dart';
import 'package:chat_me/utils/const.dart';
import 'package:chat_me/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _globalRegisterKey = GlobalKey();

  File? selectedImage;
  final GetIt _getIt = GetIt.instance;
  late MediaService _mediaService;
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;
  late StorageService _storageService;
  String? name, email, password;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _alertService = _getIt.get<AlertService>();
    _storageService = _getIt.get<StorageService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUIRegisterPage(),
    );
  }

  Widget _buildUIRegisterPage() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            _headerText(),
            if (!isLoading) _registerForm(),
            if (!isLoading) _loginAccountLink(),
            if (isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
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
        children: [
          Text(
            "Let's, get going!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          Text(
            "Register the account using the form below.",
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

  Widget _registerForm() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Form(
        key: _globalRegisterKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _profilePictureSelection(),
            CustomFormField(
              hintText: 'Name',
              height: MediaQuery.of(context).size.height * 0.1,
              validationRegExp: nameValidation,
              onSaved: (value) => name = value,
            ),
            CustomFormField(
              hintText: 'Email',
              height: MediaQuery.of(context).size.height * 0.1,
              validationRegExp: emailValidation,
              onSaved: (value) => email = value,
            ),
            CustomFormField(
              obscureText: true,
              hintText: 'Password',
              height: MediaQuery.of(context).size.height * 0.1,
              validationRegExp: passwordValidation,
              onSaved: (value) => password = value,
            ),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  Widget _profilePictureSelection() {
    return GestureDetector(
      onTap: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: CircleAvatar(
        radius: 50,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : const NetworkImage(imagePlaceholder),
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        onPressed: () async {
          if (!_globalRegisterKey.currentState!.validate()) return;

          if (selectedImage == null) {
            _alertService.showToast(
              text: 'Please select a profile image.',
              icon: Icons.error,
            );
            return;
          }

          setState(() {
            isLoading = true;
          });

          _globalRegisterKey.currentState!.save();

          bool result = await _authService.SignUp(email!, password!);
          if (result) {
            // String? profileImagePath = await _storageService.uploadUserProfile(
            //   file: selectedImage!,
            //   uid: _authService.user!.uid,
            // );
            // if (profileImagePath != null) {
            //   _navigationService.pushedReplacementName('/home');
            // } else {
            //   _alertService.showToast(
            //     text: 'Failed to upload profile image.',
            //     icon: Icons.error,
            //   );
            // }
            _navigationService.pushedReplacementName('/home');
          } else {
            _alertService.showToast(
              text: 'Failed to register. Please try again.',
              icon: Icons.error,
            );
          }

          setState(() {
            isLoading = false;
          });
        },
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLink() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have an account? "),
          GestureDetector(
            onTap: () {
              _navigationService.goBack();
            },
            child: const Text(
              "Sign In",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
