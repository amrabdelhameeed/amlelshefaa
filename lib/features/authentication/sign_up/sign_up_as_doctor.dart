import 'package:amlelshefaa/core/models/category_model.dart';

import '../../../bloc/cubit/app_cubit.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/default_check_box.dart';
import '../../../core/widgets/default_form_button.dart';
import '../../../core/widgets/default_text_form_field.dart';
import '../../../core/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ketabna/features/home/home_screen.dart';

class SignUpAsDoctorPage extends StatefulWidget {
  const SignUpAsDoctorPage({
    Key? key,
  }) : super(key: key);
  @override
  State<SignUpAsDoctorPage> createState() => _SignUpAsDoctorPageState();
}

class _SignUpAsDoctorPageState extends State<SignUpAsDoctorPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _category = "الضمور العضلي الدوشين";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // Updated by BALY
          iconTheme: const IconThemeData(
            color: AppColors.secondaryColor,
            size: 32,
          ),

          leading: IconButton(
            padding: const EdgeInsets.only(top: 20.0),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.secondaryColor,
              size: 22.0,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF242126),
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SFPro',
                        ),
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'First & Last Name',
                        controller: _nameController,
                        validationText: 'First & Last Name can\'t be empty.',
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'Email Address',
                        controller: _emailController,
                        inputType: TextInputType.emailAddress,
                        validationText: 'Email Address can\'t be empty.',
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'Password',
                        controller: _passwordController,
                        isPassword: true,
                        validationText: 'Password can\'t be empty.',
                      ),
                      formVerticalDistance,
                      Container(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 0.5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // clipBehavior: Clip.antiAlias,
                        child: DropdownButton(
                          dropdownColor: const Color(0xFFEFEFEF),
                          // add extra sugar..
                          iconSize: 42,
                          iconEnabledColor: Colors.black,
                          underline: const SizedBox(),
                          borderRadius: BorderRadius.circular(20),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black38,
                          ),
                          value: _category,
                          items: CategoryModel.categories
                              .map((e) => DropdownMenuItem<String>(
                                  value: e.categoryName,
                                  child: Text(
                                    e.categoryName,
                                    style: const TextStyle(color: Colors.black54),
                                  )))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {});
                              _category = value;
                            }
                          },
                        ),
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'address',
                        controller: _addressController,
                        inputType: TextInputType.streetAddress,
                        validationText: 'address can\'t be empty.',
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'phone',
                        controller: _phoneController,
                        inputType: TextInputType.phone,
                        validationText: 'phone can\'t be empty.',
                      ),
                      formVerticalDistance,

                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is RegisterSuccessState) {
                            Navigator.pushReplacementNamed(context, choosePhotoScreen);
                          }
                        },
                        builder: (context, state) {
                          var cubit = AuthCubit.get(context);
                          return Column(
                            children: [
                              state is RegisterLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.secondaryColor,
                                      ),
                                    )
                                  : DefaultFormButton(
                                      text: 'Sign Up',
                                      fontSize: 20,
                                      fillColor: AppColors.secondaryColor,
                                      textColor: Colors.white,
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          await cubit.signUpAsDoctorWithEmailAndPassword(
                                            address: _addressController.text,
                                            dmoorType: _category,
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            name: _nameController.text,
                                            phone: _phoneController.text,
                                          );
                                        }
                                      },
                                    ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '  Do you have account ? ',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          fontSize: 15,
                                        ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(context, loginScreen);
                                    },
                                    child: Text(
                                      'Sign In ',
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            fontSize: 20,
                                            color: AppColors.secondaryColor,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),

                      // DefaultFormButton(
                      //   text: 'Sign In',
                      //   onPressed: () {
                      //     Navigator.pushReplacementNamed(context, loginScreen);
                      //   },
                      // )
                    ],
                  )),
            ),
          ),
        ));
  }
}
