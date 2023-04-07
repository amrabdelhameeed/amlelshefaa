// import 'dart:math';

// ignore_for_file: must_be_immutable

import 'package:amlelshefaa/app_router.dart';
import 'package:amlelshefaa/bloc/cubit/app_cubit.dart';
import 'package:amlelshefaa/core/constants/strings.dart';
import 'package:amlelshefaa/core/models/category_model.dart';
import 'package:amlelshefaa/core/models/doctor.dart';
import 'package:amlelshefaa/core/models/doctor_model.dart';
import 'package:amlelshefaa/core/models/user_model.dart';
import 'package:amlelshefaa/core/utils/size_config.dart';
import 'package:amlelshefaa/core/widgets/components.dart';
import 'package:amlelshefaa/core/widgets/default_form_button.dart';
import 'package:amlelshefaa/core/widgets/space.dart';
import 'package:amlelshefaa/features/home/widgets/chat_screeen.dart';
import 'package:amlelshefaa/features/home/widgets/custom_listview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/app_colors.dart';
import 'widgets/custom_shape.dart';
import 'widgets/customcarousel.dart';

class HomeScreenDoctor extends StatelessWidget {
  HomeScreenDoctor({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var bookNameController = TextEditingController();
  var authorNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var category = CategoryModel.categories;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomShape(),
          child: Container(
            height: 300,
            width: double.infinity,
            color: const Color(0xfff5b53f),
          ),
        ),
        BlocProvider<AuthCubit>.value(
            value: authCubit!..getRequests(),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = AuthCubit.get(context);
                return WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    key: scaffoldKey,
                    body: RefreshIndicator(
                      color: AppColors.secondaryColor,
                      onRefresh: () {
                        return Future.value();
                      },
                      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                        var cubit = AuthCubit.get(context);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: const Color(0xfff5b53f),
                              height: MediaQuery.of(context).viewPadding.top,
                            ),
                            defaultHeader(
                              text: 'Requests',
                            ),
                            Expanded(
                                child: cubit.requests.isEmpty
                                    ? Center(
                                        child: Text("There is No requests"),
                                      )
                                    : ListView.separated(
                                        physics: AlwaysScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(top: SizeConfig.defaultSize! * 7, left: SizeConfig.defaultSize! * 2, right: SizeConfig.defaultSize! * 2),
                                        itemCount: cubit.requests.length,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: SizeConfig.defaultSize!,
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsetsDirectional.only(top: SizeConfig.defaultSize!, end: SizeConfig.defaultSize! * 3),
                                            width: double.infinity,
                                            height: SizeConfig.defaultSize! * 10,
                                            decoration: BoxDecoration(color: Colors.amber.shade200, borderRadius: BorderRadius.all(Radius.circular(10))),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: FutureBuilder(
                                                  future: FirebaseFirestore.instance.collection('users').doc(cubit.requests[index].patientId).get(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: CircularProgressIndicator(),
                                                      );
                                                    } else {
                                                      final patient = UserModel.fromJson(snapshot.data!.data()!);
                                                      return Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Expanded(
                                                            child: Text(patient.name!),
                                                          ),
                                                          Expanded(
                                                              child: Padding(
                                                            padding: EdgeInsets.all(1),
                                                            child: TextButton(
                                                              child: FittedBox(
                                                                fit: BoxFit.scaleDown,
                                                                child: Text(
                                                                  "User Information",
                                                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                                                ),
                                                              ),
                                                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryColor),
                                                              onPressed: () {
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    TimeOfDay? time;
                                                                    DateTime? date;
                                                                    return StatefulBuilder(
                                                                      builder: (context, setState) {
                                                                        return AlertDialog(
                                                                          content: Column(
                                                                            textDirection: TextDirection.rtl,
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            children: [
                                                                              Text("name : " + patient.name!),
                                                                              Text("gender : " + patient.gender!),
                                                                              Text("dystrophy type : " + patient.dmoorType!),
                                                                              Text("height : " + patient.height!.toString()),
                                                                              Text("weight : " + patient.weight!.toString()),
                                                                              Text("age : " + patient.age!.toString()),
                                                                              Text("email : " + patient.email!),
                                                                              // Text("email : "+ patient.email!),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          )),
                                                          VerticalSpace(value: 1)
                                                        ],
                                                      );
                                                    }
                                                  },
                                                )),
                                                Expanded(
                                                    child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(child: Text(cubit.requests[index].dateTime.toString().substring(0, 10))),
                                                    Expanded(child: Text(cubit.requests[index].dateTime.toString().substring(11, 16))),
                                                  ],
                                                )),
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                            // Spacer(),
                            defaultHeader(
                              text: 'General Chat',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                              child: DefaultFormButton(
                                // fillColor: AppColors.secondaryColor,
                                textColor: AppColors.secondaryColor,
                                isBorder: true,
                                text: "Go To Chat Screen",
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ChatScreen(name: FirebaseAuth.instance.currentUser!.displayName!);
                                    },
                                  ));
                                },
                              ),
                            ),
                            const VerticalSpace(value: 2),
                            BlocListener<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is BookAddedSuccessState) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Uploaded Successfully')));
                                }
                              },
                              child: const SizedBox(),
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                );
              },
            ))
      ],
    );
    ;
  }
}
