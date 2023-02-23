import 'package:amlelshefaa/core/models/doctor_model.dart';

import '../../../core/constants/constants.dart';
import 'custom_listview.dart';
import 'package:flutter/material.dart';

class TextWithListView extends StatelessWidget {
  const TextWithListView({Key? key, required this.books, required this.title}) : super(key: key);
  final List<DoctorModel> books;

  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: textStyleBig,
        ),
        books.isNotEmpty
            ? CustomListView(
                listOfDoctors: books,
              )
            : const Text('There is no items'),
      ],
    );
  }
}
