class DisorderResult {
  String percentage;
  bool predicted;
  String result;

  DisorderResult({this.percentage, this.predicted, this.result});

  DisorderResult.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    predicted = json['predicted'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percentage'] = this.percentage;
    data['predicted'] = this.predicted;
    data['result'] = this.result;
    return data;
  }
}