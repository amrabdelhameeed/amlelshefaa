import 'package:amlelshefaa/bloc/cubit/app_cubit.dart';
import 'package:amlelshefaa/core/utils/size_config.dart';
import 'package:amlelshefaa/core/widgets/custom_general_button.dart';
import 'package:amlelshefaa/core/widgets/default_text_form_field.dart';
import 'package:amlelshefaa/core/widgets/space.dart';
import 'package:amlelshefaa/features/home/widgets/chat_screeen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadExercise extends StatelessWidget {
  UploadExercise({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize! * 2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            VerticalSpace(value: 4),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is UploadExerciseSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Exercise Uploaded")));
                  Navigator.pop(context);
                } else if (state is UploadExerciseError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                final cubit = AuthCubit.get(context);
                return Expanded(
                    child: GestureDetector(
                  onTap: () {
                    cubit.uploadExercisePhoto();
                  },
                  child: Center(
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      width: double.infinity,
                      height: double.infinity,
                      // color: Colors.black,
                      child: cubit.excercisePhoto.isEmpty
                          ? Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Add Excercise Photo"), Icon(Icons.add)],
                              ),
                            )
                          : Image.network(
                              cubit.excercisePhoto,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ));
              },
            ),
            VerticalSpace(value: 2),
            DefaultTextFormField(
              controller: textEditingController,
              maxLines: 7,
              hint: "description",
            ),
            VerticalSpace(value: 1),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final cubit = AuthCubit.get(context);

                return CustomGeneralButton(
                  text: "upload",
                  callback: () {
                    cubit.uploadExercise(description: textEditingController.text);
                  },
                );
              },
            ),
            VerticalSpace(value: 1),
          ],
        ),
      ),
    );
  }
}
