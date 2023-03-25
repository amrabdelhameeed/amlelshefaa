import 'package:amlelshefaa/core/models/doctor.dart';
import 'package:amlelshefaa/core/models/doctor_model.dart';
import 'package:amlelshefaa/features/home/widgets/doctorItem.dart';

import '../../../core/models/book_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  final List<Doctor> listOfDoctorModel;
  const CustomCarousel({Key? key, required this.listOfDoctorModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(listOfDoctorModel.length);
    return ConditionalBuilder(
      condition: listOfDoctorModel.isNotEmpty,
      builder: (context) => CarouselSlider.builder(
          itemCount: listOfDoctorModel.length,
          itemBuilder: (context, index, realIndex) => DoctorItem(doctorModel: listOfDoctorModel[index]),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height / 3,
            viewportFraction: 0.5,
            autoPlayInterval: Duration(seconds: 8),
            enlargeCenterPage: true,
            autoPlay: true,
          )),
      fallback: (context) => SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: const Center(
              child: CircularProgressIndicator(
            color: Color(0xfff5b53f),
          ))),
    );
  }
}
