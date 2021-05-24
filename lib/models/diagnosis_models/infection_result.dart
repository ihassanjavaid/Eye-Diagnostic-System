class InfectionResult {
  String isEye;
  String result;
  String percentage;

  InfectionResult({this.isEye, this.result, this.percentage});

  InfectionResult.fromJson(Map<String, dynamic> json) {
    isEye = json['is_eye'];
    result = json['result'];
    percentage = json['percentage'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_eye'] = this.isEye;
    data['result'] = this.result;
    data['percentage'] = this.percentage;
    return data;
  }
}