class UserModel {
  String? gender;
  String? name;
  String? email;
  String? userUid;
  int? age;
  String? dmoorType;
  double? weight;
  double? height;
  UserModel({required this.dmoorType, required this.email, required this.name, required this.age, required this.weight, required this.height, required this.gender, required this.userUid});
  UserModel.fromJson(Map<String, dynamic> map) {
    email = map['email'];
    gender = map['gender'];
    name = map['name'];
    age = map['age'];
    dmoorType = map['dmoorType'];
    weight = map['weight'];
    height = map['height'];
    userUid = map['userUid'];
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'dmoorType': dmoorType,
      'name': name,
      'gender': gender,
      'userUid': userUid,
      'age': age,
      'weight': weight,
      'height': height,
    };
  }
}
