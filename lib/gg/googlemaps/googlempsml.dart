import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hidden_city/utils/plainVar/text.dart';

class SmlMap extends StatefulWidget {
  const SmlMap({Key? key}) : super(key: key);

  @override
  State<SmlMap> createState() => _SmlMapState();
}

class _SmlMapState extends State<SmlMap> {
  static var _bCbsPosition = const CameraPosition(
      target: LatLng(-3.4084847822080255, 114.84875678865988), zoom: 15);

  //late BitmapDescriptor mapMarker;

  late Marker marker;

  // void setMarker() async {
  //   mapMarker = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(), 'images/marker1600.png');
  // }

  static GoogleMapController? googlecon;
  Marker? intialMark;
  Marker? destination;
  Position zero = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  Future<Position> _getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error("");
      }
    }

    return Geolocator.getCurrentPosition().then((Position position) {
      return position;
    }).catchError((e) {
      debugPrint(e.toString());
      return zero;
    });
  }

  @override
  void initState() {
    super.initState();
    //setMarker();
  }

  @override
  void dispose() {
    if (googlecon != null) {
      googlecon!.dispose();
    }
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _getLocation().asStream(),
        builder: (context, snapshot) {
          return FutureBuilder<Position?>(
              future: _getLocation(),
              builder: (context, ss) {
                if (ss.hasData) {
                  marker = Marker(
                      markerId: const MarkerId('id-0'),
                      position: LatLng(ss.data!.latitude, ss.data!.longitude),
                      infoWindow: const InfoWindow(
                          title: 'You', snippet: "You're Here"));
                  _bCbsPosition = CameraPosition(
                      target: LatLng(ss.data!.latitude, ss.data!.longitude),
                      zoom: 15);
                  return Stack(
                    children: [
                      GoogleMap(
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        onMapCreated: (con) => _onMapCreated(googlecon = con),
                        markers: {
                          marker,
                          intialMark != null ? intialMark! : marker,
                          destination != null ? destination! : marker
                        },
                        initialCameraPosition: _bCbsPosition,
                      ),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () => googlecon!.animateCamera(
                                CameraUpdate.newCameraPosition(_bCbsPosition)),
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                                child: const Icon(
                                  Icons.gps_fixed,
                                  color: Colors.white,
                                )),
                          ))
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        });
  }
}
