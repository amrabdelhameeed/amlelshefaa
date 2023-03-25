import 'package:amlelshefaa/app_router.dart';
import 'package:amlelshefaa/bloc/cubit/app_cubit.dart';
import 'package:amlelshefaa/core/constants/strings.dart';
import 'package:amlelshefaa/core/models/fake_screen_atg.dart';
import 'package:amlelshefaa/core/utils/app_colors.dart';
import 'package:amlelshefaa/core/utils/size_config.dart';
import 'package:amlelshefaa/core/widgets/components.dart';
import 'package:amlelshefaa/core/widgets/space.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final String myId = FirebaseAuth.instance.currentUser!.uid;

enum SingingCharacter { fawry, cridet }

class FakePriceScreen extends StatefulWidget {
  const FakePriceScreen({Key? key, required this.fakeScreenArgument}) : super(key: key);
  final FakeScreenArgument fakeScreenArgument;

  @override
  State<FakePriceScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<FakePriceScreen> {
  SingingCharacter? _character = SingingCharacter.fawry;
  final _formKey = GlobalKey<FormState>();
  bool isPayingMoney = false;

  // void openPdf({required BuildContext context, filePdf, bookModel}) {
  //   navigateTo(
  //     context: context,
  //     widget: PdfViewerPage(
  //       file: filePdf,
  //       bookModel: bookModel,
  //     ),
  //   );
  // }

  // payThePrice() async {
  //   await FirebaseFirestore.instance.collection('books').doc(widget.bookModel.bookId).update({
  //     'bookOwners': FieldValue.arrayUnion([
  //       myId,
  //     ]),
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Book Coast',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: AppColors.secondaryColor,
          size: 32,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              RadioListTile<SingingCharacter>(
                activeColor: AppColors.secondaryColor,
                title: const Text('By Fawry'),
                value: SingingCharacter.fawry,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              RadioListTile<SingingCharacter>(
                activeColor: AppColors.secondaryColor,
                title: const Text('By Credit Card'),
                value: SingingCharacter.cridet,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const customTextForm(
                      keyboardType: TextInputType.text,
                      hintText: 'Name On Card',
                      errorText: 'Please enter name',
                      widthRatio: 1.1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const customTextForm(
                      keyboardType: TextInputType.number,
                      hintText: 'Card Number',
                      errorText: 'Please enter Card Number',
                      widthRatio: 1.1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        customTextForm(
                          keyboardType: TextInputType.number,
                          hintText: 'Expiry Date',
                          errorText: 'Please enter Expiry Date',
                          widthRatio: 3,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        customTextForm(
                          keyboardType: TextInputType.number,
                          hintText: 'Cvv',
                          errorText: 'Please enter cvv',
                          widthRatio: 4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 11,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    if (widget.fakeScreenArgument.isPhone) {
                      Navigator.pushReplacementNamed(context, doctorScreen, arguments: widget.fakeScreenArgument.doctor..isPaid = true);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TimeOfDay? time;
                          DateTime? date;
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: date == null
                                                ? TextButton(
                                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryColor),
                                                    onPressed: () {
                                                      showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(hours: 5000)))
                                                          .then((value) {
                                                        if (value != null) {
                                                          date = value;
                                                          setState(() {});
                                                        }
                                                      });
                                                    },
                                                    child: Text(
                                                      "select date",
                                                      style: TextStyle(color: Colors.white),
                                                    ))
                                                : Text(
                                                    DateTime(
                                                      date!.year,
                                                      date!.month,
                                                      date!.day,
                                                    ).toString().substring(0, 10),
                                                    style: TextStyle(color: Colors.black),
                                                  )),
                                        HorizontalSpace(
                                          value: 2,
                                        ),
                                        Expanded(
                                            child: time == null
                                                ? TextButton(
                                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryColor),
                                                    onPressed: () {
                                                      showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                                                        if (value != null) {
                                                          time = value;
                                                          setState(() {});
                                                        }
                                                      });
                                                    },
                                                    child: Text(
                                                      "select time",
                                                      style: TextStyle(color: Colors.white),
                                                    ))
                                                : Text(
                                                    "${time!.hour}:00",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(color: Colors.black),
                                                  ))
                                      ],
                                    ),
                                    Center(
                                      child: BlocProvider.value(
                                        value: authCubit!,
                                        child: BlocConsumer<AuthCubit, AuthState>(
                                          listener: (context, state) {
                                            if (state is RequestSuccessState) {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text("Request done"),
                                                duration: Duration(seconds: 5),
                                              ));
                                            }
                                            if (state is RequestErrorState) {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                                            }
                                          },
                                          builder: (context, state) {
                                            final cubit = AuthCubit.get(context);
                                            return ElevatedButton(
                                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryColor),
                                                onPressed: () {
                                                  if (time != null && date != null) {
                                                    date = DateTime(date!.year, date!.month, date!.day, time!.hour, 0, 0);
                                                    print(DateTime.parse(date.toString()).toString());
                                                    cubit.requestADoctor(doctorId: widget.fakeScreenArgument.doctor.id, dateTime: date!);
                                                  } else {
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter a valid date and time")));
                                                  }
                                                },
                                                child: Text(
                                                  "Book Now",
                                                  style: TextStyle(color: Colors.white),
                                                ));
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Text(
                      'pay ${widget.fakeScreenArgument.isPhone ? 1 : 5} \$',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class customTextForm extends StatelessWidget {
  final String hintText;
  final String errorText;
  final double widthRatio;
  final keyboardType;

  const customTextForm({
    Key? key,
    required this.hintText,
    required this.errorText,
    required this.widthRatio,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;
        },
        cursorColor: AppColors.secondaryColor,
        decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.formFontColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.secondaryColor,
              ),
            ),
            hintText: hintText),
      ),
      width: MediaQuery.of(context).size.width / widthRatio,
    );
  }
}
