import 'package:flutter/material.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const RoundedPasswordField({
    Key? key,
    required this.controller,
    this.hintText = "Password",
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: isPasswordVisible,
        controller: widget.controller,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            child: Icon(
              Icons.visibility,
              color: Theme.of(context).primaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
