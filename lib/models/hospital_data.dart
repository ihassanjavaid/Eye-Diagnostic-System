class HospitalData {
  List<Hospitals> hospitals;

  HospitalData({this.hospitals});

  HospitalData.fromJson(Map<String, dynamic> json) {
    if (json['Hospitals'] != null) {
      hospitals = [];
      json['Hospitals'].forEach((v) {
        hospitals.add(new Hospitals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hospitals != null) {
      data['Hospitals'] = this.hospitals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hospitals {
  String name;
  String location;
  String address;
  String phone;
  String rating;

  Hospitals({this.name, this.location, this.address, this.phone, this.rating});

  Hospitals.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    location = json['Location'];
    address = json['Address'];
    phone = json['Phone'];
    rating = json['Rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Location'] = this.location;
    data['Address'] = this.address;
    data['Phone'] = this.phone;
    data['Rating'] = this.rating;
    return data;
  }
}
