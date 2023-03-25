import 'package:amlelshefaa/app_router.dart';
import 'package:amlelshefaa/bloc/cubit/app_cubit.dart';
import 'package:amlelshefaa/core/constants/strings.dart';
import 'package:amlelshefaa/core/models/doctor.dart';
import 'package:amlelshefaa/core/models/exercise_model.dart';
import 'package:amlelshefaa/core/utils/app_colors.dart';
import 'package:amlelshefaa/core/utils/size_config.dart';
import 'package:amlelshefaa/core/widgets/custom_general_button.dart';
import 'package:amlelshefaa/core/widgets/space.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final String myId = FirebaseAuth.instance.currentUser!.uid;

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key, required this.exerciseModel}) : super(key: key);
  final ExerciseModel exerciseModel;

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  bool isDownloadingPdf = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xfff5b53f),
              expandedHeight: SizeConfig.screenHeight! / 1.8,
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              //title: Text(exerciseModel.name!),
              centerTitle: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.exerciseModel.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!),
                color: Colors.white,
                height: SizeConfig.defaultSize! * 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //   '${widget.exerciseModel.doctorUid}',
                    //   style: const TextStyle(
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20,
                    //   ),
                    //   maxLines: 2,
                    // ),
                    Expanded(
                        child: CustomGeneralButton(
                      callback: () async {
                        await FirebaseFirestore.instance.collection("doctors").where("id", isEqualTo: widget.exerciseModel.doctorUid).limit(1).get().then((value) {
                          Navigator.pushNamed(context, doctorScreen, arguments: Doctor.fromJson(value.docs.first.data()));
                        });
                      },
                      text: "doctor screen",
                    )),
                    HorizontalSpace(),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'هذا التمرين ل ${widget.exerciseModel.doctorCategory}',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  Container(
                    height: SizeConfig.screenHeight! * 0.8,
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.exerciseModel.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20),
            //       child: Container(
            //         color: Colors.black26,
            //         height: 60,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
