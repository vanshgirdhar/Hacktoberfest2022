// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print, prefer_final_fields

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getmygps/constants/myicons.dart';
import 'package:getmygps/home.dart';
import 'package:getmygps/login.dart';
import 'package:google_fonts/google_fonts.dart';

class signupPage extends StatefulWidget {
  const signupPage({Key? key}) : super(key: key);

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _emailController.removeListener(() => setState(() {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          // Display Image
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(
                                height: 320, child: SvgPicture.asset(loc2)),
                          ),
                          // Login Text
                          Text('Sign Up',
                              style: GoogleFonts.montserrat(
                                  fontSize: 35, fontWeight: FontWeight.bold)),
                          SizedBox(height: 40),
                          // name field start
                          TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  // prefix person icon
                                  prefixIcon:
                                      Icon(Icons.account_circle_outlined),

                                  // suffix clear icon
                                  suffixIcon: _nameController.text.isEmpty
                                      ? Container(width: 0)
                                      : IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () =>
                                              _nameController.clear()),
                                  // field editing
                                  hintText: "Full Name",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  labelText: "Full Name",
                                  contentPadding: EdgeInsets.only(left: 10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          // name field end
                          SizedBox(height: 25),
                          // email field start
                          TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                // prefix email icon
                                prefixIcon: Icon(Icons.alternate_email),
                                // suffix clear icon
                                suffixIcon: _emailController.text.isEmpty
                                    ? Container(width: 0)
                                    : IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () =>
                                            _emailController.clear()),
                                // field editing
                                hintText: "Email ID",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                labelText: "Email ID",
                                contentPadding: EdgeInsets.only(left: 10),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              // some keyboard settings
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              autofillHints: [AutofillHints.email],
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null),
                          // email field end
                          SizedBox(height: 25),
                          // password field start
                          TextField(
                            controller: _passwordController,
                              onChanged: (value) => setState(() =>
                                  _passwordController =
                                      value as TextEditingController),
                              onSubmitted: (value) => setState(() =>
                                  _passwordController =
                                      value as TextEditingController),
                              decoration: InputDecoration(
                                  // prefix lock icon
                                  prefixIcon: Icon(Icons.https_outlined),
                                  // suffix visibility icon
                                  suffixIcon: IconButton(
                                      icon: isPasswordVisible
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      onPressed: () => setState(() =>
                                          isPasswordVisible =
                                              !isPasswordVisible)),

                                  // field editing
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  labelText: "Password",
                                  // errorText: 'Wrong password',
                                  contentPadding: EdgeInsets.only(left: 10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              // password visibility on or off
                              obscureText: isPasswordVisible),
                          // password field end
                          SizedBox(height: 25),
                          // signup button
                          Row(children: [
                            Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      final form = formKey.currentState!;
                                      if (form.validate()) {
                                        FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text)
                                            .then((value) {
                                          print("Created New Account");
                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()))
                                              .onError((error, stackTrace) {
                                            print("Error ${error.toString()}");
                                          });
                                        });
                                      }
                                    },
                                    child: Container(
                                        height: 50,
                                        child: Center(
                                            child: Text("Sign Up",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        decoration: BoxDecoration(
                                            color: Color(0XFF6C63FF),
                                            borderRadius:
                                                BorderRadius.circular(20)))))
                          ]),
                          SizedBox(height: 12),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                              },
                              child: Center(
                                  child: Text('Already a member? Log In.',
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w500))))
                        ]))))));
  }
}
