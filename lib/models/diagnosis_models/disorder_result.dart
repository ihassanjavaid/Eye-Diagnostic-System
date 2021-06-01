class DisorderResult {
  String percentage;
  bool predicted;
  bool isEye;
  String result;

  DisorderResult({this.percentage, this.predicted, this.result, this.isEye});

  DisorderResult.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    predicted = json['predicted'];
    result = json['result'];
    isEye = json['is_eye'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percentage'] = this.percentage;
    data['predicted'] = this.predicted;
    data['result'] = this.result;
    return data;
  }
}