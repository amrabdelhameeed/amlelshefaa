// import 'package:flutter/material.dart';
// import 'package:ketabna/core/utils/app_colors.dart';
// import 'package:ketabna/core/widgets/default_text_form_field.dart';

// class CustomBottomSheet extends StatefulWidget {
//   const CustomBottomSheet({Key? key, required this.formKey,required this.image}) : super(key: key);
//   final GlobalKey<FormState> formKey;
//   final String image;
//   @override
//   State<CustomBottomSheet> createState() => _CustomBottomSheetState();
// }

// class _CustomBottomSheetState extends State<CustomBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsetsDirectional.all(20),
//       height: MediaQuery.of(context).size.height * 2 / 3,
//       child: Form(
//         key: widget.formKey,
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 2 / 5,
//                     height: MediaQuery.of(context).size.height * 1 / 4,
//                     decoration: BoxDecoration(border: Border.all()),
//                     child: Center(
//                         child: 
//                              const Text("No image selected")),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Column(
//                     children: [
//                       MaterialButton(
//                           color: Colors.blue,
//                           child: const Text("Gallery",
//                               style: TextStyle(
//                                   color: Colors.white70,
//                                   fontWeight: FontWeight.bold)),
//                           onPressed: () {
//                             // pickImage();
//                           }),
//                       MaterialButton(
//                           color: Colors.blue,
//                           child: const Text("Camera",
//                               style: TextStyle(
//                                   color: Colors.white70,
//                                   fontWeight: FontWeight.bold)),
//                           onPressed: () {
//                             // pickImageC();
//                           }),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 1 / 3,
//                         child: DropdownButton<String>(
//                           value: cubit.dropdownValue,
//                           isExpanded: true,
//                           icon: const Icon(
//                             Icons.arrow_drop_down_circle_outlined,
//                             color: Color(0xFFF5B53F),
//                           ),
//                           elevation: 16,
//                           style: const TextStyle(color: Color(0xFFF5B53F)),
//                           underline: Container(
//                             height: 2,
//                             color: const Color(0xFFF5B53F),
//                           ),
//                           onChanged: (String? newValue) {
//                             cubit.dropdownValue = newValue!;
//                           },
//                           items: <String>[
//                             'Biography',
//                             'Children',
//                             'Fantasy',
//                             'Graphic Novels',
//                             'History',
//                             'Horror',
//                             'Romance',
//                             'Science Fiction'
//                           ].map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               DefaultTextFormField(
//                 hint: 'Book Name - اسم الكتاب',
//                 controller: bookNameController,
//                 validationText: 'Book name can\'t be empty.',
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               DefaultTextFormField(
//                 hint: 'author Name - اسم الكاتب ',
//                 controller: authorNameController,
//                 validationText: 'author name can\'t be empty.',
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 padding: const EdgeInsetsDirectional.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius:
//                       const BorderRadius.all(const Radius.circular(30)),
//                 ),
//                 child: TextField(
//                   maxLines: 10,
//                   controller: descriptionController,
//                   decoration: const InputDecoration.collapsed(
//                     hintText: "Write your description here - اكتب وصفك هنا ",
//                     hintStyle: TextStyle(
//                       color: AppColors.formFontColor,
//                     ),
//                   ),
//                   textAlignVertical: TextAlignVertical.center,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
