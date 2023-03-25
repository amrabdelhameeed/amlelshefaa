import 'dart:math';

import 'package:amlelshefaa/core/widgets/space.dart';
import 'package:amlelshefaa/features/home/widgets/chat_screeen.dart';

import '../../core/constants/strings.dart';
import '../../core/utils/app_colors.dart';
import '../../core/widgets/default_form_button.dart';
import 'package:flutter/material.dart';

import '../../core/utils/size_config.dart';

// ignore: must_be_immutable
class SignInUPScreen extends StatelessWidget {
  SignInUPScreen({Key? key}) : super(key: key);

  late DateTime preBackpress;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          const snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F1D7),
        body: Stack(
          children: [
            ///flower1 TopRight
            Positioned(
              right: -120,
              top: 20,
              child: Transform.rotate(
                angle: .005,
                child: const Image(
                  image: AssetImage('assets/pictures/background/f.png'),
                ),
              ),
            ),

            ///flower2 TopRight
            Positioned(
              right: -66,
              top: 220,
              child: Transform.rotate(
                angle: -.04,
                child: const Image(
                  image: AssetImage('assets/pictures/background/f2.png'),
                ),
              ),
            ),

            /// flower3 TopLeft
            Positioned(
              left: -50,
              child: Image(
                image: const AssetImage('assets/pictures/background/f3.png'),
                fit: BoxFit.values[2],
                width: 120,
                height: 350,
              ),
            ),
            Positioned(
              height: SizeConfig.screenHeight,
              width: (SizeConfig.screenWidth)! / 1,
              top: SizeConfig.screenHeight! / 3.2,
              left: -70,
              child: const Image(
                image: AssetImage('assets/pictures/background/b.png'),
              ),
            ),

            /// Text And Button
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight! / 7,
                  ),

                  /// Title
                  const Text(
                    'Welocome to \nAml Elshefaa',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 38,
                      color: Color(0xfff5b53f),
                      letterSpacing: 0.36,
                      fontWeight: FontWeight.w700,
                      height: 1.1111111111111112,
                    ),
                    textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! / 8,
                  ),

                  /// Sign In Button
                  DefaultFormButton(
                    fillColor: AppColors.secondaryColor,
                    textColor: AppColors.mainColor,
                    text: "Sign In",
                    fontSize: 21,
                    onPressed: () {
                      Navigator.pushNamed(context, loginScreen);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! / 68,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultFormButton(
                          fontSize: 15,
                          fillColor: AppColors.secondaryColor,
                          textColor: AppColors.mainColor,
                          text: "Sign Up As Doctor",
                          onPressed: () {
                            Navigator.pushNamed(context, signUpAsDoctorScreen);
                          },
                        ),
                      ),
                      const HorizontalSpace(),
                      Expanded(
                        child: DefaultFormButton(
                          fontSize: 15,
                          fillColor: AppColors.secondaryColor,
                          textColor: AppColors.mainColor,
                          text: "Sign Up As Patient",
                          onPressed: () {
                            Navigator.pushNamed(context, categoryScreen);
                          },
                        ),
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: DefaultFormButton(
                      // fillColor: AppColors.secondaryColor,
                      textColor: AppColors.secondaryColor,
                      isBorder: true,
                      text: "Go To Chat Screen",
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ChatScreen(name: "anonymous ${Random().nextInt(300)}");
                          },
                        ));
                      },
                    ),
                  )

                  /// Sign Up Button
                  ,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
