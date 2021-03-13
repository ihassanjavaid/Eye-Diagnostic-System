import 'package:eye_diagnostic_system/models/hospital_data.dart';
import 'package:eye_diagnostic_system/services/firestore_hospitals_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:eye_diagnostic_system/models/hospital_marker_data.dart';

class MapBoxMainScreen extends StatefulWidget {
  static const String id = 'map_box_main_screen';

  final double latitude;
  final double longitude;

  const MapBoxMainScreen({Key key, this.latitude, this.longitude}) : super(key: key);

  @override
  _MapBoxMainScreenState createState() => _MapBoxMainScreenState();
}

class _MapBoxMainScreenState extends State<MapBoxMainScreen> {
  FirestoreHospitalsService _firestoreHospitalsService =
      FirestoreHospitalsService();
  List<Marker> initialMarks = [];
  List<Marker> staticMarksList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    staticMarksList = await getMarkersFromFirestoreMarkersList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: kScaffoldBackgroundColor,
        backgroundColor: kScaffoldBackgroundColor,
        onPressed: () async {
          initialMarks = await getMarkersFromFirestoreMarkersList();
          setState(() {});
        },
        child: Icon(
          Icons.my_location_rounded,
          color: kTealColor,
          size: 32,
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(widget.latitude, widget.longitude),
              zoom: 12.8,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://api.mapbox.com/styles/v1/eyeseediagnostics/ckm6fhoeuc9f617o5ymjl9152/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZXllc2VlZGlhZ25vc3RpY3MiLCJhIjoiY2ttNmZkN3pvMG5wczJvcHIzNXM0dXMydiJ9.OHEYuFFxLxK0fzFlqPU7WQ",
                additionalOptions: {
                  'accessToken' : 'pk.eyJ1IjoiZXllc2VlZGlhZ25vc3RpY3MiLCJhIjoiY2ttNmZkN3pvMG5wczJvcHIzNXM0dXMydiJ9.OHEYuFFxLxK0fzFlqPU7WQ'
                },
              ),
              MarkerLayerOptions(
                markers: initialMarks,
              ),
            ],
          ),
          Positioned(
            bottom: size.height/12 - 50,
            left: size.width/12 - 12,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloatingActionButton(
                  heroTag: 'plus',
                  backgroundColor: kDiseaseIndicationColor,
                  onPressed: () {
                  },
                  child: Icon(
                    Icons.call,
                    color: kScaffoldBackgroundColor,
                    size: 30.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FloatingActionButton(
                  heroTag: 'minus',
                  backgroundColor: kScaffoldBackgroundColor,
                  onPressed: () {
                  },
                  child: Icon(
                    Icons.list,
                    color: kTealColor,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<List<Marker>> getMarkersFromFirestoreMarkersList() async {
    List<HospitalMarker> firestoreMarkers = await _firestoreHospitalsService.getMarkers();

    List<Marker> markers = [];

    var firstMark = Marker(
      width: 60.0,
      height: 60.0,
      point: LatLng(widget.latitude, widget.longitude),
      builder: (ctx) =>
          Container(
            child: Icon(
              Icons.person_pin_circle,
              color: kDiseaseIndicationColor,
              size: 80,
            ),
          ),
    );

    markers.add(firstMark);

    for (var marker in firestoreMarkers){

      var mark = Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(double.parse(marker.latitude), double.parse(marker.longitude)),
        builder: (ctx) =>
            Container(
              child: Image.asset(
                'assets/images/places/marker.png',
              ),
            ),
      );

      markers.add(mark);
    }

    return markers;
  }
}
