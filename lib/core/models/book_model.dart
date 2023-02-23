import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String? name;
  String? authorName;
  String? picture;
  bool? isValid;
  bool? isPdf = false;
  String? category;
  String? ownerUid;
  String? bookId;
  List? bookOwners;
  String? bookLink;
  String? describtion;

  BookModel({
    this.name,
    this.picture,
    this.isValid = true,
    this.isPdf = false,
    this.authorName,
    this.bookOwners,
    this.category,
    this.ownerUid,
    this.bookLink,
    this.describtion,
    this.bookId,
  });
  BookModel.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    authorName = map['authorName'];
    picture = map['picture'];
    isValid = map['isValid'];
    bookOwners = map['bookOwners'];
    isPdf = map['isPdf'];
    category = map['category'];
    ownerUid = map['ownerUid'];
    bookLink = map['bookLink'];
    bookId = map['bookId'];
    describtion = map['describtion'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'authorName': authorName,
      'picture': picture,
      'isValid': isValid,
      'isPdf': isPdf,
      'category': category,
      'ownerUid': ownerUid,
      'bookLink': bookLink,
      'bookOwners': bookOwners,
      'bookId': bookId,
      'describtion': describtion,
    };
  }

  List<BookModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap = snapshot.data() as Map<String, dynamic>;
      return BookModel(
        name: dataMap['name'],
        authorName: dataMap['authorName'],
        picture: dataMap['picture'],
        isValid: dataMap['isValid'],
        category: dataMap['category'],
        ownerUid: dataMap['ownerUid'],
        bookOwners: dataMap['bookOwners'],
        isPdf: dataMap['isPdf'],
        bookLink: dataMap['bookLink'],
        bookId: dataMap['bookId'],
        describtion: dataMap['describtion'],
      );
    }).toList();
  }
}
