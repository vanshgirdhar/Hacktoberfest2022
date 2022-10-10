// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';

class passwordField extends StatefulWidget {
  final TextEditingController passwordController;

  const passwordField({Key? key, required this.passwordController}) : super(key: key);

  @override
  State<passwordField> createState() => _passwordFieldState();
}

class _passwordFieldState extends State<passwordField> {
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (value) =>
            setState(() => passwordController = value as TextEditingController),
        onSubmitted: (value) =>
            setState(() => passwordController = value as TextEditingController),
        decoration: InputDecoration(
            // prefix lock icon
            prefixIcon: Icon(Icons.https_outlined),
            // suffix visibility icon
            suffixIcon: IconButton(
                icon: isPasswordVisible
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () =>
                    setState(() => isPasswordVisible = !isPasswordVisible)),

            // field editing
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey[400]),
            labelText: "Password",
            // errorText: 'Wrong password',
            contentPadding: EdgeInsets.only(left: 10),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        // password visibility on or off
        obscureText: isPasswordVisible);
  }
}
