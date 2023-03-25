import 'package:amlelshefaa/bloc/cubit/app_cubit.dart';
import 'package:amlelshefaa/core/constants/strings.dart';
import 'package:amlelshefaa/core/utils/app_colors.dart';
import 'package:amlelshefaa/core/utils/size_config.dart';
import 'package:amlelshefaa/core/widgets/custom_general_button.dart';
import 'package:amlelshefaa/core/widgets/space.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoosePhotoScreen extends StatelessWidget {
  const ChoosePhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          title: const Text("Choose Photo"),
          backgroundColor: AppColors.secondaryColor,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final cubit = AuthCubit.get(context);
                return Center(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    width: SizeConfig.screenHeight! / 2.2,
                    height: SizeConfig.screenHeight! / 2.2,
                    // color: Colors.black,
                    child: FirebaseAuth.instance.currentUser!.photoURL != null
                        ? Image.network(
                            FirebaseAuth.instance.currentUser!.photoURL!,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox.shrink(),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize!,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomGeneralButton(
                      callback: () {
                        AuthCubit.get(context).uploadDoctorPhoto();
                      },
                      text: "Upload Photo",
                    ),
                  ),
                  const HorizontalSpace(),
                  Expanded(
                    child: CustomGeneralButton(
                      callback: () {
                        Navigator.pushReplacementNamed(context, homeLayout);
                      },
                      text: "Next",
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
