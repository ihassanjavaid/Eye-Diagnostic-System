import 'package:cached_network_image/cached_network_image.dart';
import 'package:eye_diagnostic_system/models/hospital_data.dart';
import 'package:eye_diagnostic_system/services/firestore_hospitals_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:eye_diagnostic_system/models/hospital_marker_data.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<HospitalMarker> firestoreMarkers = [];

  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 75.0;
  int hospsNum = 30;

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    staticMarksList = await getMarkersFromFirestoreMarkersList();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        foregroundColor: kScaffoldBackgroundColor,
        backgroundColor: kScaffoldBackgroundColor,
        onPressed: () async {

        },
        child: Icon(
          Icons.my_location_rounded,
          color: kTealColor,
          size: 32,
        ),
      ),*/
      body: SlidingUpPanel(
        maxHeight: _panelHeightOpen,
        minHeight: _panelHeightClosed,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight: Radius.circular(28.0)),
        panelBuilder: (scroller) => _buildBottomPanel(scroller),
        // panel: Center(
        //   child: Text("This is the sliding Widget"),
        // ),
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
              bottom: size.height/12 + 26,
              left: size.width/12 - 12,
              right: size.width/12 - 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FloatingActionButton(
                    heroTag: 'plus',
                    backgroundColor: kDiseaseIndicationColor,
                    onPressed: () {
                      // should be replaces with 1122 - for Pakistan
                      launch("tel://911");
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
                      if (initialMarks.isEmpty){
                        setState(() {
                          initialMarks = staticMarksList;
                        });
                      }
                      else {
                        setState(() {
                          initialMarks = [];
                        });
                      }
                    },
                    child: Icon(
                      Icons.my_location_rounded,
                      color: kTealColor,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Future<List<Marker>> getMarkersFromFirestoreMarkersList() async {
    firestoreMarkers = await _firestoreHospitalsService.getMarkers();

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
              child: Column(
                children: [
                  /*Text(
                    marker.name,
                    style: TextStyle(
                      color: kScaffoldBackgroundColor
                    ),
                  ),*/
                  Image.asset(
                    'assets/images/places/marker.png',
                  ),
                ],
              ),
            ),
      );

      markers.add(mark);
    }

    return markers;
  }

  Widget _buildBottomPanel(ScrollController scrollController){
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: scrollController,
          children: <Widget>[
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Explore Nearby Hospitals",
                  style: kBottomNavBarTextStyle
                ),
              ],
            ),
            SizedBox(height: 36.0),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("Popular", Icons.favorite, Colors.blue),
                _button("Food", Icons.restaurant, Colors.red),
                _button("Events", Icons.event, Colors.amber),
                _button("More", Icons.more_horiz, Colors.green),
              ],
            ),
            SizedBox(height: 36.0),*/
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: hospsNum,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Padding(
                          padding:
                          const EdgeInsets.only(top: 6.0),
                          child: CircleAvatar(
                            maxRadius: 15,
                            backgroundColor: kTealColor,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 4.0, left: 1.0),
                              child: Text((index + 1).toString(),
                                  style:
                                  kReminderBulletsTextStyle),
                            ),
                          ),
                        ),
                        title: Text(
                          firestoreMarkers[index].name,
                          style: kReminderMainTextStyle,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Column(
                            children: [
                              Text(
                                  firestoreMarkers[index].address,
                                  style: kReminderSubtitleTextStyle),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: /*Text(
                                  '${firestoreMarkers[index].rating}',
                                  style: kCustomInputLabelStyle.copyWith(
                                      fontStyle: FontStyle.italic,
                                  ),
                                ),*/
                                RatingBarIndicator(
                                  rating: double.parse(firestoreMarkers[index].rating),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kAmberColor,
                                  ),
                                  itemCount: 5,
                                  itemSize: 26.0,
                                  direction: Axis.horizontal,
                                ),
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.call,
                            color: kDiseaseIndicationColor,
                            size: 30.0,
                          ),
                          onPressed: () {
                            String phone = '+${firestoreMarkers[index].phone}';
                            launch("tel://$phone");
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 14.0),
                        child: Container(
                          height: 2.0,
                          width: double.infinity,
                          color: kTealColor.withOpacity(0.5),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            //SizedBox(height: 24)
          ],
        )
    );
  }

  Widget _button(String label, IconData icon, Color color){
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 8.0,
              )]
          ),
        ),

        SizedBox(height: 12.0,),

        Text(label),
      ],

    );
  }
}
