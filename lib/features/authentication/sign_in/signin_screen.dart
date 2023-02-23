import '../../../bloc/cubit/app_cubit.dart';
import '../../../core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/components.dart';
import '../../../core/widgets/default_check_box.dart';
import '../../../core/widgets/default_form_button.dart';
import '../../../core/widgets/default_text_form_field.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: AppColors.secondaryColor,
            size: 32,
          ),
        ),
        body: Center(
          heightFactor: 1.3,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color(0xFF242126),
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SFPro',
                        ),
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'Email address',
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
                      const SizedBox(
                        height: 10.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is LogedInSuccessState) {
                            Navigator.pushReplacementNamed(context, homeLayout);
                          }
                        },
                        builder: (context, state) {
                          var cubit = AuthCubit.get(context);
                          if (state is LoginLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.secondaryColor,
                              ),
                            );
                          }
                          return DefaultFormButton(
                            text: 'Sign In',
                            fillColor: AppColors.secondaryColor,
                            textColor: Colors.white,
                            fontSize: 19.0,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.loginWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '  Do you not have account ?',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 15,
                                ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, categoryScreen);
                            },
                            child: Text(
                              'Sign Up ',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 20,
                                    color: AppColors.secondaryColor,
                                  ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ));
  }
}
