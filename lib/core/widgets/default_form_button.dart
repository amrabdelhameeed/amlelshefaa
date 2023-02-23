import '../utils/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultFormButton extends StatelessWidget {
  DefaultFormButton(
      {Key? key,
      this.width = double.infinity,
      this.height = 65,
      this.radius = 20,
      this.padding = 10,
      this.onPressed,
      this.isBorder = false,
      required this.text,
      this.fillColor,
      this.textColor = AppColors.secondaryColor,
      this.fontSize})
      : super(key: key);
  final bool isBorder;
  final VoidCallback? onPressed;
  final String text;
  Color? textColor;
  Color? fillColor = Colors.transparent;
  double? fontSize = 17.0;
  double width;
  double height;
  double radius;
  double padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(vertical: padding),
        width: width,
        decoration: BoxDecoration(
            color: fillColor, border: Border.all(width: isBorder ? 1 : 0, color: isBorder ? AppColors.secondaryColor : Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontFamily: 'SFPro',
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
