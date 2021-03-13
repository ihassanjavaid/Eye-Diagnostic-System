import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/models/hospital_data.dart';
import 'package:eye_diagnostic_system/utilities/global_methods.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:eye_diagnostic_system/models/hospital_marker_data.dart';

class FirestoreHospitalsService{
  static final _firestore = FirebaseFirestore.instance;
  final _firestoreForMarkers = FirebaseFirestore.instance;

  static Future<String> _loadFromAsset() async {
    return await rootBundle.loadString('assets/json/hospitals/hospitals-v1-json.json');
  }

  static Future<HospitalData> _parseJson() async {
    String jsonString = await _loadFromAsset();
    HospitalData hospitalData = HospitalData.fromJson(jsonDecode(jsonString));
    return hospitalData;
  }

  static Future push() async {
    HospitalData hospitals = await _parseJson();
    await checkInternConnection();

    for (var hosp in hospitals.hospitals){
      DocumentReference docRef = _firestore.collection('hospitals').doc();

      LatLong latLong = getLatLng(hosp.location);

      try {
        await docRef.set({
          'name': hosp.name,
          'latitude': latLong.l1,
          'longitude': latLong.l2,
          'address': hosp.address,
          'phone': hosp.phone,
          'rating': hosp.rating
        });
      }
      catch (err) {
        debugPrint(err.toString());
      }
    }

    debugPrint('=== Hospitals entered to FIRESTORE! ===');
  }

  static getLatLng(String coord){

    String lat = coord.substring(0, coord.indexOf(',')).replaceAll(',', '');
    String lon = coord.substring((coord.indexOf(' ') + 1), coord.length);

    return LatLong(lat, lon);
  }

  Future<List<HospitalMarker>> getMarkers() async{
    checkInternConnection();

    QuerySnapshot querySnapshot = await _firestoreForMarkers
        .collection('hospitals')
        .get();

    List<HospitalMarker> hospMarkers = [];

    for (var marker in querySnapshot.docs) {
      hospMarkers.add(
        HospitalMarker.fromMap(marker.data())
      );
    }

    return hospMarkers;
  }
}

class LatLong{
  final String l1;
  final String l2;

  LatLong(this.l1, this.l2);
}