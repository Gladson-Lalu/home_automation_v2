import 'package:flutter/material.dart';

import '../../../app/typography.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(login ? "Don’t have an Account? " : "Already have an Account? ",
            style: fontStyle("black:400:14")),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: fontStyle("black:700:14"),
          ),
        ),
      ],
    );
  }
}
