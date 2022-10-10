// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class emailField extends StatefulWidget {
  final TextEditingController emailController;

  const emailField({Key? key, required this.emailController}) : super(key: key);

  @override
  State<emailField> createState() => _emailFieldState();
}

class _emailFieldState extends State<emailField> {
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();

    emailController.addListener(onListen);
  }

  @override
  void dispose() {
    emailController.removeListener(onListen);

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return TextFormField (
        controller: emailController,
        decoration: InputDecoration(
          // prefix email icon
          prefixIcon: Icon(Icons.alternate_email),
          // suffix clear icon
          suffixIcon: emailController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => emailController.clear()),
          // field editing
          hintText: "Email ID",
          hintStyle: TextStyle(color: Colors.grey[400]),
          labelText: "Email ID",
          contentPadding: EdgeInsets.only(left: 10),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        // some keyboard settings
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        autofillHints: [AutofillHints.email],
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? 'Enter a valid email'
            : null);
  }
}
