import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/app_controller.dart';
import 'package:page_transition/page_transition.dart';

import '../../app/typography.dart';
import 'sign_up_screen.dart';
import 'widgets/already_have_an_account_check.dart';
import 'widgets/rounded_button.dart';
import 'widgets/rounded_input_field.dart';
import 'widgets/rounded_password_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isForgot = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              children: [
                SizedBox(height: size.height * 0.03),
                isForgot
                    ? Text(
                        "FORGOT PASSWORD",
                        style: fontStyle("black:700:14"),
                      )
                    : Text(
                        "LOGIN",
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
                buildLoginForgotForm(size),
                SizedBox(height: size.height * 0.02),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isForgot = !isForgot;
                    });
                  },
                  child: isForgot
                      ? Text("Login Now!", style: fontStyle("black:400:12"))
                      : Text(
                          "Forgot Password?",
                          style: fontStyle("black:400:12"),
                        ),
                ),
                SizedBox(height: size.height * 0.02),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: SignUpScreen(),
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 100),
                      ),
                    );
                  },
                ),
                // const OrVerticalDivider(),
                // const SignInWithGoogle(),
              ],
            ),
          ),
        ));
  }

  Widget buildLoginForgotForm(Size size) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 100),
      firstChild:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: size.height * 0.03),
        RoundedInputField(
          hintText: "Your Email",
          controller: _emailController,
        ),
        RoundedPasswordField(
          controller: _passwordController,
        ),
        Obx(() {
          return RoundedButton(
            text: "LOGIN",
            isLoading: appController.isLoading.value,
            press: () {
              FocusScope.of(context).unfocus();
              appController.signIn(
                email: _emailController.text.trim().toLowerCase(),
                password: _passwordController.text.trim(),
              );
            },
          );
        }),
      ]),
      secondChild:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: size.height * 0.03),
        RoundedInputField(
          hintText: "Your Email",
          controller: _emailController,
        ),
        RoundedButton(
          text: "CONTINUE",
          isLoading: false,
          press: () {},
        ),
      ]),
      crossFadeState:
          isForgot ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
