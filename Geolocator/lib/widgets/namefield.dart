// ignore_for_file: camel_case_types, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class nameField extends StatefulWidget {
  final TextEditingController nameController;

  const nameField({Key? key, required this.nameController}) : super(key: key);

  @override
  State<nameField> createState() => _nameFieldState();
}

class _nameFieldState extends State<nameField> {
  
  @override
  void initState() {
    super.initState();

    widget.nameController.addListener(onListen);
  }

  @override
  void dispose() {
    widget.nameController.removeListener(onListen);

    super.dispose();
  }
  
  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.nameController,
        decoration: InputDecoration(
            // prefix person icon
            prefixIcon: Icon(Icons.account_circle_outlined),

            // suffix clear icon
          suffixIcon: widget.nameController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => widget.nameController.clear()),
            // field editing
            hintText: "Full Name",
            hintStyle: TextStyle(color: Colors.grey[400]),
            labelText: "Full Name",
            contentPadding: EdgeInsets.only(left: 10),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))));
  }
}
