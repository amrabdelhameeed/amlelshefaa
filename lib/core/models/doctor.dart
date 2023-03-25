class Doctor {
  final String name;
  final String email;
  final String address;
  final String phone;
  final String category;
  final String photoUrl;
  final String id;
  bool? isPaid;
  Doctor(this.id, this.name, this.email, this.address, this.phone, this.category, this.photoUrl, [this.isPaid]);

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(json["id"], json["name"], json["email"], json["address"], json["phone"], json["category"], json["photoUrl"], false);
  }
  toJson() {
    return {"id": id, "name": name, "email": email, "address": address, "phone": phone, "category": category, "photoUrl": photoUrl};
  }
}
