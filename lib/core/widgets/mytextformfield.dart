import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.onSubmiited})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  Function? onSubmiited;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.teal.shade100,
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: TextFormField(
        controller: controller,
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none),
      ),
    );
  }
}
