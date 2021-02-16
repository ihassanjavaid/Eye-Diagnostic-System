class FundusResult {
  String isFundus;
  String result;
  String percentage;
  bool predicted;

  FundusResult({this.isFundus, this.result, this.percentage, this.predicted});

  FundusResult.fromJson(Map<String, dynamic> json) {
    isFundus = json['is_fundus'];
    result = json['result'];
    percentage = json['percentage'];
    predicted = json['predicted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_fundus'] = this.isFundus;
    data['result'] = this.result;
    data['percentage'] = this.percentage;
    data['predicted'] = this.predicted;
    return data;
  }
}