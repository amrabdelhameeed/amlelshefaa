import 'package:amlelshefaa/core/constants/strings.dart';
import 'package:amlelshefaa/core/models/doctor.dart';
import 'package:amlelshefaa/core/models/doctor_model.dart';
import 'package:amlelshefaa/core/models/exercise_model.dart';
import 'package:amlelshefaa/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({Key? key, required this.exerciseModel}) : super(key: key);
  final ExerciseModel exerciseModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pushNamed(context, exerciseScreen, arguments: exerciseModel);
      },
      child: SizedBox(
        height: SizeConfig.screenHeight! / 3,
        width: SizeConfig.defaultSize! * 14,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurStyle: BlurStyle.solid,
                      offset: Offset.fromDirection(1),
                      blurRadius: 2,
                      spreadRadius: 2,
                    )
                  ],
                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(exerciseModel.imagePath)),
                  borderRadius: BorderRadius.circular(13),
                ),
                height: 140,
              ),
            ),
            Text(
              exerciseModel.doctorCategory,
              style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w300),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
