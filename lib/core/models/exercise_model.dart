class ExerciseModel {
  final String doctorUid;
  final String imagePath;
  final String description;
  final String doctorCategory;
  ExerciseModel(this.doctorUid, this.imagePath, this.description, this.doctorCategory);
  toJson() {
    return {"doctorUid": doctorUid, "imagePath": imagePath, "description": description, "doctorCategory": doctorCategory};
  }

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(json["doctorUid"], json["imagePath"], json["description"], json["doctorCategory"]);
  }
}
