class RequestModel {
  final String doctorId;
  final String patientId;
  final DateTime dateTime;
  RequestModel(this.doctorId, this.patientId, this.dateTime);
  factory RequestModel.fromJson(Map<String, dynamic> map) {
    return RequestModel(map["doctorId"], map["patientId"], DateTime.parse(map["dateTime"]));
  }
  toJson() => {"doctorId": doctorId, "patientId": patientId, "dateTime": dateTime.toString()};
}
