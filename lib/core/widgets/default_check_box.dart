import '../constants/constants.dart';
import '../utils/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultCheckBox extends StatefulWidget {
  const DefaultCheckBox({
    Key? key,
    required this.checkInfo,
  }) : super(key: key);
  final String checkInfo;
  @override
  State<DefaultCheckBox> createState() => _DefaultCheckBoxState();
}

class _DefaultCheckBoxState extends State<DefaultCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 1.4,
          child: Checkbox(
            hoverColor: AppColors.secondaryColor,
            focusColor: AppColors.secondaryColor,
            checkColor: AppColors.mainColor,
            activeColor: AppColors.secondaryColor,
            value: value,
            onChanged: (bool? val) {
              setState(() {
                value = val!;
              });
            },
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
            side: const BorderSide(color: AppColors.secondaryColor),
          ),
        ),
        Text(
          widget.checkInfo,
          style: const TextStyle(
            color: AppColors.formFontColor,
            fontFamily: 'SFPro',
          ),
        ),
      ],
    );
  }
}
