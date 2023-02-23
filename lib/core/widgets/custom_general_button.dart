import '../utils/app_colors.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton({Key? key, this.text, this.color = AppColors.secondaryColor, this.callback}) : super(key: key);
  final String? text;
  final Color? color;
  final VoidCallback? callback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: SizeConfig.screenWidth,
        height: 60,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          text ?? "Next",
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
