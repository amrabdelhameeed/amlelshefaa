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

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String gender = "Male";
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
                          color: Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // clipBehavior: Clip.antiAlias,
                        child: DropdownButton(
                          dropdownColor: Color(0xFFEFEFEF),
                          // add extra sugar..
                          iconSize: 42,
                          iconEnabledColor: Colors.black,
                          underline: const SizedBox(),
                          borderRadius: BorderRadius.circular(20),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black38,
                          ),
                          value: gender,
                          items: ["Male", "Female"]
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(color: Colors.black54),
                                  )))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {});
                              gender = value;
                            }
                          },
                        ),
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'Age',
                        controller: _ageController,
                        inputType: TextInputType.number,
                        validationText: 'Age can\'t be empty.',
                      ),
                      formVerticalDistance,

                      Row(
                        children: [
                          Expanded(
                            child: DefaultTextFormField(
                              hint: 'Weight',
                              controller: _weightController,
                              inputType: TextInputType.number,
                              validationText: 'Weight can\'t be empty.',
                            ),
                          ),
                          const HorizontalSpace(value: 2),
                          Expanded(
                            child: DefaultTextFormField(
                              hint: 'Height',
                              controller: _heightController,
                              inputType: TextInputType.number,
                              validationText: 'Height can\'t be empty.',
                            ),
                          )
                        ],
                      ),
                      const VerticalSpace(value: 2),
                      // const DefaultCheckBox(
                      //   checkInfo: 'accept term & conditions',
                      // ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is RegisterSuccessState) {
                            Navigator.pushReplacementNamed(context, homeLayout);
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
                                          await cubit.signUpWithEmailAndPassword(
                                            dmoorType: widget.type,
                                            age: int.parse(_ageController.text),
                                            gender: gender,
                                            height: double.parse(_heightController.text),
                                            weight: double.parse(_weightController.text),
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            name: _nameController.text,
                                            phone: _ageController.text,
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
