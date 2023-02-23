import 'package:amlelshefaa/core/models/doctor_model.dart';
import 'package:amlelshefaa/features/home/widgets/doctorItem.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/models/book_model.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({Key? key, required this.listOfDoctors}) : super(key: key);
  final List<DoctorModel> listOfDoctors;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: listOfDoctors.isNotEmpty,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => DoctorItem(doctorModel: listOfDoctors[index]),
          separatorBuilder: (context, index) => const SizedBox(
            width: 10,
          ),
          itemCount: listOfDoctors.length,
        ),
      ),
      fallback: (context) => SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: const Center(
              child: CircularProgressIndicator(
            color: Color(0xfff5b53f),
          ))),
    );
  }
}
