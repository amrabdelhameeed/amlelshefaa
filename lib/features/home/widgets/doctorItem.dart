import 'package:amlelshefaa/core/models/doctor_model.dart';
import 'package:amlelshefaa/core/utils/size_config.dart';

import '../../../core/constants/strings.dart';
import 'package:flutter/material.dart';

class DoctorItem extends StatelessWidget {
  const DoctorItem({Key? key, required this.doctorModel}) : super(key: key);
  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pushNamed(context, bookScreen, arguments: doctorModel);
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
                  image: doctorModel.imagePath != ""
                      ? DecorationImage(
                          image: AssetImage(
                            doctorModel.imagePath,
                          ),
                          fit: BoxFit.fill,
                        )
                      : const DecorationImage(
                          image: AssetImage(
                            'assets/pictures/background/b.png',
                          ),
                        ),
                  borderRadius: BorderRadius.circular(13),
                ),
                height: 140,
              ),
            ),
            Text(
              doctorModel.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            Text(
              doctorModel.address.substring(10),
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
