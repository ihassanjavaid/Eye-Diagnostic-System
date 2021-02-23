class DiseaseResult {
  String isEye;
  String isClosed;
  String result;
  String percentage;

  DiseaseResult({this.isEye, this.isClosed, this.result, this.percentage});

  DiseaseResult.fromJson(Map<String, dynamic> json) {
    isEye = json['is_eye'];
    isClosed = json['is_closed'];
    result = json['result'];
    percentage = json['percentage'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_eye'] = this.isEye;
    data['is_closed'] = this.isClosed;
    data['result'] = this.result;
    data['percentage'] = this.percentage;
    return data;
  }
}