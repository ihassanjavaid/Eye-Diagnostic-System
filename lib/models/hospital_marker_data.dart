class HospitalMarker {
  String name;
  String latitude;
  String longitude;
  String address;
  String phone;
  String rating;

  HospitalMarker(this.name, this.latitude, this.longitude,
      this.address, this.phone, this.rating);

  factory HospitalMarker.fromMap(Map<String, dynamic> map){

    return HospitalMarker(map['name'], map['latitude'], map['longitude'],
        map['address'], map['phone'], map['rating']);
  }
}