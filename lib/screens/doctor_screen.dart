import 'package:amlelshefaa/app_router.dart';
import 'package:amlelshefaa/bloc/cubit/app_cubit.dart';
import 'package:amlelshefaa/core/constants/strings.dart';
import 'package:amlelshefaa/core/models/doctor.dart';
import 'package:amlelshefaa/core/models/fake_screen_atg.dart';
import 'package:amlelshefaa/core/models/request_model.dart';
import 'package:amlelshefaa/core/utils/app_colors.dart';
import 'package:amlelshefaa/core/utils/size_config.dart';
import 'package:amlelshefaa/core/widgets/custom_general_button.dart';
import 'package:amlelshefaa/core/widgets/space.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

final String myId = FirebaseAuth.instance.currentUser!.uid;

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key, required this.doctorModel}) : super(key: key);
  final Doctor doctorModel;

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  bool isDownloadingPdf = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xfff5b53f),
              expandedHeight: SizeConfig.screenHeight! / 1.8,
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              //title: Text(doctorModel.name!),
              centerTitle: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.doctorModel.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                background: Image.network(
                  widget.doctorModel.photoUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                height: SizeConfig.defaultSize! * 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.doctorModel.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      widget.doctorModel.category,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                      maxLines: 2,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    !widget.doctorModel.isPaid!
                        ? const SizedBox()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: const Text(
                                      "address : ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    // height: SizeConfig.screenHeight! * 0.8,
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      widget.doctorModel.address,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                                    ),
                                  ))
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: const Text(
                                      "phone : ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    // height: SizeConfig.screenHeight! * 0.8,
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        _launchUrl("tel:${widget.doctorModel.phone}");
                                      },
                                      child: Text(
                                        widget.doctorModel.phone,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(color: AppColors.secondaryColor, fontSize: 20, fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: const Text(
                                      "email : ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    // height: SizeConfig.screenHeight! * 0.8,
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        final Uri params = Uri(
                                          scheme: 'mailto',
                                          path: widget.doctorModel.email,
                                        );
                                        _launchUrl(params.toString());
                                      },
                                      child: Text(
                                        widget.doctorModel.email,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(color: AppColors.secondaryColor, fontSize: 20, fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ))
                                ],
                              )
                            ],
                          ),
                    const VerticalSpace(value: 3),
                    widget.doctorModel.isPaid!
                        ? const SizedBox()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomGeneralButton(
                                text: "Request Information",
                                callback: () {
                                  Navigator.pushNamed(context, fakePaymentScreen, arguments: FakeScreenArgument(true, widget.doctorModel));
                                },
                              ),
                              const VerticalSpace(value: 1),
                            ],
                          ),
                    CustomGeneralButton(
                      text: "Book now",
                      callback: () {
                        Navigator.pushNamed(context, fakePaymentScreen, arguments: FakeScreenArgument(false, widget.doctorModel));
                      },
                    )
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.all(10.0),
                    //       child: Text(
                    //         "address : ",
                    //         textAlign: TextAlign.center,
                    //         style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                    //       ),
                    //     ),
                    //     Container(
                    //       height: SizeConfig.screenHeight! * 0.8,
                    //       padding: const EdgeInsets.all(10.0),
                    //       child: Text(
                    //         widget.doctorModel.address,
                    //         textAlign: TextAlign.center,
                    //         style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20),
            //       child: Container(
            //         color: Colors.black26,
            //         height: 60,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
