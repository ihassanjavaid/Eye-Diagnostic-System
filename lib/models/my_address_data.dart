class MyAddressData {
  String type;
  List<double> query;
  List<Features> features;
  String attribution;

  MyAddressData({this.type, this.query, this.features, this.attribution});

  MyAddressData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    query = json['query'].cast<double>();
    if (json['features'] != null) {
      features = new List<Features>();
      json['features'].forEach((v) { features.add(new Features.fromJson(v)); });
    }
    attribution = json['attribution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['query'] = this.query;
    if (this.features != null) {
      data['features'] = this.features.map((v) => v.toJson()).toList();
    }
    data['attribution'] = this.attribution;
    return data;
  }
}

class Features {
  String id;
  String type;
  int relevance;
  String text;
  String placeName;


  Features({this.id, this.type, this.relevance, this.text, this.placeName});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    relevance = json['relevance'];
    text = json['text'];
    placeName = json['place_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['relevance'] = this.relevance;
    data['text'] = this.text;
    data['place_name'] = this.placeName;
    return data;
  }
}
