// import 'dart:math';

// ignore_for_file: must_be_immutable

import 'package:amlelshefaa/app_router.dart';
import 'package:amlelshefaa/bloc/cubit/app_cubit.dart';
import 'package:amlelshefaa/core/constants/strings.dart';
import 'package:amlelshefaa/core/models/category_model.dart';
import 'package:amlelshefaa/core/models/doctor_model.dart';
import 'package:amlelshefaa/core/widgets/components.dart';
import 'package:amlelshefaa/core/widgets/default_form_button.dart';
import 'package:amlelshefaa/core/widgets/space.dart';
import 'package:amlelshefaa/features/home/widgets/chat_screeen.dart';
import 'package:amlelshefaa/features/home/widgets/custom_listview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/app_colors.dart';
import 'widgets/custom_shape.dart';
import 'widgets/customcarousel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var bookNameController = TextEditingController();
  var authorNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var category = CategoryModel.categories;
  // Future<void> _refresh(BuildContext context) async {
  //   print('refresh');
  //   // authCubit!
  //   //   // ..getCurrentFirestoreUser()
  //   //   ..getHorrorBooks()
  //   //   ..getTechnologyBooks()
  //   //   ..getFantasyBooks()
  //   //   ..getnovelBooks()
  //   //   ..getfictionBooks()
  //   //   ..getbiographyBooks();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>.value(
        value: authCubit!
          ..getDoctorsByCategory()
          ..getExercises(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                key: scaffoldKey,
                body: RefreshIndicator(
                  color: AppColors.secondaryColor,
                  onRefresh: () {
                    return Future.value();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                      var cubit = AuthCubit.get(context);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: const Color(0xfff5b53f),
                            height: MediaQuery.of(context).viewPadding.top,
                          ),
                          Stack(alignment: AlignmentDirectional.topStart, children: [
                            ClipPath(
                              clipper: CustomShape(),
                              child: Container(
                                height: 300,
                                width: double.infinity,
                                color: const Color(0xfff5b53f),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const VerticalSpace(value: 1),
                                defaultHeader(
                                  text: 'Doctors',
                                ),
                                const VerticalSpace(value: 2),
                                BlocBuilder<AuthCubit, AuthState>(
                                  builder: (context, state) {
                                    final cubit = AuthCubit.get(context);
                                    return CustomCarousel(listOfDoctorModel: cubit.doctors);
                                  },
                                )
                              ],
                            ),
                          ]),
                          const VerticalSpace(value: 1),
                          defaultHeader(text: "Exercises"),
                          const VerticalSpace(value: 1),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              final cubit = AuthCubit.get(context);
                              if (cubit.exercises.isNotEmpty) {
                                return CustomListView(exercises: cubit.exercises);
                              } else {
                                return Text("There is No Exercises");
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          /// Category
                          defaultHeader(
                            text: 'General Chat',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
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
                          VerticalSpace(value: 2),
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
              ),
            );
          },
        ));
  }
}
