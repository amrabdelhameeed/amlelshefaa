// import 'package:amlelshefaa/bloc/cubit/auth_cubit.dart';
// import 'package:amlelshefaa/core/models/book_model.dart';
// import 'package:amlelshefaa/core/models/user_model.dart';
// import 'package:amlelshefaa/core/widgets/default_form_button.dart';
// import 'package:amlelshefaa/features/home/widgets/DoctorItem.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../core/utils/app_colors.dart';
// import '../core/utils/shared_pref_helper.dart';
// import '../core/widgets/components.dart';

// String conversationDocId = '';
// final _firestore = FirebaseFirestore.instance;
// final String? myUid = FirebaseAuth.instance.currentUser?.uid.toString();
// final myName = SharedPrefHelper.getStr(key: 'userName');

// class VisitorScreen extends StatefulWidget {
//   const VisitorScreen({Key? key, required this.userModel}) : super(key: key);
//   final UserModel userModel;

//   @override
//   State<VisitorScreen> createState() => _VisitorScreenState();
// }

// class _VisitorScreenState extends State<VisitorScreen> {
//   Future<String> checkForOldConversation({bookOwnerUid, bookOwnerName, myId}) async {
//     String ids;
//     bool containUid_1 = false;
//     bool containUid_2 = false;
//     bool oldchat = false;
//     try {
//       await FirebaseFirestore.instance
//           .collection("chats")
//           .get()
//           .then((value) => {
//                 value.docs.forEach((element) async {
//                   ids = element.data()['ids'].toString();
//                   print('ids :' + ids);
//                   final numberOfMessagesOfChat = element.data()['messages'].length;
//                   containUid_1 = ids.contains(bookOwnerUid);
//                   containUid_2 = ids.contains(myId);

//                   if (containUid_1 && containUid_2) {
//                     oldchat = true;
//                     int bookOwnerReadMessages = element.data()['readed_messages'][bookOwnerUid];
//                     conversationDocId = element.id;
//                     await _firestore.collection('chats').doc(conversationDocId).update({
//                       'readed_messages': {
//                         '$myId': numberOfMessagesOfChat,
//                         '$bookOwnerUid': bookOwnerReadMessages,
//                       },
//                     });
//                   }
//                 })
//               })
//           .then((value) => {
//                 if (!oldchat) {setNewConversation(bookOwnerName: bookOwnerName, bookOwnerUid: bookOwnerUid)}
//               });
//     } catch (error) {
//       print(error.toString());
//     }

//     return conversationDocId;
//   }

//   Future setNewConversation({bookOwnerUid, bookOwnerName}) async {
//     String? myImage;
//     await _firestore.collection('users').doc(myUid).get().then((value) => {
//           myImage = value['picture'],
//         });

//     await _firestore.collection("chats").add(
//       {
//         'names': [bookOwnerName, myName],
//         'ids': [
//           bookOwnerUid,
//           myUid,
//         ],
//         'messages': [],
//         'images': {
//           // bookOwnerUid: widget.userModel.picture,
//           myUid: myImage,
//         },
//         'lastMessageTime': '',
//         'readed_messages': {
//           '$bookOwnerUid': 0,
//           '$myUid': 0,
//         },
//       },
//     ).then(
//       (documentSnapshot) => {
//         print("Added Data with ID: ${documentSnapshot.id}"),
//         conversationDocId = documentSnapshot.id,
//       },
//     );
//   }

//   Future<void> _makePhoneCall(String? phoneNumber) async {
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launchUrl(launchUri);
//   }

//   List<Map<String, Object>> itemBook = [
//     {'title': 'Book', 'image': 'assets/image/ph.jpg', 'description': 'My Book', 'isCheckedSwitch': false},
//     {'title': 'Book', 'image': 'assets/image/ph.jpg', 'description': 'My Book', 'isCheckedSwitch': false},
//     {'title': 'Book', 'image': 'assets/image/ph.jpg', 'description': 'My Book', 'isCheckedSwitch': false},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit, AuthState>(
//         builder: (context, state) {
//           var cubit = AuthCubit.get(context);
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0.0,
//               iconTheme: const IconThemeData(
//                 color: Color(0xFFF5B53F), // AppColors.secondaryColor
//                 size: 32,
//               ),
//             ),
//             body: SingleChildScrollView(
//               padding: const EdgeInsetsDirectional.all(10),
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 children: [
//                   // profile image

//                   const SizedBox(
//                     height: 15,
//                   ),
//                   // Name
//                   Text(
//                     widget.userModel.name!,
//                     maxLines: 1,
//                     softWrap: true,
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 28, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(
//                     height: 20,
//                   ),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Stack(
//                         alignment: AlignmentDirectional.centerEnd,
//                         children: [
//                           DefaultFormButton(onPressed: () {}, text: 'Call', width: 120, height: 35, radius: 10, padding: 10, textColor: Colors.white, fillColor: Colors.grey.shade600),
//                           const Icon(
//                             Icons.add_call,
//                             color: Colors.white,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         width: 30,
//                       ),
//                       DefaultFormButton(
//                         onPressed: () async {
//                           String ownerUid = widget.userModel.userUid.toString();
//                           String ownerName = '';
//                           await FirebaseFirestore.instance
//                               .collection('users')
//                               .doc(ownerUid)
//                               .get()
//                               .then(
//                                 (value) => {
//                                   print('ownerName :' + value['name']),
//                                   ownerName = value['name'],
//                                 },
//                               )
//                               .then((value) => {
//                                     checkForOldConversation(bookOwnerUid: ownerUid, myId: myUid, bookOwnerName: ownerName).then((value) => {
//                                           // navigateTo(
//                                           //     context: context,
//                                           //     widget: ChatScreen(
//                                           //       ownerName: ownerName,
//                                           //       ownerUid: ownerUid,
//                                           //       conversationDocId: value,
//                                           //     )),
//                                         })
//                                   });
//                         },
//                         text: 'Chat',
//                         width: 120,
//                         height: 35,
//                         radius: 10,
//                         padding: 10,
//                         textColor: Colors.white,
//                         fillColor: AppColors.secondaryColor,
//                       ),
//                     ],
//                   ),

//                   const SizedBox(
//                     height: 15,
//                   ),
//                   // text My books
//                   Text(
//                     'Books',
//                     style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),

//                   // item book
//                   Wrap(
//                     children: cubit.userBooks
//                         .map((e) => Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: DoctorItem(
//                                 bookModel: e,
//                               ),
//                             ))
//                         .toList(),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//         listener: (context, state) {});
//   }

//   Widget buildItem(BookModel bookModel) {
//     return Column(
//       // crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: bookModel.picture == null || bookModel.picture == ''
//                 ? const Text('')
//                 : Image.network(
//                     bookModel.picture!,
//                     fit: BoxFit.fill,
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height,
//                   ),
//           ),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Text(
//           bookModel.name ?? '',
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           softWrap: true,
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Text(
//           bookModel.name!,
//           style: Theme.of(context).textTheme.headline6!.copyWith(
//                 color: Colors.grey.shade700,
//                 fontSize: 18,
//               ),
//           softWrap: true,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     );
//   }
// }
