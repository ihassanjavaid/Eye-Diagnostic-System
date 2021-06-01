import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eye_diagnostic_system/models/hospital_data.dart';
import 'package:eye_diagnostic_system/services/firestore_hospitals_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:eye_diagnostic_system/models/hospital_marker_data.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eye_diagnostic_system/services/external_map_service.dart';

class MapBoxMainScreen extends StatefulWidget {
  static const String id = 'map_box_main_screen';

  final double latitude;
  final double longitude;
  //final String currentLoc;

  const MapBoxMainScreen(
      {Key key, this.latitude, this.longitude/*, this.currentLoc*/})
      : super(key: key);

  @override
  _MapBoxMainScreenState createState() => _MapBoxMainScreenState();
}

class _MapBoxMainScreenState extends State<MapBoxMainScreen> {
  FirestoreHospitalsService _firestoreHospitalsService =
      FirestoreHospitalsService();
  List<Marker> initialMarks = [];
  List<Marker> staticMarksList = [];
  List<HospitalMarker> firestoreMarkers = [];
  IconData showMarkersIcon;

  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 75.0;
  int hospsNum = 1;

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
    showMarkersIcon = Icons.my_location_rounded;
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    staticMarksList = await getMarkersFromFirestoreMarkersList();
    setState(() {
      hospsNum = staticMarksList.length - 1;
    });
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
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0), topRight: Radius.circular(28.0)),
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
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/eyeseediagnostics/ckm6fhoeuc9f617o5ymjl9152/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZXllc2VlZGlhZ25vc3RpY3MiLCJhIjoiY2ttNmZkN3pvMG5wczJvcHIzNXM0dXMydiJ9.OHEYuFFxLxK0fzFlqPU7WQ",
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoiZXllc2VlZGlhZ25vc3RpY3MiLCJhIjoiY2ttNmZkN3pvMG5wczJvcHIzNXM0dXMydiJ9.OHEYuFFxLxK0fzFlqPU7WQ'
                },
              ),
              MarkerLayerOptions(
                markers: initialMarks,
              ),
            ],
          ),
          Positioned(
            bottom: size.height / 12 + 26,
            left: size.width / 12 - 30,
            right: size.width / 12 - 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarGlow(
                  endRadius: 48.0,
                  glowColor: kAmberColor,
                  showTwoGlows: true,
                  child: FloatingActionButton(
                    heroTag: 'call',
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
                ),
                SizedBox(
                  height: 20,
                ),
                FloatingActionButton(
                  heroTag: 'minus',
                  backgroundColor: kScaffoldBackgroundColor,
                  onPressed: () {
                    if (initialMarks.isEmpty) {
                      setState(() {
                        initialMarks = staticMarksList;
                        showMarkersIcon = Icons.clear;
                      });
                    } else {
                      setState(() {
                        initialMarks = [];
                        showMarkersIcon = Icons.my_location_rounded;
                      });
                    }
                  },
                  child: Icon(
                    showMarkersIcon,
                    color: kTealColor,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: size.width / 12 - 12,
            right: size.width / 12 - 12,
            top: size.height / 12,
            child: Column(
                children: [
              // Text(
              //     'Current Location:',
              //     style: kMapsMainTextStyle.copyWith(fontSize: 20, fontStyle: FontStyle.italic)),
              Text(
                'Nearby Medicos',
                  //widget.currentLoc,
                  style: kMapsMainTextStyle)
            ]
            ),
          )
        ],
      ),
    ));
  }

  Future<List<Marker>> getMarkersFromFirestoreMarkersList() async {
    firestoreMarkers = await _firestoreHospitalsService.getMarkers();

    List<Marker> markers = [];

    var firstMark = Marker(
      width: 60.0,
      height: 60.0,
      point: LatLng(widget.latitude, widget.longitude),
      builder: (ctx) => Container(
        child: Icon(
          Icons.person_pin_circle,
          color: kDiseaseIndicationColor,
          size: 80,
        ),
      ),
    );

    markers.add(firstMark);

    for (var marker in firestoreMarkers) {
      var mark = Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(
            double.parse(marker.latitude), double.parse(marker.longitude)),
        builder: (ctx) => Container(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  AlertWidget()
                      .generatePlaceDetailDialog(
                          context: context,
                          title: marker.name,
                          description: marker.address,
                          onCallTap: () {
                            String phone = '+${marker.phone}';
                            launch("tel://$phone");
                          },
                          onDirectionsTap: () {
                            ExternalMapService.openMap(marker.name);
                          })
                      .show();
                },
                child: Image.asset(
                  'assets/images/places/marker.png',
                ),
              ),
            ],
          ),
        ),
      );

      markers.add(mark);
    }

    return markers;
  }

  Widget _buildBottomPanel(ScrollController scrollController) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Column(
            // controller: scrollController,
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
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Explore Nearby Hospitals",
                      style: kBottomNavBarTextStyle),
                ],
              ),
              SizedBox(height: 36.0),
              Flexible(
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.65,
                  // width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: hospsNum,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: CircleAvatar(
                                    maxRadius: 15,
                                    backgroundColor: kTealColor,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0, left: 1.0),
                                      child: Text((index + 1).toString(),
                                          style: kReminderBulletsTextStyle),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            '${firestoreMarkers[index].name}\n',
                                        style: kReminderMainTextStyle,
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text:
                                                '${firestoreMarkers[index].address}\n',
                                            style: kReminderSubtitleTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    RatingBarIndicator(
                                      rating: double.parse(
                                          firestoreMarkers[index].rating),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: kAmberColor,
                                      ),
                                      itemCount: 5,
                                      itemSize: 26.0,
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  children: [
                                    FloatingActionButton(
                                      child: Icon(
                                        Icons.call,
                                        color: kScaffoldBackgroundColor,
                                        size: 24.0,
                                      ),
                                      onPressed: () {
                                        String phone =
                                            '+${firestoreMarkers[index].phone}';
                                        launch("tel://$phone");
                                      },
                                      backgroundColor: kDiseaseIndicationColor,
                                      mini: true,
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    FloatingActionButton(
                                      child: Icon(
                                        Icons.directions,
                                        color: kScaffoldBackgroundColor,
                                        size: 24.0,
                                      ),
                                      onPressed: () {
                                        ExternalMapService.openMap(
                                            firestoreMarkers[index].name);
                                      },
                                      backgroundColor: kTealColor,
                                      mini: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
              ),
            ],
          ),
        ));
  }
}
