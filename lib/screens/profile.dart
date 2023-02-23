// Write by BALY

import 'package:amlelshefaa/app_router.dart';
import 'package:amlelshefaa/bloc/cubit/app_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/app_colors.dart';
import '../core/widgets/components.dart';
import '../features/on_boarding/sign_in_up_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>.value(
      value: authCubit!..getCurrentFirestoreUser(),
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              leading: Container(),
              actions: [
                TextButton(
                    onPressed: () {
                      cubit.logOut().then((value) {
                        cubit.changeIndex(0);
                        navigateAndFinish(context, SignInUPScreen());
                      });
                    },
                    child: const Text('Log Out')),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: const IconThemeData(
                color: AppColors.secondaryColor,
                size: 32,
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.userModel != null,
              builder: (context) {
                return Container(
                  padding: const EdgeInsetsDirectional.all(10),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cubit.userModel!.name ?? '',
                              maxLines: 1,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        TextEditingController controller = TextEditingController();
                                        return AlertDialog(
                                          actions: [
                                            Column(
                                              children: [
                                                textFormField(controller: controller..text = cubit.userModel!.name!, keyboardType: TextInputType.name, label: 'Edit Name'),
                                                TextButton(
                                                    onPressed: () {
                                                      cubit.updateName(name: controller.text).then((value) {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: const Text('save'))
                                              ],
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              fallback: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget buildItemBook({
    required BuildContext context,
    required String title,
    required String auther,
    required String image,
    required Function switchChange,
    bool isCheckedSwitch = false,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 20, start: 20, end: 20, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
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
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Positioned(
              child: Text(
                title,
                maxLines: 2,
                softWrap: true,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              left: 30,
              top: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Positioned(
              child: Text(
                'by $auther',
                maxLines: 2,
                softWrap: true,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              left: 30,
              top: 40,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20, top: 10, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image,
                  fit: BoxFit.fitHeight,
                  width: 70,
                  height: 110,
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 0,
              child: Switch(
                  value: isCheckedSwitch,
                  activeColor: AppColors.secondaryColor,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    switchChange(value);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
