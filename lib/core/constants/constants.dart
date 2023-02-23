import 'package:amlelshefaa/core/models/exercise_model.dart';
import 'package:flutter/material.dart';

const SizedBox formVerticalDistance = SizedBox(height: 20.0);
bool value = false;
const TextStyle textStyleBig = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

final List<ExerciseModel> exercises = [
  for (int i = 0; i < 3; i++) ExerciseModel("الضمور العضلي الدوشين", "assets/pictures/dmoor/1_doshien.jpeg"),
  for (int i = 0; i < 5; i++) ExerciseModel("الوجه العضدى", "assets/pictures/dmoor/2_elwagh_el3addi.jpg"),
];
