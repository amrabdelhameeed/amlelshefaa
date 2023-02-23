// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class SameSizeCarousel extends StatelessWidget {
//    SameSizeCarousel({Key? key}) : super(key: key);
//   List<Color> colors = [
//     Colors.pink,
//     Colors.deepOrangeAccent,
//     Colors.amber.shade500,
//     Colors.red.shade900,
//     Colors.brown.shade400,
//     Colors.black87,
//     Colors.amber,
//     const Color(0xFFEF5350),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider.builder(
//         itemCount: category.length,
//         itemBuilder: (context, index, realIndex) => Stack(
//               alignment: AlignmentDirectional.center,
//               children: [
//                 Container(
//                   width: 180,
//                   decoration: BoxDecoration(color: colors[index], borderRadius: BorderRadius.circular(20)),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       category[index].categoryName,
//                       style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                       textAlign: TextAlign.center,
//                       maxLines: 3,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurStyle: BlurStyle.normal, blurRadius: 10, offset: const Offset(0, 10))],
//                       ),
//                       height: MediaQuery.of(context).size.height / 5,
//                       width: 100,
//                       child: Image(
//                         image: AssetImage(category[index].imagePath),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//         options: CarouselOptions(
//           height: MediaQuery.of(context).size.height / 3,
//           viewportFraction: 0.6,
//           autoPlay: true,
//           autoPlayAnimationDuration: const Duration(milliseconds: 600),
//         ));
//   }
// }
