// // Writen by BALY
// import 'package:flutter/material.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({Key? key}) : super(key: key);

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final colorButton = 0xFFF5B53F;

//   List<bool> isChecked = List.generate(9, (index) => false);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               'What genres are you interested in ?',
//               style: Theme.of(context).textTheme.headline4!.copyWith(
//                     color: Colors.black,
//                   ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text('What genres are you interested in What genres are you interested in ?', style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18, color: Colors.grey)),
//             const SizedBox(
//               height: 20,
//             ),
//             /*********Grid View ******** */
//             Expanded(
//               child: GridView.count(
//                 primary: false,
//                 physics: const BouncingScrollPhysics(),
//                 clipBehavior: Clip.hardEdge,
//                 crossAxisSpacing: 16,
//                 crossAxisCount: 3,
//                 children: [
//                   for (int i = 0; i < 9; i++)
//                     item2(
//                         context: context,
//                         text: 'BALY',
//                         image: 'assets/image/ph.jpg',
//                         isChecked: isChecked[i],
//                         fun: () {
//                           setState(() {
//                             isChecked[i] = !isChecked[i];
//                           });
//                         }),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               height: 3,
//               color: Colors.grey[350],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             /********* Verify Button ******** */
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 50),
//                 child: MaterialButton(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Color(colorButton))),
//                   color: Color(colorButton),
//                   onPressed: () {},
//                   elevation: 20,
//                   child: const Text(
//                     'Continue',
//                     style: TextStyle(fontSize: 20, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//       // body: ,
//     );
//   }
// }

// Widget item2({
//   required BuildContext context,
//   required String text,
//   required String image,
//   required bool isChecked,
//   required Function fun,
// }) {
//   return Stack(
//     children: [
//       Image(
//         image: AssetImage(image),
//       ),
//       Positioned(
//         right: 1 / 10,
//         top: 1 / 10,
//         child: IconButton(
//           splashRadius: 1,
//           iconSize: 28,
//           tooltip: 'select',
//           color: Colors.white,
//           onPressed: () {
//             fun();
//             // isChecked = !isChecked;
//           },
//           icon: Icon(
//             !isChecked ? Icons.check_box_outline_blank : Icons.check_box,
//           ),
//         ),
//       ),
//       Positioned(
//         left: 10,
//         bottom: 20,
//         child: Text(
//           text,
//           style: Theme.of(context).textTheme.headline6,
//         ),
//       ),
//     ],
//   );
// }
