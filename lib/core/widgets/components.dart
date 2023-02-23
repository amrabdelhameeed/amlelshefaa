//   Write by BALY
import 'package:flutter/material.dart';

Widget textFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required final label,
  double radius = 0,
  int? maxLength,
  // Function? onTab,
  double? labelSized,
  bool obscureText = false,
}) {
  return TextFormField(
    maxLength: maxLength,
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelStyle: TextStyle(
        fontSize: labelSized,
      ),
      hintMaxLines: maxLength,
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
    ),
  );
}

Widget defaultHeader({
  required String? text,
}) =>
    Padding(
      padding: const EdgeInsetsDirectional.only(start: 10),
      child: Text(
        '$text',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

// Write be BALY
void navigateTo({context, widget}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

buildSnackBar({context, text, color = Colors.black}) {
  final snack = SnackBar(
    content: Text(text),
    duration: const Duration(seconds: 2),
    backgroundColor: color,
  );

  ScaffoldMessenger.of(context).showSnackBar(snack);
}
