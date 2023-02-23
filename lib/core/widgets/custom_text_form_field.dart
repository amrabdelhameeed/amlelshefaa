import '../constants/strings.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key, this.maxLines, this.onChanged, this.onSaved, this.suffixIcon, this.textInputType}) : super(key: key);
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final ValueSetter? onSaved;
  final ValueSetter? onChanged;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      decoration: InputDecoration(filled: true, fillColor: Colors.transparent, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: kmMainColor))),
    );
  }
}
