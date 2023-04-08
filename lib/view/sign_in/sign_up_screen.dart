import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:page_transition/page_transition.dart';

import '../../app/typography.dart';
import '../../controller/app_controller.dart';
import 'login_in_screen.dart';
import 'widgets/already_have_an_account_check.dart';
import 'widgets/rounded_button.dart';
import 'widgets/rounded_input_field.dart';
import 'widgets/rounded_password_input_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                Text(
                  "SIGNUP",
                  style: fontStyle("black:700:14"),
                ),
                SizedBox(height: size.height * 0.03),
                const Hero(
                  transitionOnUserGestures: true,
                  tag: "logo",
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundImage: AssetImage('assets/images/logo.gif'),
                    radius: 50,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Name",
                  controller: _nameController,
                ),
                RoundedInputField(
                  hintText: "Your Email",
                  controller: _emailController,
                ),
                RoundedPasswordField(
                  controller: _passwordController,
                ),
                RoundedPasswordField(
                  hintText: "Confirm Password",
                  controller: _confirmPasswordController,
                ),

                Obx(() => RoundedButton(
                      text: "SIGNUP",
                      press: () {
                        FocusScope.of(context).unfocus();

                        appController.signUp(
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim().toLowerCase(),
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordController.text,
                        );
                      },
                      isLoading: appController.isLoading.value,
                    )),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const LoginScreen(),
                        duration: const Duration(milliseconds: 100),
                      ),
                    );
                  },
                ),
                // const OrVerticalDivider(),
                // const SignUpWithGoogle(),
              ],
            ),
          ),
        ));
  }
}
