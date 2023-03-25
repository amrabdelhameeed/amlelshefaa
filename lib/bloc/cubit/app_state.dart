part of 'app_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RequestSuccessState extends AuthState {}

class RequestErrorState extends AuthState {
  final String error;

  RequestErrorState(this.error);
}

class GetRequestsSuccessState extends AuthState {}

class GetRequestsErrorState extends AuthState {
  final String error;

  GetRequestsErrorState(this.error);
}

class LoginInitialState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  // final UserData userData;

  // LoginSuccessState(this.userData);
}

class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState(this.error);
}
/////////////////////////////////////////////////////////

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  // final RegisterModel userData;
  // RegisterSuccessState(this.userData);
}

class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState(this.error);
}

class UploadExerciseSuccess extends AuthState {}

class UploadExerciseError extends AuthState {
  final String error;

  UploadExerciseError(this.error);
}

class TechnicalUserSwitchState extends AuthState {}

class PhoneauthLoading extends AuthState {}

class PhoneauthError extends AuthState {
  final String error;

  PhoneauthError(this.error);
}

class PhoneNumberSubmitted extends AuthState {}

class OtpVerfied extends AuthState {}

class EmailauthError extends AuthState {
  final String error;
  EmailauthError(this.error);
}

class EmailSubmitted extends AuthState {}

class LogedInSuccessState extends AuthState {}

class GetBooksSuccessState extends AuthState {}

class GetUserByUidState extends AuthState {
  final UserModel userModel;

  GetUserByUidState(this.userModel);
}

class GetUserModelByUidState extends AuthState {
  final UserModel userModel;

  GetUserModelByUidState(this.userModel);
}

class ChangeIndexState extends AuthState {}

class GetRecommended extends AuthState {}

class GetUserBooks extends AuthState {}

class GetHorrorBooksState extends AuthState {}

class GetTechnologyBooksState extends AuthState {}

class GetnovelBooksState extends AuthState {}

class GetFictionBooksState extends AuthState {}

class GetstudingBooksState extends AuthState {}

class PickPhotoLoadingState extends AuthState {}

class GetFantasyBooksState extends AuthState {}

class PickPhotoLoadedState extends AuthState {}

class BookRequestedState extends AuthState {}

// class PickPhotoLoadingState extends AuthState{}
class BookAddedSuccessState extends AuthState {}

class AppChangeSheetShowState extends AuthState {}
