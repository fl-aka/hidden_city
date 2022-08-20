import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'direction.dart';
import 'directions.dart';
import 'package:ta_uniska_bjm/utils/plainVar/text.dart';

class MainMap extends StatefulWidget {
  const MainMap({Key? key}) : super(key: key);

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
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
  Directions? _info;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Google Maps",
          style: TextStyle(
              color: Colors.white, fontFeatures: [FontFeature.enable('smcp')]),
        ),
        actions: [
          if (intialMark != null)
            TextButton(
                onPressed: () => googlecon!.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: intialMark!.position, zoom: 14.5, tilt: 50))),
                child: const Text(
                  "Origin",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w600),
                )),
          if (destination != null)
            TextButton(
                onPressed: () => googlecon!.animateCamera((_info != null)
                    ? CameraUpdate.newLatLngBounds(_info!.bounds!, 100)
                    : CameraUpdate.newCameraPosition(CameraPosition(
                        target: destination!.position, zoom: 14.5, tilt: 50))),
                child: const Text("Destination",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600)))
        ],
      ),
      body: StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
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
                        if (_info != null)
                          Positioned(
                              top: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                          blurRadius: 6)
                                    ]),
                                child: Text(
                                  '${_info!.eqDistance}, ${_info!.eqTime}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                        GoogleMap(
                          polylines: {
                            if (_info != null && _info!.polypoint != null)
                              Polyline(
                                  polylineId:
                                      const PolylineId('overview_polyline'),
                                  color: Colors.red,
                                  width: 5,
                                  points: _info!.polypoint!
                                      .map((e) =>
                                          LatLng(e.latitude, e.longitude))
                                      .toList())
                          },
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          onMapCreated: (con) => _onMapCreated(googlecon = con),
                          markers: {
                            marker,
                            intialMark != null ? intialMark! : marker,
                            destination != null ? destination! : marker
                          },
                          onLongPress: _addMarker,
                          initialCameraPosition: _bCbsPosition,
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () => googlecon!
            .animateCamera(CameraUpdate.newCameraPosition(_bCbsPosition)),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (intialMark == null || (intialMark != null && destination != null)) {
      setState(() {
        intialMark = Marker(
            markerId: const MarkerId('Origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: pos);
      });
      destination = null;
      _info = null;
    } else {
      setState(() {
        destination = Marker(
            markerId: const MarkerId('Destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos);
      });
      final directions = await DirectionRes()
          .getDirections(origin: intialMark!.position, destination: pos);
      setState(() => _info = directions);
    }
  }
}
