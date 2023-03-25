// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:amlelshefaa/core/constants/constants.dart';
import 'package:amlelshefaa/core/constants/strings.dart';
import 'package:amlelshefaa/core/models/book_model.dart';
import 'package:amlelshefaa/core/models/doctor.dart';
import 'package:amlelshefaa/core/models/exercise_model.dart';
import 'package:amlelshefaa/core/models/request_model.dart';
import 'package:amlelshefaa/core/models/user_model.dart';
import 'package:amlelshefaa/core/utils/random_string.dart';
import 'package:amlelshefaa/features/home/home_screen.dart';
import 'package:amlelshefaa/features/home/home_screen_doctor.dart';
import 'package:amlelshefaa/features/home/widgets/add_book.dart';
import 'package:amlelshefaa/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

part 'app_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  bool isTechnical = false;
  late String verificationId;
  FirebaseAuth instance = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  File? bookImage;
  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.add;
  String dropdownValue = 'Biography';
  List<Widget> screenWidget = [
    HomeScreen(),
    const ProfileScreen(),
  ];
  List<Widget> screenWidgetDoctor = [
    HomeScreenDoctor(),
    const ProfileScreen(),
  ];
  Future<UserModel> getUserModelByOwnerUid(String uId) async {
    final futureData = await FirebaseFirestore.instance.collection('users').doc(uId).get();
    return UserModel.fromJson(futureData.data()!);
  }

  Future requestADoctor({required DateTime dateTime, required String doctorId}) async {
    print(userModel!.userUid!);
    await firestore.collection("requests").add(RequestModel(doctorId, userModel!.userUid!, dateTime).toJson()).then((value) {
      emit(RequestSuccessState());
    }).catchError((onError) {
      emit(RequestErrorState(onError.toString()));
    });
  }

  List<RequestModel> requests = [];
  Future getRequests() async {
    await firestore.collection("requests").where("doctorId", isEqualTo: doctor!.id).get().then((value) {
      requests = value.docs.map((e) => RequestModel.fromJson(e.data())).toList();
      print(requests);
      emit(GetRequestsSuccessState());
    }).catchError((onError) {
      emit(GetRequestsErrorState(onError.toString()));
    });
  }

  int curIndex = 0;
  void changeIndex(int index) {
    curIndex = index;
    // if (index == 1) {
    //   getCurrentFirestoreUser();
    // }
    emit(ChangeIndexState());
  }

  Future<void> signUpAsDoctorWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String dmoorType,
    required String address,
  }) async {
    instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      Doctor doctor = Doctor(
        value.user!.uid,
        name,
        email,
        address,
        phone,
        dmoorType,
        defaultPhoto,
      );
      emit(RegisterLoadingState());
      firestore.collection('doctors').doc(value.user!.uid).set(doctor.toJson()).then((value) {
        instance.currentUser!.updateDisplayName(name).then((value) {
          debugPrint("name updated");
        });
        instance.currentUser?.updateEmail(email).then((value) {
          debugPrint("email updated");
        });
        instance.currentUser?.updatePhotoURL(defaultPhoto).then((value) {
          debugPrint("photo updated");
          emit(RegisterSuccessState());
        });
        emit(RegisterSuccessState());
      }).catchError((onError) {
        emit(EmailauthError(onError.toString()));
        debugPrint("eltanya ha eltanya ${onError.toString()}");
      });
    }).catchError((onError) {
      debugPrint("eltanya ha eltanya ${onError.toString()}");
      emit(EmailauthError(onError.toString()));
    });
  }

  String excercisePhoto = "";

  Future<void> uploadExercisePhoto() async {
    emit(RegisterLoadingState());
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
      await firebase_storage.FirebaseStorage.instance.ref().child('exercises/${Uri.file(value!.path).pathSegments.last}').putFile(File(value.path)).then((p0) async {
        await p0.ref.getDownloadURL().then((photoLink) async {
          debugPrint(photoLink);
          excercisePhoto = photoLink;
          emit(PickPhotoLoadedState());
        }).then((value) {
          emit(BookAddedSuccessState());
        });
      });
    });
  }

  Future<void> uploadExercise({required String description}) async {
    emit(RegisterLoadingState());
    print(ExerciseModel(doctor!.id, excercisePhoto, description, doctor!.category).toJson());
    await firestore.collection("exercises").add(ExerciseModel(instance.currentUser!.uid, excercisePhoto, description, doctor!.category).toJson()).then((value) {
      excercisePhoto = "";
      emit(UploadExerciseSuccess());
    }).catchError((e) {
      emit(UploadExerciseError(e.toString()));
    });
  }

  Doctor? doctor;
  UserModel? userModel;
  Future<void> uploadDoctorPhoto() async {
    String photoUrl = defaultPhoto;
    emit(RegisterLoadingState());
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
      await firebase_storage.FirebaseStorage.instance.ref().child('doctors/${Uri.file(value!.path).pathSegments.last}').putFile(File(value.path)).then((p0) async {
        await p0.ref.getDownloadURL().then((photoLink) async {
          debugPrint(photoLink);
          photoUrl = photoLink;
          emit(PickPhotoLoadedState());
        }).then((value) {
          emit(BookAddedSuccessState());
        });
      });
    });

    await firestore.collection('doctors').doc(FirebaseAuth.instance.currentUser!.uid).update({"photoUrl": photoUrl}).then((value) {
      instance.currentUser?.updatePhotoURL(photoUrl).then((value) {
        debugPrint("photo updated");
        emit(PickPhotoLoadedState());
      });

      emit(RegisterSuccessState());
    }).catchError((onError) {
      emit(EmailauthError(onError.toString()));
      debugPrint("eltanya ha eltanya ${onError.toString()}");
    });
  }

  List<Doctor> doctors = [];

  Future<List<Doctor>> getDoctorsByCategory() async {
    doctors = [];
    if (isDoc == null) {
      await getCurrentFirestoreUser();
    }
    if (!isDoc!) {
      await firestore.collection('doctors').where('category', isEqualTo: userModel!.dmoorType).limit(10).get().then((value) {
        for (var element in value.docs) {
          print(element);
          doctors.add(Doctor.fromJson(element.data()));
        }
      });
      debugPrint(doctors.length.toString());
      emit(GetBooksSuccessState());
    }
    return doctors;
  }

  List<ExerciseModel> exercises = [];
  Future<List<ExerciseModel>> getExercises() async {
    exercises = [];
    if (isDoc == null) {
      await getCurrentFirestoreUser();
    }
    if (!isDoc!) {
      await firestore.collection('exercises').where('doctorCategory', isEqualTo: userModel!.dmoorType).limit(10).get().then((value) {
        for (var element in value.docs) {
          print(element);
          exercises.add(ExerciseModel.fromJson(element.data()));
        }
      });
      debugPrint(doctors.length.toString());
      emit(GetBooksSuccessState());
    }
    return exercises;
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String gender,
    required int age,
    required String dmoorType,
    required double weight,
    required double height,
  }) async {
    instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      UserModel userModel = UserModel(
        dmoorType: dmoorType,
        userUid: value.user!.uid,
        gender: gender,
        age: age,
        weight: weight,
        height: height,
        email: email,
        name: name,
      );
      emit(RegisterLoadingState());
      firestore.collection('users').doc(value.user!.uid).set(userModel.toJson()).then((value) {
        instance.currentUser!.updateDisplayName(name).then((value) {
          debugPrint("name updated");
        });
        instance.currentUser?.updateEmail(email).then((value) {
          debugPrint("email updated");
        });
        emit(RegisterSuccessState());
      }).catchError((onError) {
        emit(EmailauthError(onError.toString()));
        debugPrint("eltanya ha eltanya ${onError.toString()}");
      });
    }).catchError((onError) {
      debugPrint("eltanya ha eltanya ${onError.toString()}");
      emit(EmailauthError(onError.toString()));
    });
  }

  Future<void> updateName({
    required String name,
  }) async {
    if (isDoc == null) {
      await getCurrentFirestoreUser();
    }
    if (!isDoc!) {
      await firestore.collection('users').doc(getLoggedInUser().uid).update({'name': name}).then((value) {
        print('updateName success');
        instance.currentUser!.updateDisplayName(name).then((value) {
          debugPrint("name updated");
        });
        emit(EmailSubmitted());
        getCurrentFirestoreUser();
      }).catchError((onError) {
        print('error fe updateName');
      });
    } else {
      await firestore.collection('doctors').doc(getLoggedInUser().uid).update({'name': name}).then((value) {
        print('updateName success');
        instance.currentUser!.updateDisplayName(name).then((value) {
          debugPrint("name updated");
        });
        emit(EmailSubmitted());
        getCurrentFirestoreUser();
      }).catchError((onError) {
        print('error fe updateName');
      });
    }
  }

  Future<void> toggleSwitchOfBooks({required BookModel book, required bool val}) async {
    bool localIsValid = val;
    print(localIsValid);
    await firestore.collection('books').doc(book.bookId).update({'isValid': localIsValid}).then((value) {
      print('toggleSwitchOfBooks success');
      emit(EmailSubmitted());
    }).catchError((onError) {
      print('error fe toggleSwitchOfBooks');
    });
  }

  Future<void> deleteBook({required BookModel book}) async {
    await firestore.collection('books').doc(book.bookId).delete().then((value) {
      print('delete book state');
      emit(EmailSubmitted());
    }).catchError((onError) {
      print('error fe delete book');
    });
  }

  void requestAbook() async {}

  void vervicationFailed(FirebaseAuthException error) {
    debugPrint("vervicationFailed : ${error.toString()}");
    emit(PhoneauthError(error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    debugPrint("Code Sent");
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrivalTimeOut(String verificationId) {
    debugPrint("codeAutoRetrivalTimeOut");
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> logOut() async {
    await instance.signOut().then((value) {
      userModel = null;
      doctor = null;
      isDoc = null;
    });
  }

  Future<List<BookModel>> getSomeBooksByCategory({required String category, int? limit}) async {
    List<BookModel> books = [];
    await firestore.collection('books').where('category', isEqualTo: category).where('isValid', isEqualTo: true).limit(limit ?? 10).get().then((value) {
      for (var element in value.docs) {
        books.add(BookModel.fromJson(element.data()));
      }
    });
    debugPrint(books.length.toString());
    emit(GetBooksSuccessState());
    return books;
  }

  List<BookModel> reccomendedBooks = [];
  List<BookModel> fantasyInterstBooks = [];
  List<BookModel> fictionInterstBooks = [];
  List<BookModel> horrorInterstBooks = [];
  List<BookModel> novelInterstBooks = [];
  List<BookModel> studingInterstBooks = [];
  List<BookModel> technologyInterstBooks = [];

  void getHorrorBooks() async {
    getSomeBooksByCategory(category: 'horror').then((horrorBooks) {
      horrorInterstBooks = horrorBooks;
      emit(GetHorrorBooksState());
    });
  }

  void getTechnologyBooks() async {
    getSomeBooksByCategory(category: 'technology').then((technologyBooks) {
      technologyInterstBooks = technologyBooks;
      emit(GetTechnologyBooksState());
    });
  }

  void getFantasyBooks() async {
    getSomeBooksByCategory(category: 'fantasy').then((fantasyBooks) {
      fantasyInterstBooks = fantasyBooks;
      emit(GetFantasyBooksState());
    });
  }

  void getnovelBooks() async {
    getSomeBooksByCategory(category: 'novelInterst').then((novelBooks) {
      novelInterstBooks = novelBooks;
      emit(GetnovelBooksState());
    });
  }

  void getfictionBooks() async {
    getSomeBooksByCategory(category: 'scienceFiction').then((fictionBooks) {
      fictionInterstBooks = fictionBooks;
      emit(GetFictionBooksState());
    });
  }

  void getbiographyBooks() async {
    getSomeBooksByCategory(category: 'biography').then((studingBooks) {
      studingInterstBooks = studingBooks;
      emit(GetstudingBooksState());
    });
  }

  void goToHome() {
    changeIndex(0);
  }

  bool? isDoc;
  Future<bool> getCurrentFirestoreUser() async {
    if (instance.currentUser!.photoURL == null) {
      await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((value) async => {isDoc = false, print('fkn user : ${value['name']}'), userModel = UserModel.fromJson(value.data()!), emit(GetBooksSuccessState())});
    } else if (instance.currentUser!.photoURL != null) {
      await firestore
          .collection('doctors')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((value) async => {isDoc = true, print('fkn doc : ${value['photoUrl']}'), doctor = Doctor.fromJson(value.data()!), emit(GetBooksSuccessState())});
    }
    return isDoc!;
  }

  List<BookModel> userBooks = [];
  Future<List<BookModel>> getUserBook({required String userUid, bool? isMyBooks}) async {
    List<BookModel> books = [];
    isMyBooks!
        ? await firestore.collection('books').where('ownerUid', isEqualTo: userUid).get().then((value) {
            for (var element in value.docs) {
              books.add(BookModel.fromJson(element.data()));
            }
          })
        : await firestore.collection('books').where('ownerUid', isEqualTo: userUid).where('isValid', isEqualTo: true).get().then((value) {
            for (var element in value.docs) {
              books.add(BookModel.fromJson(element.data()));
            }
          });
    debugPrint(books.length.toString());
    return books;
  }

  void getUserBooks({String? uId}) async {
    print(instance.currentUser!.uid);
    getUserBook(userUid: uId ?? instance.currentUser!.uid, isMyBooks: uId == null).then((x) {
      userBooks = [];
      userBooks = x;
      print('books : ${userBooks.length}');
      emit(GetnovelBooksState());
    });
  }

  void addBook({
    required String category,
    required String name,
    required String authorName,
    required String bookLink,
    required String describtion,
  }) async {
    String? photoUrl;
    String bookId = RandomString.getRandomString(20);
    // emit(PickPhotoLoadingState());
    if (bookImage != null) {
      await firebase_storage.FirebaseStorage.instance.ref().child('books/${Uri.file(bookImage!.path).pathSegments.last}').putFile(bookImage!).then((p0) async {
        await p0.ref.getDownloadURL().then((photoLink) async {
          debugPrint(photoLink);
          photoUrl = photoLink;
          emit(PickPhotoLoadedState());
          BookModel bookModel = BookModel(
              ownerUid: instance.currentUser!.uid,
              category: category,
              picture: photoUrl,
              name: name,
              bookLink: bookLink,
              isPdf: bookLink.contains('.com') ? true : false,
              describtion: describtion,
              bookId: bookId,
              authorName: authorName);
          await firestore.collection('books').doc(bookId).set(bookModel.toJson());
        }).then((value) {
          emit(BookAddedSuccessState());
          bookImage = null;
        });
      });
    }
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      if (value.user!.photoURL == null) {
        firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) async => {
              print('name : ${value['name']}'),
            });
      } else {
        firestore.collection('doctors').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) async => {
              print('photoUrl : ${value['photoUrl']}'),
            });
      }
      emit(LogedInSuccessState());
    }).catchError((onError) {
      debugPrint("5ra error fe login ${onError.toString()}");
      emit(LoginErrorState(onError.toString()));
    });
  }

  User getLoggedInUser() {
    User firebaseUser = instance.currentUser!;
    return firebaseUser;
  }

  void bottomSheetShowState({required bool isShow, required IconData icon}) {
    isBottomSheetShow = isShow;
    fabIcon = icon;
    emit(AppChangeSheetShowState());
  }

  // void dropdownValueState({required String value}) {
  //   dropdownValue = value;
  //   emit(dropdownValueSheetShowState());
  // }
}
